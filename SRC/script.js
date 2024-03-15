var compil = localStorage.getItem("compiled")
if (compil == null) {
  console.log("skip it")
} else {
  Using(localStorage.getItem("compiled"))
}
// Terminal component (React)
class Terminal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      history: [] };


    this.handleKeyUp = this.handleKeyUp.bind(this);
  }

  handleKeyUp(e) {
    // If key was Enter key...
    if (event.keyCode == 13) {
      let input = e.target.value; // get current input val
      let split = input.split(' '); // split input by spaces

      e.target.value = ''; // clear prompt box
      this.log(input); // log input to terminal
      executeCommand(this, split.length, split);
    }
  }

  log(message) {
    this.setState(function (state, props) {
      return {
        history: [...state.history, message] };

    });
    let div = document.getElementById("terminal-body");
  }

  clear() {
    this.setState({
      history: [] });

  }

  render() {
    const history = this.state.history.map(entry => /*#__PURE__*/React.createElement("div", { class: "posted" }, entry));
    return /*#__PURE__*/(
      React.createElement("div", { id: "terminal" }, /*#__PURE__*/
      React.createElement("div", { id: "terminal-titlebar" }), /*#__PURE__*/

      React.createElement("div", { id: "terminal-body" },
      history, /*#__PURE__*/
      React.createElement("div", { id: "commandline" }, "C:\\>", /*#__PURE__*/
      React.createElement("input", { type: "text", class: "prompt", onKeyUp: this.handleKeyUp })))));




    div.scrollTop = div.scrollHeight; // scroll terminal to bottom
  }}


ReactDOM.render( /*#__PURE__*/React.createElement(Terminal, null), document.getElementById('App'));

// Auto-focus prompt on Click event
$('#terminal').on('click', function () {
  $('.prompt').focus();
});

// Auto-focus prompt input on Keydown event
$(document).keydown(function () {
  $(".prompt").focus();
});

var commands = {
  "help": "display the command list, or get help with a specific command. (syntax: 'help [argument]')",
  "clear": "clears everything from the console.",
  "color": "changes the color of the terminal text. (syntax: 'color [color]')",
  "bgcolor": "changes the background of the screen. (syntax: 'bgcolor [color]')",
  "wincolor": "changes the background of the screen. (syntax: 'wincolor [color]')",
  //"muffin": "Meow Meow Meow Meow Meow Meow Meow Meow Meow Meow",
  "dir": "displays the files contained in the database",
  "read": "displays the contents of a file (syntax: 'read [filename])",
  "write": "writes a file with the specified contents (syntax: 'write [filename] [contents]')",
  "del": "erases a file from the database (syntax: 'del [filename]')",
  "run": "interprets a stored file as javascript code (syntax: 'run [filename]')",
  "echo": "outputs directly to the terminal (syntax: 'echo [text]')",
  "rps": "Play a round of Rock, Paper, Scissors (syntax: 'rps [rock/paper/scissors]')" };


var files = {
  "hello.txt": "Hello world!",
  "nietzsche.txt": "To live is to suffer, to survive is to find some meaning in the suffering." };


// Read and return file contents
function readFile(fileName) {
  if (fileName in files) {
    return files[fileName];
  } else {
    console.log('file not found');
    throw new Error("File '" + fileName + "' not found.");
  }
};

function writeFile(name, contents) {
  console.log('writefile ' + name + ' ' + contents);
  files[name] = contents;
}

//runs the specified command or returns an error
function executeCommand(terminal, argc, argv) {
  switch (argv[0]) {
    case "clear":
      terminal.clear();
      console.clear();
      break;

    case "help":
      if (argc < 2) {
        terminal.log('commands: ' + Object.keys(commands).join(', '));
      } else {
        if (argv[1] in commands) {
          terminal.log(argv[1] + ": " + commands[argv[1]]);
        } else {
          terminal.log("Command '" + argv[1] + "' not recognized.");
        }
      }
      break;

    case "color":
      if (argc < 2) {
        terminal.log("Error: No color specified.");
      } else {
        terminal.log("Setting color to " + argv[1]);
        $("#terminal-body").css("color", argv[1]);
      }
      break;

    case "bgcolor":
      if (argc < 2) {
        terminal.log("Error: No color specified.");
      } else {
        terminal.log("Setting background color to " + argv[1]);
        $("#terminal-body").css("background-color", argv[1]);
      }
      break;

    case "wincolor":
      if (argc < 2) {
        terminal.log("Error: No color specified.");
      } else {
        terminal.log("Setting window color to " + argv[1]);
        $("body").css("background-color", argv[1]);
      }
      break;

    case "muffin":
      setInterval(function () {
        var muffins = "Meow ".repeat(Math.floor(Math.random() * 20));
        terminal.log(muffins);
      }, 1000);
      break;

    case "vm.dir":
      if (files.length < 1) {
        terminal.log("There are no files.");
      } else {
        let fileNames = Object.keys(files);
        terminal.log(fileNames.join(', '));
      }
      break;

    case "vm.read":
      try {
        terminal.log(readFile(argv[1]));
      } catch (e) {
        terminal.log(e.toString());
      }
      break;

    case "compile":
      terminal.log("Compiling project '" + argv[1] + "'...");
      localStorage.setItem("compiled", argv[1])
      Using(localStorage.getItem("compiled"))
      break;

    case "run":
      terminal.log("Executing project '" + argv[1] + "'...");
      Using(argv[1])
      
      break;

    case "del":
      localStorage.clear()
      break;

    case "echo":
      message = argv.slice(1).join(' ');
      terminal.log(message);
      break;

    case "rps":
      if (argc == 1) {
        terminal.log("No choice specified. (syntax: rps [rock/paper/scissors])");
        break;
      }

      playerChoice = argv[1].toLowerCase();
      terminal.log("You chose: " + playerChoice);

      let cpuChoice = Math.random();
      if (cpuChoice <= 0.33) cpuChoice = "rock";else
      if (cpuChoice <= 0.66) cpuChoice = "paper";else
      cpuChoice = "scissors";
      terminal.log("CPU chose: " + cpuChoice);

      switch (playerChoice) {
        case 'rock':
          if (cpuChoice === "rock") terminal.log("It's a tie!");else
          if (cpuChoice === "paper") terminal.log("CPU wins.");else
          terminal.log("You win!");
          break;
        case 'paper':
          if (cpuChoice === "paper") terminal.log("It's a tie!");else
          if (cpuChoice === "rock") terminal.log("You win!");else
          terminal.log("CPU wins.");
          break;
        case 'scissors':
          if (cpuChoice === "scissors") terminal.log("It's a tie!");else
          if (cpuChoice === "rock") terminal.log("CPU wins.");else
          terminal.log("You wins!");
          break;
        default:
          terminal.log("Invalid choice. (syntax: rps [rock/paper/scissors])");
          break;}

      break;

    default:
      terminal.log("Command '" + argv[0] + "' not recognized.");
      break;}

};

