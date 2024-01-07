import os
import shutil
import sys
import subprocess
import webbrowser
import argparse
import tkinter as ui
import ctypes


# pyinstaller --onefile blpd.py 

# Verifica se o arquivo "index.tea" existe
arquivo_index = "index.tea"
if os.path.exists(arquivo_index):
    # Se o arquivo existir, lê o conteúdo
    with open(arquivo_index, "r") as arquivo:
        codigo_python = arquivo.read()

    # Executa o código Python do arquivo "index.tea" se houver algum conteúdo
    if codigo_python.strip():
        try:
            with open(codigo_python, "r") as arquivo2:
                rslt = arquivo2.read()
            exec(rslt)
            print(f"Running Blackpard code from file '{arquivo_index}'")
        except Exception as e:
            pass
    else:
        print(f"The file '{arquivo_index}' is empty")
else:
    pass

def runCode(filename):
    with open(filename, 'r') as file:
        content = file.read()
        exec(content)

def compil(filename):
    with open(filename, 'r') as file:
        content = file.read()
        # Start of the transpilation and code adaptation session
        action = content.replace("action", "def")
        echo = action.replace("echo", "print")
        onready = echo.replace('@onready:', 'if __name__ == "__main__":')
        get = onready.replace("web.Get(", "requests.get(")
        post = get.replace("web.Post(", "requests.post(")
        httperror = post.replace("web.Error(", "requests.HTTPError")
        strvar = httperror.replace('.string ', '')
        intvar = strvar.replace('.int ', '')    
        floatvar = intvar.replace('.float ', '')
        boolvar = floatvar.replace('.bool ', '')      
        extends = boolvar.replace('extends(', 'ctypes.CDLL(')    
        comm = extends.replace('//', '#')
        classcfg = comm.replace('class.struct(', 'def __init__(self, ')
        maybe = classcfg.replace('maybe', 'elif')
        skip = maybe.replace('skip', 'pass')
        jit = skip.replace('@vm', '@njit')
        execWithOP = jit.replace('vm.set(', 'matx.script(')
        req_vm = execWithOP.replace("require('blackpard.vm')", "")
        base = req_vm.replace("base.Call(", "ctx.call(")
        baseget = base.replace("base.Ref(", "ctx.eval(")

# Nome do arquivo que você quer criar
        nome_arquivo = filename + ".py"

# Conteúdo que você quer escrever no arquivo
        conteudo = classcfg

        try:
        # Abre o arquivo no modo de escrita ('w')
            with open(nome_arquivo, 'w') as arquivo:
            # Escreve o conteúdo no arquivo
                arquivo.write(conteudo)

            print(f"File '{nome_arquivo}' was created successfully.")
            runCode(nome_arquivo)

        except Exception as e:
            print(f"An error occurred: {e}")


def intr(filename):
    with open(filename, 'r') as file:
        contentIN = file.read()
        # Start of the transpilation and code adaptation session
        actionIN = contentIN.replace("action", "def")
        echoIN = actionIN.replace("echo", "print")
        onreadyIN = echoIN.replace('@onready:', 'if __name__ == "__main__":')
        getIN = onreadyIN.replace("web.Get(", "requests.get(")
        postIN = getIN.replace("web.Post(", "requests.post(")
        httperrorIN = postIN.replace("web.Error(", "requests.HTTPError")
        strvarIN = httperrorIN.replace('.string ', '')
        intvarIN = strvarIN.replace('.int ', '')    
        floatvarIN = intvarIN.replace('.float ', '')
        boolvarIN = floatvarIN.replace('.bool ', '')      
        extendsIN = boolvarIN.replace('extends(', 'ctypes.CDLL(')    
        commIN = extendsIN.replace('//', '#')
        classcfgIN = commIN.replace('class.struct(', 'def __init__(self, ')
        maybeIN = classcfgIN.replace('maybe', 'elif')
        skipIN = maybeIN.replace('skip', 'pass')
        jitIN = skipIN.replace('@vm', '@njit')
        execWithOPIN = jitIN.replace('vm.set(', 'matx.script(')
        req_vmIN = execWithOPIN.replace("require('blackpard.vm')", "")
        baseIN = req_vmIN.replace("base.Call(", "execjs.call(")
        basegetIN = baseIN.replace("base.Ref(", "ctx.eval(")

