const MAX_TABS = 10;

function removeCookiesOnWindowClosed(windowId) {
  chrome.cookies.getAll({}, (cookies) => {
    for (let cookie of cookies) {
      chrome.cookies.remove({
        url: "http" + (cookie.secure ? "s" : "") + "://" + cookie.domain + cookie.path,
        name: cookie.name
      });
    }
  });
}

function clearBrowsingDataOnWindowClosed(windowId) {
  chrome.browsingData.remove({
    "since": 0
  }, {
    "appcache": true,
    "cache": true,
    "cookies": false,
    "downloads": true,
    "fileSystems": true,
    "formData": true,
    "history": true,
    "indexedDB": true,
    "localStorage": true,
    "pluginData": true,
    "passwords": true,
    "serviceWorkers": true,
    "webSQL": true
  });
}

function reduceProcessesOnWindowClosed(windowId) {
  chrome.system.cpu.getInfo((info) => {
    const numCores = info.numOfProcessors;
    const maxProcesses = Math.ceil(numCores * 1.5); 

    chrome.system.cpu.getInfo((processesInfo) => {
      const numProcesses = processesInfo.processors.length;
      if (numProcesses > maxProcesses) {
        chrome.system.cpu.setNumberOfProcessors(maxProcesses);
      }
    });
  });
}

chrome.windows.onRemoved.addListener((windowId) => {
  removeCookiesOnWindowClosed(windowId);
  clearBrowsingDataOnWindowClosed(windowId);
  disableExtensionsOnWindowClosed(windowId);
  reduceProcessesOnWindowClosed(windowId);
});

chrome.tabs.onCreated.addListener((tab) => {
  chrome.tabs.query({}, (tabs) => {
    if (tabs.length > MAX_TABS) {
      chrome.tabs.remove(tab.id);
    }
  });
});