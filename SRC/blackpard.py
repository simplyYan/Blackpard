from fastapi import FastAPI, Path, Query, HTTPException, Request, Form, Depends
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from pydantic import BaseModel
from typing import Optional
import wafw00f
import warnings
import wasabi
import wave
import weakref
import webbrowser as browser
import websocket
from easyprocess import EasyProcess
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email import encoders
import enchant as strutil
import errno
import exifread
import random
import re
import readline
import reportbug
import requests
import routes
import tabnanny
import tabulate
import tarfile
import tempfile
import termcolor
import textdistance
import textwrap
import threading
import time
import tkinter as ui
import token
import yaml
import usb.core
import uuid
import uvicorn
import serial
import uno
import urllib
import idna
import imageio
import inspect
import instaloader
import invoke
import io
import ipaddress
import ipwhois
import oauthlib
import opcode
import operator
import os
import p2pnetwork
import packaging
import passlib
import pkginfo
import pkgutil
import platform
import pluginbase
import pycurl as adreq
import abc
import array
import asyncore
import atexit as onexit
import apt
import safetensors
import scanext
import secrets
import select
import shutil
import signal
import simplejson
import socket
import statistics
import sys
import subprocess
import sqlalchemy
import sqlite3
import dataclasses
import datetime
import decimal
import dns
import fabric
import flasgger
import filelock
import ftplib
import fuzzywuzzy
import future
import functools
import gast
import genericpath
import gettext
import gc
import glob
import grpc
import gzip
import hashlib
import html
import http
import hyperframe
import jwt
import json
import keyword
import langcodes
import lzma
import logging
import locale
import zipapp
import zipfile
import zipimport
import zlib
import xml
import cachetools
import calendar
import cgi
import clang
import click
import cmath
import cmd
import cryptography
import csv
import curl
import validate
import vboxapi
import base64
import bcrypt
import binascii
import numbers
import numpy
import magic
import math
from numba import njit
from py_mini_racer import py_mini_racer


def compil(filename):
    with open(filename, 'r') as file:
        content = file.read()
        # Start of the transpilation and code adaptation session
        action = content.replace("action", "def")
        echo = action.replace("echo", "print")
        router = echo.replace("require(web)", "web = FastAPI()")
        routerlis = router.replace("web.Listen(", "uvicorn.run(")
        onready = routerlis.replace('@onready:', 'if __name__ == "__main__":')
        get = onready.replace("web.Get(", "requests.get(")
        post = get.replace("web.Post(", "requests.post(")
        httperror = post.replace("web.Error(", "requests.HTTPError")
        logger_err = httperror.replace("logger.Warn(", "warnings.warn(")
        logger_ignore = logger_err.replace('logger.Mode("ignore")', 'warnings.filterwarnings("ignore")')
        logger_def = logger_ignore.replace('logger.Mode("default")', 'warnings.filterwarnings("default")')
        req_term = logger_def.replace('require(term)', 'term = Printer()')
        strvar = req_term.replace('.string ', '')
        intvar = strvar.replace('.int ', '')    
        floatvar = intvar.replace('.float ', '')
        boolvar = floatvar.replace('.bool ', '')      
        termexec = boolvar.replace('term.Run([', 'EasyProcess([') 
        dic = termexec.replace('require(dic).lang(', 'dic = enchant.Dict(')   
        extends = dic.replace('extends(', 'extender(')    
        comm = extends.replace('//', '#')
        classcfg = comm.replace('class.struct(', 'def __init__(self, ')
        maybe = classcfg.replace('maybe', 'elif')
        reffer = maybe.replace('@(', 'ref(')
        const = reffer.replace('.const(', '.setv(')
        bpctx = const.replace('blackpard.context(!)', '(@&¨@)Blackpard.LANG')

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
            with open(nome_arquivo, 'r') as file:
                code = file.read()
                exec(code)

        except Exception as e:
            print(f"An error occurred: {e}")

ctx = py_mini_racer.MiniRacer()

@njit
def setv(key, value):
    ctx.eval(f"const '{key}' = '{value}';")

@njit
def ref(key):
    return ctx.eval(f"'{key}';")

@njit
def extender(filee):
    ext = os.open(filee, 'r')   
    content = ext.read()
    try:
        with open(content, 'r') as arquivo:
        # Lê cada linha do arquivo
            for linha in arquivo:
            # Verifica se a palavra procurada está na linha
                if "(@&¨@)Blackpard.LANG" in linha:
                    encontrada = True
                    break  # Se encontrou a palavra, podemos parar de procurar

        if encontrada:
            compil(filee)
        else:
            print(f"The code isent compiled")

    except FileNotFoundError:
        print(f"The file '{filee}' was not found.")
    except Exception as e:
        print(f"Ocorreu um erro: {e}")



# Verifica se o arquivo "index.tea" existe
arquivo_index = "index.tea"
if os.path.exists(arquivo_index):
    # Se o arquivo existir, lê o conteúdo
    with open(arquivo_index, "r") as arquivo:
        codigo_python = arquivo.read()

    # Executa o código Python do arquivo "index.tea" se houver algum conteúdo
    if codigo_python.strip():
        try:
            exec(codigo_python)
            print(f"Executando código Python do arquivo '{arquivo_index}'")
        except Exception as e:
            pass
    else:
        print(f"O arquivo '{arquivo_index}' está vazio")
else:
    pass


# Verifica se há pelo menos dois argumentos
if len(sys.argv) >= 2:
    # Verifica o primeiro argumento e executa a ação correspondente
    if sys.argv[1] == "compile":
        # Se a primeira palavra for "compile", executa esta ação
        if len(sys.argv) >= 3:
            segundo_argumento = sys.argv[2]
            # Realize ação correspondente ao comando "compile"
            print(f"Compilando {segundo_argumento}")
            with open("index.tea", 'w') as fil:
                fil.write(segundo_argumento)

        else:
            print("Falta o segundo argumento para 'compile'")
    elif sys.argv[1] == "run":
        # Se a primeira palavra for "run", executa esta ação
        if len(sys.argv) >= 3:
            segundo_argumento = sys.argv[2]
            # Realize ação correspondente ao comando "run"
            compil(segundo_argumento)
        else:
            print("Falta o segundo argumento para 'run'")
    else:
        # Se a primeira palavra não corresponder a nenhum comando conhecido
        print("Comando não reconhecido")
else:
    # Se não houver argumentos suficientes passados
    print("Falta o comando e/ou o segundo argumento")