# Nome do arquivo que você quer criar
        fill = filename + ".py"

# Conteúdo que você quer escrever no arquivo
        conteudo = basegetIN

        try:
        # Abre o arquivo no modo de escrita ('w')
            with open(fill, 'w') as arquivo5:
            # Escreve o conteúdo no arquivo
                arquivo5.write(conteudo)

            print(f"File '{fill}' was created successfully.")
            runCode(fill)

        except Exception as e:
            print(f"An error occurred: {e}")





# Verifica se há pelo menos dois argumentos
if len(sys.argv) >= 2:
    # Verifica o primeiro argumento e executa a ação correspondente
    if sys.argv[1] == "compile":
        # Se a primeira palavra for "compile", executa esta ação
        if len(sys.argv) >= 3:
            segundo_argumento = sys.argv[2]
            # Realize ação correspondente ao comando "compile"
            print(f"Compiling {segundo_argumento}")
            with open("index.tea", 'w') as fil:
                rrr = segundo_argumento + ".py"
                fil.write(rrr)

        else:
            print("The second argument to 'compile' is missing'")
    elif sys.argv[1] == "run":
        # Se a primeira palavra for "run", executa esta ação
        if len(sys.argv) >= 3:
            segundo_argumento = sys.argv[2]
            # Realize ação correspondente ao comando "run"
            compil(segundo_argumento)
        else:
            print("The second argument for 'run' is missing")
    elif sys.argv[1] == "init":
        # Se a primeira palavra for "run", executa esta ação
            with open("index.tea", "r") as teaa:
                tea = teaa.read()
            intr(tea)
    else:
        # Se a primeira palavra não corresponder a nenhum comando conhecido
        print("Command not recognized")
else:
    # Se não houver argumentos suficientes passados
    print("The command and/or the second argument are missing")

def logger(tipo, mensagem):
    if tipo == 'sucess':
        converted_message = mensagem.translate(str.maketrans(
            'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',
            'ᗞᕮᒪ᙭ᗰᑭᑫᖇᓮᒪᕮᖇᑕᗪᕮᖙᓭᖇᗪᕮᖚᔕᔕᙓᗩᗩᗰᗩᑎᑎᓮᖇᗩᖙᗩᒪᒪᖇᖆᖗᗪᖗᔑ'))
        print(converted_message)
    elif tipo == 'warn':
        converted_message = mensagem.translate(str.maketrans(
            'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',
            'E̲F̲G̲H̲I̲J̲K̲L̲M̲N̲O̲P̲Q̲R̲S̲T̲U̲V̲W̲X̲Y̲Z̲a̲b̲c̲d̲e̲f̲g̲h̲i̲j̲k̲l̲m̲n̲o̲p̲q̲r̲s̲t̲u̲v̲w̲x̲y̲z̲'))
        print(converted_message)
    elif tipo == 'error':
        converted_message = mensagem.translate(str.maketrans(
            'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',
            'E̲F̲G̲H̲I̲J̲K̲L̲M̲N̲O̲P̲Q̲R̲S̲T̲U̲V̲W̲X̲Y̲Z̲a̲b̲c̲d̲e̲f̲g̲h̲i̲j̲k̲l̲m̲n̲o̲p̲q̲r̲s̲t̲u̲v̲w̲x̲y̲z̲'))
        print(converted_message)
    else:
        print("Type not recognized")

def main():
    while True:
        command = input("Enter command (compile, run, init) or 'exit' to quit: ")
        if command == 'exit':
            break

        if command not in ['compile', 'run', 'init']:
            print("Invalid command. Please enter a valid command.")
            continue

        if command == "compile":
            filename = input("Enter file name to compile: ")
            print(f"Compiling {filename}")
            with open("index.tea", 'w') as fil2:
                rrr2 = filename + ".py"
                fil2.write(rrr2)

        elif command == "run":
            filename = input("Enter file name to run: ")
            compil(filename)

        elif command == "init":
            with open("index.tea", "r") as teaa:
                tea = teaa.read()
            intr(tea)

if __name__ == "__main__":
    main()
