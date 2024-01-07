![Blackpard Lang](https://raw.githubusercontent.com/simplyYan/Blackpard/main/Banner.png)

Blackpard is a high-level compiled language that is fast, light, easy, secure and broad.

## How to install
- **macOS**:
Blackpard can be installed using weepsbox, a tool I developed to install and run small, single-file Python packages. First, look at the macOS requirements:

- Python >= 3.8.12

- Windows, Linux or macOS versions released after 2016

- wget and curl

Now, if you have the requirements, just use a command in the terminal to install. Check it out:

- Windows (Powershell only):
```
wget https://raw.githubusercontent.com/simplyYan/weepsbox/main/mac.weepsbox.sh
chmod 777 mac.weepsbox.sh
./mac.weepsbox.sh https://raw.githubusercontent.com/simplyYan/Blackpard/main/SRC/blackpard.py
```
- **Windows**:
Blackpard can be installed using weepsbox, a tool I developed to install and run small, single-file Python packages. First, look at the Windows requirements:

- Python >= 3.8.12
Now, if you have the requirements, just use a command in the terminal to install. Check it out (POWERSHELL ONLY):
```
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githubusercontent.com/simplyYan/weepsbox/main/win.weepsbox.bat', 'win.weepsbox.bat')"
win.weepsbox.bat https://raw.githubusercontent.com/simplyYan/Blackpard/main/SRC/blackpard.py
```
- **Linux**:
On Linux, Blackpard is pre-built and can be downloaded via Google Drive or Mediafire. Download from the mirrors:
- Google Drive: https://drive.google.com/drive/folders/1DsU1dZFnXwxQZMNPcUIm2XQPGtoApO3D?usp=sharing
- Mediafire: ???


## Using the compiler
Once installed, you can always run the compiler with weepsbox, using the command:
```
./><OS><.weepsbox.sh https://raw.githubusercontent.com/simplyYan/Blackpard/main/SRC/blackpard.py
```
Replace "><OS><" with the first 3 letters of the name of your operating system (win, lin, mac).
After running the compiler with weepsbox, you must type one of 2 commands. "compile" to compile your script and make the compiler launch it automatically, and "run" to test a script.
It is recommended that you create a separate directory and make a copy of weepsbox in it before compiling, and use this copy to compile. After compiling, you can distribute your program.
To distribute, the only files you need to distribute are "index.tea" (generated during compilation) and your program's Blackpard files, with which the end user must download and run Blackpard using weepsbox (just as you did to get it) and run the "init" command in the compiler (being in the same directory as index.tea).

## IDE
Blackpard has its own IDE, called "Whitepard", which can be used online in the browser! To access the IDE, [click here](https://simplyyan.github.io/Whitepard/root/) or go to:
```
https://simplyyan.github.io/Whitepard/root/
```
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
