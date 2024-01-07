#!/bin/bash

# Verifica se o número de argumentos é válido
if [ "$#" -ne 1 ]; then
    echo "Use: $0 <destination_directory>"
    exit 1
fi

# URL do diretório do GitHub
github_url="https://github.com/simplyYan/Blackpard/archive/refs/heads/main.zip"

# Diretório temporário
temp_dir=$(mktemp -d)

# Diretório de destino
dest_dir="$1"

# Baixa o arquivo zip do diretório do GitHub
wget -O temp.zip "$github_url"

# Verifica se o download foi bem-sucedido
if [ $? -ne 0 ]; then
    echo "Error downloading file from GitHub."
    exit 1
fi

# Descompacta o arquivo zip para o diretório temporário
unzip -qq temp.zip -d "$temp_dir"

# Move apenas a pasta "libs" para o diretório de destino
mv "$temp_dir/Blackpard-main/libs" "$dest_dir"

# Remove o diretório temporário e o arquivo zip
rm -rf "$temp_dir" temp.zip

echo "Installation completed. The Blackpard built-in libraries have been downloaded to the $dest_dir"

