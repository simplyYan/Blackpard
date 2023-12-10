#!/bin/bash

# O arquivo pré-definido
src_file="blackpard_src.sh"

# O arquivo e diretório de destino
dest_file_path=$1
dest_dir=$(dirname "$dest_file_path")
dest_file=$(basename "$dest_file_path")

# Salva a extensão original do arquivo
original_extension="${dest_file##*.}"

# Renomeia o arquivo de destino para .sh
dest_file_base="${dest_file%.*}"
dest_sh="$dest_dir/$dest_file_base.sh"

# Copia o arquivo src para o diretório de destino
cp $src_file $dest_dir

# Renomeia o arquivo de destino para .sh
mv $dest_file_path $dest_sh

# Executa o arquivo .sh
bash $dest_sh

# Remove o arquivo src copiado
rm "$dest_dir/$src_file"

# Renomeia o arquivo .sh de volta para a extensão original
mv $dest_sh $dest_file_path
