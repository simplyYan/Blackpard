#!/bin/bash

# Associative array to store variables
declare -A blackpard_variables
declare -A blackpard_constants
declare -A blackpard_functions
declare -A blackpard_lists
declare -A routes

# Function to create/assign a variable using the 'vlu' keyword
function vlu {
    local var_name=$1
    local var_value=$2

    blackpard_variables[$var_name]=$var_value
}

# Function to create a constant using the 'static' keyword
function static {
    local const_name=$1
    local const_value=$2

    blackpard_constants[$const_name]=$const_value
}

# Function to create/define a function using the 'action' keyword
function action {
    local func_name=$1
    shift
    local func_args=$@
    local func_body=""

    while IFS= read -r line; do
        func_body+="$line"$'\n'
    done

    blackpard_functions[$func_name]="function $func_name { $func_body; }"
    eval "${blackpard_functions[$func_name]}"
}

# Function to execute a defined function
function execute {
    local func_name=$1
    shift
    local args=$@

    local func_body=${blackpard_functions[$func_name]}
    local result=$(echo "$func_body" | "$@")

    echo "$result"
}

# Function to execute the if-else-elif conditional structure
function maybe {
    local condition=$1
    shift
    local then=("$@")
    local else_flag=false

    if [ "$condition" = "true" ]; then
        for cmd in "${then[@]}"; do
            eval "$cmd"
        done
        else_flag=true
    fi

    if [ "$condition" = "false" ] && [ "$else_flag" = false ]; then
        for cmd in "${else[@]}"; do
            eval "$cmd"
        done
    fi
}

# Function to print the value of a variable
function get {
    local var_name=$1

    echo "${blackpard_variables[$var_name]}"
}

# Function to print the value of a constant
function gets {
    local const_name=$1

    echo "${blackpard_constants[$const_name]}"
}

# Function to execute the 'for' loop structure
function loop {
    local var_name=$1
    local from=$2
    local to=$3
    shift 3
    local for_commands=("$@")

    for (( var = $from; var <= $to; var++ )); do
        blackpard_variables[$var_name]=$var
        for cmd in "${for_commands[@]}"; do
            eval "$cmd"
        done
    done
}

# Function to execute the 'while' loop structure
function drain {
    local condition="$1"
    shift
    local while_commands=("$@")

    while [ "$condition" = "true" ]; do
        for cmd in "${while_commands[@]}"; do
            eval "$cmd"
        done
    done
}

# Function to execute the 'do-while' loop structure
function dodrain {
    shift
    local do_while_commands=("$@")

    while :; do
        for cmd in "${do_while_commands[@]}"; do
            eval "$cmd"
        done
        eval "$@"
        [ "$?" -ne 0 ] && break
    done
}

# Function to create a new list
function list {
    local list_name=$1
    blackpard_lists[$list_name]=()
}

# Function to add an element to the list
function add_to_list {
    local list_name=$1
    local element=$2
    blackpard_lists[$list_name]+=$element
}

# Function to remove an element from the list
function remove_from_list {
    local list_name=$1
    local element=$2
    local -n current_list=blackpard_lists[$list_name]

    for i in "${!current_list[@]}"; do
        if [[ "${current_list[$i]}" == "$element" ]]; then
            unset 'current_list[$i]'
            break
        fi
    done

    blackpard_lists[$list_name]=("${current_list[@]}")
}

# Function to access a list element by index
function get_list {
    local list_name=$1
    local index=$2
    local -n current_list=blackpard_lists[$list_name]

    echo "${current_list[$index]}"
}

# Function to get the size of the list
function list_size {
    local list_name=$1
    local -n current_list=blackpard_lists[$list_name]

    echo "${#current_list[@]}"
}

# Function to create a file
function create_file {
    local file_name=$1
    touch "$file_name"
}

# Function to delete a file
function delete_file {
    local file_name=$1
    rm -f "$file_name"
}

# Function to move a file
function move_file {
    local source_file=$1
    local destination=$2
    mv "$source_file" "$destination"
}

# Function to copy a file
function copy_file {
    local source_file=$1
    local destination=$2
    cp "$source_file" "$destination"
}

# Function to edit a file
function edit_file {
    local file_name=$1
    local editor=${EDITOR:-vi}  # Default editor or vi if not specified
    $editor "$file_name"
}

# Function to add a route
function add_route {
    local path=$1
    local action=$2
    routes[$path]=$action
}

# Function to handle the request
function handle_request {
    local path=$1

    if [[ ${routes[$path]} ]]; then
        echo "HTTP/1.1 200 OK"
        echo "Content-Type: text/html"
        echo ""
        ${routes[$path]}
    else
        echo -e "HTTP/1.1 404 Not Found\nContent-Type: text/plain\n"
        echo "404 - Route not found for $path"
    fi
}

function start_server {
    local port=$1
    echo "Server started at http://localhost:$port"

    while true; do
        local request=""
        read -r request
        local route=$(echo "$request" | cut -d" " -f2)

        handle_request "$route"
    done
}

