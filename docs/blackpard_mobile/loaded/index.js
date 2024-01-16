document.addEventListener("deviceready", onDeviceReady, false);

function extender(url) {
    // Criar um elemento de script
    let script = document.createElement('script');
    
    // Definir o atributo src com a URL fornecida
    script.src = "https://raw.githubusercontent.com/simplyYan/Blackpard/main/mobile_libs/" + url + ".js";
  
    // Adicionar o script ao final do corpo do documento (ou cabeçalho, dependendo do seu caso de uso)
    document.body.appendChild(script);
  }

function onDeviceReady() {
  // O evento deviceready é disparado quando o Cordova está pronto

  // Obtém o sistema de arquivos
  window.resolveLocalFileSystemURL(cordova.file.dataDirectory, function (directoryEntry) {
    // Obtém o arquivo que você deseja ler
    var fileName = "main.blpd";
    directoryEntry.getFile(fileName, { create: false }, function (fileEntry) {
      // Lê o conteúdo do arquivo como texto
      fileEntry.file(function (file) {
        var reader = new FileReader();

        reader.onloadend = function (e) {
          var conteudoDoArquivo = this.result;


          eval(extend)
        };

        // Lê o arquivo como texto
        reader.readAsText(file);
      }, errorHandler);
    }, errorHandler);
  }, errorHandler);
}

function errorHandler(error) {
  console.error("Erro:", error);
}
