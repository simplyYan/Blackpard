![Blackpard Lang](https://raw.githubusercontent.com/simplyYan/Blackpard/main/Banner.png)

- Index: 1. [How to install](https://github.com/simplyYan/Blackpard#how-to-install)
       2. [Using the compiler](https://github.com/simplyYan/Blackpard#how-to-install)
       3. [IDE](https://github.com/simplyYan/Blackpard#how-to-install)
       4. [Using Pardpackage](https://github.com/simplyYan/Blackpard#how-to-install)
       5. [Docs](https://github.com/simplyYan/Blackpard#how-to-install)
       6. [Features](https://github.com/simplyYan/Blackpard#how-to-install)
       7. [License](https://github.com/simplyYan/Blackpard#how-to-install)
       8. [Contribute](https://github.com/simplyYan/Blackpard#how-to-install)

Blackpard is a high-level compiled language that is fast, light, easy, secure and broad.
HERE'S AN EXAMPLE USING BLACKPARD'S **LOW LEVEL**:
```
st = extends('./simple_time.so')  //Importing built-in libraries
lib = extends('./pvm.so')
//WARNING: In Windows it is DLL not OS. On Linux and macOS it's .so

lib.pvm.argtypes = [ctypes.CFUNCTYPE(ctypes.c_int, ctypes.c_int), ctypes.c_int]
lib.pvm.restype = ctypes.c_int

//Defines function return types
st.c_start_timer.restype = None
st.c_elapsed_time.restype = ctypes.c_double

//Calls the function to start the timer
st.c_start_timer()

@ctypes.CFUNCTYPE(ctypes.c_int, ctypes.c_int)
action fibonacci(n):
    fib_sequence = []
    .string a, b = 0, 1
    for _ in range(n):
        fib_sequence.append(a)
        a, b = b, a + b
    return fib_sequence

//Example: generating the first 55 numbers of the Fibonacci sequence
.string result = lib.pvm(fibonacci, 55)
print("Result from memoized cache:", result)

echo(f"The first 55 numbers in the Fibonacci sequence are: {result}")
//Calculates elapsed time
.float elapsed_time = st.c_elapsed_time()
echo("Time elapsed:", elapsed_time, "seconds")

//Output: The first 55 numbers in the Fibonacci sequence are: 8618016
//Time elapsed: 7.9e-05 seconds (79 microseconds)
//The test was carried out in Parrot OS (Linux) on an i7 3770.
//Results in other languages: Go = 527.819202ms, JS = 1650ms,
//C++ = 2790ms, C = 1.489798s, Rust = 1048ms, Swift = 694.388
//Ruby = 14356.714772ms, Pascal = 1087, 
```
Blackpard's low level may be a little more difficult, but it's faster. Blackpard's low level is provided by primitive libraries such as "simple_time" and "PardVM". Now take a look at a high-level example:
```
action execFib():
  fib = extends("./fibonacci.so")
  fib.main() //Result: The 55th term of the Fibonacci sequence is: 139583862445

echo("Running Fibonacci...")
execFib() //Execution time: 0.000002
//This Fibonacci is faster because it uses Blackpard's "fibonacci" standard library,
//which is written entirely in C and uses advanced techniques such as memoize;
```

## How to install
### macOS
Blackpard can be installed using weepsbox, a tool I developed to install and run small, single-file Python packages. First, look at the macOS requirements:

- Python >= 3.8.12

- Windows, Linux or macOS versions released after 2016

- wget and curl

Now, if you have the requirements, just use a command in the terminal to install. Check it out:
```
wget https://raw.githubusercontent.com/simplyYan/weepsbox/main/mac.weepsbox.sh
chmod 777 mac.weepsbox.sh
./mac.weepsbox.sh https://raw.githubusercontent.com/simplyYan/Blackpard/main/SRC/blackpard.py
```
### Windows
On Windows, Blackpard is pre-built and can be downloaded via Google Drive or Mediafire. Download from the mirrors:
- Google Drive: https://drive.google.com/drive/folders/1t58SoeDt2-m2A0PzZpx_1wkCsmN23cOe?usp=sharing
- Mediafire: https://www.mediafire.com/file/vjsnp1zrdux8jkj/blackpard_win.zip/file
- Instructions: https://github.com/simplyYan/Blackpard/blob/main/windows_instructions

### Linux
On Linux, Blackpard is pre-built and can be downloaded via Google Drive or Mediafire. Download from the mirrors:
- Google Drive: https://drive.google.com/drive/folders/1DsU1dZFnXwxQZMNPcUIm2XQPGtoApO3D?usp=sharing
- Mediafire: https://www.mediafire.com/file/5nam8o96h50bigc/blackpard.zip/file
- (The instructions are already included)

## Using the compiler
### macOS
Once installed, you can always run the compiler with weepsbox, using the command:
```
./><OS><.weepsbox.sh https://raw.githubusercontent.com/simplyYan/Blackpard/main/SRC/blackpard.py
```
Replace "><OS><" with the first 3 letters of the name of your operating system (win, lin, mac).
After running the compiler with weepsbox, you must type one of 2 commands. "compile" to compile your script and make the compiler launch it automatically, and "run" to test a script.
It is recommended that you create a separate directory and make a copy of weepsbox in it before compiling, and use this copy to compile. After compiling, you can distribute your program.
To distribute, the only files you need to distribute are "index.tea" (generated during compilation) and your program's Blackpard files, with which the end user must download and run Blackpard using weepsbox (just as you did to get it) and run the "init" command in the compiler (being in the same directory as index.tea).

### Windows and Linux
Using the compiler on Linux and Windows is similar, but the end client won't need the dependencies. The commands are:

- run: Run/Test a Blackpard file
- compile: Convert to executable. This command renders the compiler useless and turns it into an executable of your Blackpard program. To distribute, you must include the compiler (which is now your executable), the generated "index.tea" and the necessary files from your program (Blackpard scripts and other files). Once compiled, you must download a new compiler to use (download Blackpard again). So, in short, the compiler you used to use "compile" is now an executable that you can distribute.
- init: This command should be used by the end user to start your program.

### Differentials for Linux and Windows
For Linux, Blackpard is faster, and the end customer doesn't need to install anything third-party (dependencies).
On Windows, Blackpard is a little lighter, but has a little less performance, and the end user won't need to have any dependencies.

## IDE
Blackpard has its own IDE, called "Whitepard", which can be used online in the browser! To access the IDE, [click here](https://simplyyan.github.io/Whitepard/root/) or go to:
```
https://simplyyan.github.io/Whitepard/root/
```

## Using Pardpackage to download all the built-in libraries
You can use the Blackpard package manager to get all the Blackpard (built-in) libraries. To do this, download Pardpackage for Windows (https://raw.githubusercontent.com/simplyYan/Blackpard/main/Pardpackge/prpg.bat) or Linux/macOS (https://raw.githubusercontent.com/simplyYan/Blackpard/main/Pardpackge/prpg.sh), and run the file passing the directory where you want to download the libraries as an argument (it must be where you are developing your Blackpard program).


## Documentation
You can access the documentation on the Blackpard Pages: https://simplyyan.github.io/Blackpard/

## Main features:

- Cross-platform: Our language is compatible with Windows, Linux and macOS;

- Runs on a VM: Blackpard runs entirely on BlackpardVM, the language's virtual machine. Using the Blackpard language, you can manipulate everything from BlackpardVM, which is almost an operating system. You can manipulate files, the terminal, and much more.

- Strongly typed: Blackpard's speed is due to many language features, one of which is typing. 

- Extremely easy: Blackpard is very easy, and quick to learn.

- Native tools: Our language has a variety of built-in tools, which can help a lot! Some of these tools are: Scraping, Cryptography, Mathematics, Machine Learning, Audio Manipulation, Video Manipulation, Image Manipulation, String Manipulation, and much more!

- Fast: Blackpard is insanely fast and optimized.

- In-house compiler: The magic behind Blackpard is also due to the efficient and modern compiler.

- Proprietary IDE: Blackpard has an IDE exclusively dedicated to our language.

- Open-source: Our language is open-source and is licensed under BSD-CLAUSE 3.

## License
Blackpard is licensed under BSD-CLAUSE 3. Before modifying or using it, it is recommended that you read the license.

## Contribute
You can contribute by opening a pull-request and improving, correcting or adding features.

> A project founded by Wesley Yan Soares Brehmer
