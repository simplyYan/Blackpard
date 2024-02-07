#include "nw_content_browser_hooks.h"

// base
#include "base/command_line.h"
#include "base/files/file_util.h"
#include "base/logging.h"
#include "base/threading/thread_restrictions.h"
#include "base/strings/string_number_conversions.h"
#include "base/strings/utf_string_conversions.h"
#include "base/values.h"

// content
#include "content/public/browser/child_process_security_policy.h"
#include "content/public/browser/notification_service.h"
#include "content/public/browser/notification_types.h"
// #include "content/public/browser/plugin_service.h"
#include "content/public/browser/render_process_host.h"
#include "content/public/browser/render_view_host.h"
#include "content/public/renderer/v8_value_converter.h"
#include "content/public/browser/child_process_termination_info.h"

// content/nw
#include "content/nw/src/nw_base.h"
#include "content/nw/src/common/shell_switches.h"

#include "net/cert/x509_certificate.h"

// ui
#include "ui/base/resource/resource_bundle.h"
#include "ui/base/ui_base_types.h"
#include "ui/gfx/image/image.h"
#include "ui/gfx/image/image_skia_rep.h"
#include "ui/gfx/codec/png_codec.h"

// gen
#include "nw/id/commit.h"

#include "third_party/node-nw/src/node_webkit.h"

#if defined(OS_WIN)
#define _USE_MATH_DEFINES
#include <math.h>
#endif

using content::RenderProcessHost;

namespace content {
  class WebContents;
}

namespace nw {

namespace {

bool g_pinning_renderer = true;
bool g_mixed_context = false;
bool g_in_webview_apply_attr = false;
bool g_in_webview_apply_attr_allow_nw = false;
} //namespace

#if defined(OS_MAC)
typedef void (*SendEventToAppFn)(const std::string& event_name, const base::Value::List& event_args);
CONTENT_EXPORT SendEventToAppFn gSendEventToApp = nullptr;

bool GetDirUserData(base::FilePath*);

void SetTrustAnchors(net::CertificateList&);
#endif
// browser

bool GetPackageImage(nw::Package* package,
                     const FilePath& icon_path,
                     gfx::Image* image) {
  FilePath path = package->ConvertToAbsoutePath(icon_path);

  // Read the file from disk.
  std::string file_contents;
  if (path.empty() || !base::ReadFileToString(path, &file_contents))
    return false;

  // Decode the bitmap using WebKit's image decoder.
  const unsigned char* data =
      reinterpret_cast<const unsigned char*>(file_contents.data());
  std::unique_ptr<SkBitmap> decoded(new SkBitmap());
  // Note: This class only decodes bitmaps from extension resources. Chrome
  // doesn't (for security reasons) directly load extension resources provided
  // by the extension author, but instead decodes them in a separate
  // locked-down utility process. Only if the decoding succeeds is the image
  // saved from memory to disk and subsequently used in the Chrome UI.
  // Chrome is therefore decoding bitmaps here that were generated by Chrome.
  gfx::PNGCodec::Decode(data, file_contents.length(), decoded.get());
  if (decoded->empty())
    return false;  // Unable to decode.

  *image = gfx::Image::CreateFrom1xBitmap(*decoded);
  return true;
}

void MainPartsPostDestroyThreadsHook() {
  ReleaseNWPackage();
}

void RendererProcessTerminatedHook(content::RenderProcessHost* process,
                                   const content::ChildProcessTerminationInfo& info) {
  int exit_code = info.exit_code;
#if defined(OS_POSIX)
  if (WIFEXITED(exit_code))
    exit_code = WEXITSTATUS(exit_code);
#endif
  SetExitCode(exit_code);
}

bool GetImage(Package* package, const FilePath& icon_path, gfx::Image* image) {
  FilePath path = package->ConvertToAbsoutePath(icon_path);

  // Read the file from disk.
  std::string file_contents;
  if (path.empty() || !base::ReadFileToString(path, &file_contents))
    return false;

  // Decode the bitmap using WebKit's image decoder.
  const unsigned char* data =
      reinterpret_cast<const unsigned char*>(file_contents.data());
  std::unique_ptr<SkBitmap> decoded(new SkBitmap());
  // Note: This class only decodes bitmaps from extension resources. Chrome
  // doesn't (for security reasons) directly load extension resources provided
  // by the extension author, but instead decodes them in a separate
  // locked-down utility process. Only if the decoding succeeds is the image
  // saved from memory to disk and subsequently used in the Chrome UI.
  // Chrome is therefore decoding bitmaps here that were generated by Chrome.
  gfx::PNGCodec::Decode(data, file_contents.length(), decoded.get());
  if (decoded->empty())
    return false;  // Unable to decode.

  *image = gfx::Image::CreateFrom1xBitmap(*decoded);
  return true;
}

#if defined(OS_MAC)
CONTENT_EXPORT bool ApplicationShouldHandleReopenHook(bool hasVisibleWindows) {
  base::Value::List arguments;
  if (gSendEventToApp)
    gSendEventToApp("nw.App.onReopen", arguments);
  return true;
}

CONTENT_EXPORT void OSXOpenURLsHook(const std::vector<GURL>& startup_urls) {
  base::Value::List arguments;
  for (size_t i = 0; i < startup_urls.size(); i++)
    arguments.Append(startup_urls[i].spec());
  if (gSendEventToApp)
    gSendEventToApp("nw.App.onOpen", arguments);
}
#endif

void OverrideWebkitPrefsHook(content::WebContents* web_contents, blink::web_pref::WebPreferences* web_prefs) {
  nw::Package* package = nw::package();
  if (!package)
    return;
  base::Value::Dict* webkit = package->root()->FindDict(switches::kmWebkit);
  web_prefs->plugins_enabled = true;
  if (webkit) {
    absl::optional<bool> flag = webkit->FindBool("double_tap_to_zoom_enabled");
    if (flag)
      web_prefs->double_tap_to_zoom_enabled = *flag;
    flag = webkit->FindBool("plugin");
    if (flag)
      web_prefs->plugins_enabled = *flag;
  }
#if 0
  FilePath plugins_dir = package->path();

  plugins_dir = plugins_dir.AppendASCII("plugins");

  content::PluginService* plugin_service = content::PluginService::GetInstance();
  plugin_service->AddExtraPluginDir(plugins_dir);
#endif
}

#if 0
bool ShouldServiceRequestHook(int child_id, const GURL& url) {
  RenderProcessHost* rph = RenderProcessHost::FromID(child_id);
  if (!rph)
    return false;
  return RphGuestFilterURLHook(rph, &url);
}
#endif

bool PinningRenderer() {
  return g_pinning_renderer;
}

void SetPinningRenderer(bool pin) {
  g_pinning_renderer = pin;
}

bool MixedContext() {
  return g_mixed_context;
}

void SetMixedContext(bool mixed) {
  g_mixed_context = mixed;
}

void SetInWebViewApplyAttr(bool flag, bool allow_nw) {
  g_in_webview_apply_attr = flag;
  g_in_webview_apply_attr_allow_nw = allow_nw;
}

bool GetInWebViewApplyAttr(bool* allow_nw) {
  if (allow_nw)
    *allow_nw = g_in_webview_apply_attr_allow_nw;
  return g_in_webview_apply_attr;
}

} //namespace nw
