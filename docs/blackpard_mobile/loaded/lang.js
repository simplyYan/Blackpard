function vm(key, value) {
    this.key = key;
    this.value = value;
}

vm.prototype.WriteFile = function() {
    localStorage.setItem(this.key, this.value)
}

vm.prototype.ReadFile = function() {
    localStorage.getItem(this.key)
}

vm.prototype.RemoveFile = function() {
    localStorage.removeItem(this.key)
}

vm.prototype.ListAll = function() {
    const keys = [];
    for (let i = 0; i < localStorage.length; i++) {
        keys.push(localStorage.key(i));
    }
    return keys;
};

class NativeScraper {
    constructor() {}

    scrape(url) {
        return fetch(url)
            .then(response => response.text())
            .then(html => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, 'text/html');
                return doc;
            });
    }

    getTitle(doc) {
        return doc.querySelector('title').innerText;
    }

    getLinks(doc) {
        return Array.from(doc.querySelectorAll('a')).map(link => ({
            text: link.innerText,
            href: link.getAttribute('href')
        }));
    }

    getParagraphs(doc) {
        return Array.from(doc.querySelectorAll('p')).map(p => p.innerText);
    }
}

function string(variableName, value) {
    if (typeof value !== 'string') {
        terminal.log(`Error: The value assigned to "${variableName}" is not of type string.`);
        return;
    }

    if (window.hasOwnProperty(variableName)) {
        terminal.log(`Warning: The variable "${variableName}" has already been declared.`);
    }

    window[variableName] = value;
}

function int(variableName, value) {
    if (!Number.isInteger(value)) {
        terminal.log(`Error: The value assigned to "${variableName}" is not of type integer.`);
        return;
    }

    if (window.hasOwnProperty(variableName)) {
        terminal.log(`Warning: The variable "${variableName}" has already been declared.`);
    }

    window[variableName] = value;
}

function bool(variableName, value) {
    if (typeof value !== 'boolean') {
        terminal.log(`Error: The value assigned to "${variableName}" is not of type boolean.`);
        return;
    }

    if (window.hasOwnProperty(variableName)) {
        terminal.log(`Warning: The variable "${variableName}" has already been declared.`);
    }

    window[variableName] = value;
}

function float(variableName, value) {
    if (typeof value !== 'number' || isNaN(value) || !isFinite(value)) {
        terminal.log(`Error: The value assigned to "${variableName}" is not of type float.`);
        return;
    }

    if (window.hasOwnProperty(variableName)) {
        terminal.log(`Warning: The variable "${variableName}" has already been declared.`);
    }

    window[variableName] = value;
}

function echo(info) {
    alert(info)
}

function Using(usingUrl) {
var usingIt = document.createElement('script');

usingIt.src = usingUrl;

document.body.appendChild(usingIt);

}

function action(actionName, actionBody) {
    if (typeof actionName !== 'string' || typeof actionBody !== 'string') {
      throw new Error('Por favor, forneça uma string como nome e uma string como corpo da função.');
    }
  
    eval(`function ${actionName}() { ${actionBody} }`);
}

function maybe(conditions) {
    let matched = false;
    for (const { condition, action } of conditions) {
      if (condition()) {
        action();
        matched = true;
        break;
      }
    }
    if (!matched && conditions[conditions.length - 1].condition()) {
      conditions[conditions.length - 1].action();
    }
}


  Object.prototype.encryptData = async function(algorithm, key) {
    try {
      const encryptedData = await crypto.subtle.encrypt(algorithm, key, this);
      return encryptedData;
    } catch (error) {
      console.error('Erro ao criptografar dados:', error);
      return null;
    }
  };
  
  Object.prototype.decryptData = async function(algorithm, key) {
    try {
      const decryptedData = await crypto.subtle.decrypt(algorithm, key, this);
      return decryptedData;
    } catch (error) {
      console.error('Erro ao descriptografar dados:', error);
      return null;
    }
  };
  
  Object.prototype.generateEncryptionKey = async function(algorithm, extractable, keyUsages) {
    try {
      const key = await crypto.subtle.generateKey(algorithm, extractable, keyUsages);
      return key;
    } catch (error) {
      console.error('Erro ao gerar chave de criptografia:', error);
      return null;
    }
  };
  
  function _switch(value, ...cases) {
    let result;
    let fallthrough = false;
  
    for (let i = 0; i < cases.length; i++) {
      const [caseValue, action, shouldFallthrough] = cases[i];
  
      if (value === caseValue || fallthrough) {
        if (typeof action === 'function') {
          result = action();
        } else {
          result = action;
        }
  
        if (shouldFallthrough) {
          fallthrough = true;
        } else {
          break;
        }
      }
    }
  
    return result;
  }

  function handler(err, action) {
    if (err != null) {
      action();
    }
  }
  
  function panic(msg) {
    alert(msg)
    window.close()
  }

  var Pardface = {
    createPopup: function (initialHTML) {
        var popup = document.createElement('div');
        popup.classList.add('popup');
        let header = initialHTML.replace(".#", "<h1>")
        let header_close = header.replace(":.", "</h1>")
        let header2 = header_close.replace(".##", "<h2>")
        let header_close2 = header2.replace("::.", "</h2>")
        let header3 = header_close2.replace(".###", "<h3>")
        let header_close3 = header3.replace(":::.", "</h3>")
        let header4 = header_close3.replace(".####", "<h4>")
        let header_close4 = header4.replace("::::.", "</h4>")
        let p = header_close4.replace("[p]", "<p>")
        let p_close = p.replace("[!p]", "</p>")
        let a = p_close.replace("[addr]", "<a")
        let a_close = a.replace("[!addr]", "</a>")
        let btn = a_close.replace("[btn]", "<button")
        let btn_close = btn.replace("[!btn]", "</button>")
        let input = btn_close.replace("[input]", "<textarea")
        let input_close = input.replace("[!input]", "</textarea>")
        let img = input_close.replace("[img]", "<img")
        let img_close = img.replace("[!img]", "</img>")
        let finisher = btn_close.replace("!?", ">")
        

        popup.innerHTML = finisher;
        document.body.appendChild(popup);
        return popup;
    },

    openPopup: function (popup) {
        popup.style.display = 'block';
    },

    closePopup: function (popup) {
        popup.style.display = 'none';
    },

    addElementToPopup: function (popup, element) {
        popup.appendChild(element);
    },

    editPopupElement: function (popup, elementId, newText) {
        var element = popup.querySelector('#' + elementId);
        if (element) {
            element.innerText = newText;
        } else {
            console.error('Element not found in GUI.');
        }
    }
};

const Pardrunner = (func) => {
  const cache = new Map();

  return (...args) => {
    const key = JSON.stringify(args);

    if (cache.has(key)) {
      console.log('Returning the memoized value:', cache.get(key));
      return cache.get(key);
    } else {
      const result = func(...args);
      cache.set(key, result);
      console.log('Calculating and memoizing new value:', result);
      return result;
    }
  };
};