JSON_FILE="data.json"
TMP_FILE="tmp.json"

# Function to load JSON from a file
function load_json {
    if [ -f "$JSON_FILE" ]; then
        cat "$JSON_FILE"
    else
        echo "{}"
    fi
}

# Function to set the JSON in a file
function set_json {
    local json_content=$1
    echo "$json_content" > "$JSON_FILE"
}

# Function to get a value from a key in JSON
function get_value {
    local key=$1
    load_json | jq -r ".$key"
}

# Function to add a value to a key in JSON
function add_value {
    local key=$1
    local value=$2
    local json_content=$(load_json | jq ".$key = \"$value\"")
    set_json "$json_content"
}

# Function to delete a key from JSON
function delete_key {
    local key=$1
    local json_content=$(load_json | jq "del(.$key)")
    set_json "$json_content"
}

function setTimeout {
    local func=$1
    local delay=$2
    sleep "$delay" && $func
}

function setInterval {
    local func=$1
    local interval=$2

    while true; do
        $func
        sleep "$interval"
    done
}

function encrypt_message {
    local message=$1
    local key=$2

    echo "$message" | openssl enc -e -aes-256-cbc -base64 -k "$key"
}

#!/bin/bash

# Function to decrypt a message using OpenSSL and AES
function decrypt_message {
    local encrypted_message=$1
    local key=$2

    echo "$encrypted_message" | openssl enc -d -aes-256-cbc -base64 -k "$key"
}

# Function to start a new process
function start_process {
    local process_name=$1
    "$process_name" &
}

# Function to list running processes
function list_processes {
    ps aux
}

# Function to terminate a process by name
function stop_process {
    local process_name=$1
    pkill "$process_name"
}

# Function to check if a process is running
function is_process_running {
    local process_name=$1
    if pgrep "$process_name" > /dev/null; then
        echo "$process_name is running."
    else
        echo "$process_name is not running."
    fi
}

# Function to make a HTTP GET request
function http_get {
    local url=$1
    curl -sS "$url"
}

# Function to check network connectivity with a ping
function check_network {
    local target=$1
    ping -c 1 "$target" > /dev/null
    if [ $? -eq 0 ]; then
        echo "Connected to network: $target"
    else
        echo "No connectivity with: $target"
    fi
}

# Function to resolve a domain name to an IP address
function resolve_dns {
    local domain=$1
    nslookup "$domain" | awk '/^Address: / { print $2 }'
}

# Function to display a log message (INFO level)
function log_info {
    local message=$1
    echo "[INFO] $message"
}

# Function to display a log message (DEBUG level)
function log_debug {
    local message=$1
    local debug_enabled=true  # Set to 'false' to disable debug messages

    if [ "$debug_enabled" = true ]; then
        echo "[DEBUG] $message"
    fi
}

# Function to display a log message (ERROR level)
function log_error {
    local message=$1
    echo "[ERROR] $message" >&2
}

# Function to create a directory
function create_directory {
    local directory_name=$1

    if [ ! -d "$directory_name" ]; then
        mkdir -p "$directory_name"
        echo "Directory '$directory_name' successfully created."
    else
        echo "The directory '$directory_name' already exists."
    fi
}

# Function to remove a directory
function remove_directory {
    local directory_name=$1

    if [ -d "$directory_name" ]; then
        rm -r "$directory_name"
        echo "Directory '$directory_name' successfully removed."
    else
        echo "The directory '$directory_name' does not exist."
    fi
}

# Function to list the contents of a directory
function list_directory {
    local directory_name=$1

    if [ -d "$directory_name" ]; then
        ls -l "$directory_name"
    else
        echo "The directory '$directory_name' does not exist."
    fi
}

# Function to display the permissions of a directory
function show_directory_permissions {
    local directory_name=$1

    if [ -d "$directory_name" ]; then
        stat -c "%A %a %n" "$directory_name"
    else
        echo "The directory '$directory_name' does not exist."
    fi
}

#!/bin/bash

# Default package directory
PACKAGES_DIR="blackpard_packages"

# Function to install a package
function install_package {
    local package_name=$1
    local package_dir="$PACKAGES_DIR/$package_name"

    if [ ! -d "$package_dir" ]; then
        mkdir -p "$package_dir"
        echo "Package '$package_name' successfully installed."
    else
        echo "The package '$package_name' is already installed."
    fi
}

# Function to list all installed packages
function list_packages {
    if [ -d "$PACKAGES_DIR" ]; then
        echo "Installed packages:"
        ls -1 "$PACKAGES_DIR"
    else
        echo "No packages installed yet."
    fi
}

# Function to run a task in the background
function run_background_task {
    local task_name=$1
    local task_command=$2

    ($task_command) &
    echo "Task '$task_name' started in the background."
}

# Função para listar tarefas em segundo plano em execução
function list_background_tasks {
    echo "Tarefas em segundo plano em execução:"
    jobs
}

# Função para executar um comando da Blackpard
function execute_command {
    local blackpard_command=$1
    eval "$blackpard_command"
}

# Loop para o shell interativo
while true; do
    read -p "Blackpard> " user_command  # Aguarda o comando do usuário
    execute_command "$user_command"    # Executa o comando inserido pelo usuário
done

# Função para gerar um arquivo de texto simples
function generate_plain_text {
    local file_name=$1
    local text_content=$2
    
    # Verifica se o arquivo já existe e o exclui para criar um novo
    if [ -f "$file_name" ]; then
        rm "$file_name"
    fi
    
    # Adiciona o conteúdo de texto ao arquivo
    echo "Gerando arquivo de texto: $file_name"
    echo "$text_content" >> "$file_name"
    echo "Arquivo de texto gerado com sucesso: $file_name"
}

# Função para gerar um arquivo CSV
function generate_csv {
    local file_name=$1
    shift
    local data=("$@")
    
    # Verifica se o arquivo já existe e o exclui para criar um novo
    if [ -f "$file_name" ]; then
        rm "$file_name"
    fi
    
    # Adiciona os dados ao arquivo CSV
    echo "Gerando arquivo CSV: $file_name"
    printf "%s\n" "${data[@]}" | while IFS= read -r line; do
        echo "$line" >> "$file_name"
    done
    echo "Arquivo CSV gerado com sucesso: $file_name"
}

# Função para calcular a média de uma lista de números
function calculate_mean {
    local sum=0
    local count=0
    
    for num in "$@"; do
        sum=$((sum + num))
        count=$((count + 1))
    done
    
    if [ "$count" -gt 0 ]; then
        local mean=$((sum / count))
        echo "Média: $mean"
    else
        echo "Não há números para calcular a média."
    fi
}

# Função para calcular a soma de uma lista de números
function calculate_sum {
    local sum=0
    
    for num in "$@"; do
        sum=$((sum + num))
    done
    
    echo "Soma: $sum"
}

# Função para criar e exibir uma matriz
function create_matrix {
    local rows=$1
    local columns=$2
    
    echo "Criando matriz $rows x $columns:"
    for ((i = 0; i < rows; i++)); do
        for ((j = 0; j < columns; j++)); do
            matrix[$i,$j]=$((RANDOM % 100))  # Números aleatórios de 0 a 99
            printf "%4d" "${matrix[$i,$j]}"
        done
        echo
    done
}

#!/bin/bash

# Função para realizar uma solicitação GET e processar JSON
function fetch_and_process_api {
    local url=$1
    
    # Realiza a solicitação GET para a API
    local response=$(curl -s "$url")
    
    if [ $? -eq 0 ]; then
        echo "Resposta da API recebida:"
        echo "$response"
        
        # Processa o JSON (extraindo o valor de 'name' do JSON de exemplo)
        local name=$(echo "$response" | jq -r '.name')
        
        echo "Nome: $name"
    else
        echo "Falha ao realizar a solicitação GET para a API."
    fi
}

function execute_sqlite_query {
    local database=$1
    local query=$2
    
    if [ -f "$database" ]; then
        echo "Executando consulta no banco de dados: $database"
        sqlite3 "$database" "$query"
    else
        echo "Banco de dados não encontrado: $database"
    fi
}

# Função para agendar uma tarefa
function task {
    local comando=$1
    local horario=$2
    
    # Adicionar tarefa ao cron
    (crontab -l ; echo "$horario $comando") | crontab -
    echo "Tarefa agendada: '$comando' para $horario"
}

# Função para listar as tarefas agendadas no cron
function tasklist {
    echo "Tarefas agendadas:"
    crontab -l
}

# Função para remover uma tarefa agendada
function removelist {
    local comando=$1
    
    # Remover tarefa do cron
    crontab -l | grep -v "$comando" | crontab -
    echo "Tarefa removida: '$comando'"
}

commands=("openssl" "curl" "sqlite3" "crontab" "nslookup" "awk" "jq")

install_command() {
    local package_manager=""
    local command_to_install="$1"

    # Identifica o gerenciador de pacotes adequado para cada sistema
    if command -v apt-get &>/dev/null; then
        package_manager="apt-get"
    elif command -v yum &>/dev/null; then
        package_manager="yum"
    elif command -v brew &>/dev/null; then
        package_manager="brew"
    else
        echo "Não foi possível identificar o gerenciador de pacotes."
        exit 1
    fi

    # Instala o comando usando o gerenciador de pacotes adequado
    case $package_manager in
        "apt-get") sudo apt-get install -y "$command_to_install" ;;
        "yum") sudo yum install -y "$command_to_install" ;;
        "brew") brew install "$command_to_install" ;;
    esac
}

# Verifica se os comandos estão instalados
for cmd in "${commands[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
        echo "O comando '$cmd' não está instalado. Instalando..."
        install_command "$cmd"
    else
        echo "O comando '$cmd' está instalado."
    fi
done