#!/bin/bash

# Verifica se o Java está instalado
if ! command -v java &> /dev/null; then
    echo "Java não encontrado, instalando..."
    sudo apt update
    sudo apt install openjdk-17-jdk -y
    echo "Java instalado com sucesso."
fi

# Caminho para o diretório onde o projeto será clonado
projectPath="$HOME/Desktop/Cliente-Java"

# Verifica se o diretório do projeto já existe e o exclui
if [ -d "$projectPath" ]; then
    echo "Excluindo projeto existente..."
    rm -rf "$projectPath"
fi

# Clona o projeto do GitHub
echo "Clonando o projeto do GitHub..."
git clone https://github.com/FastTotem/Cliente-Java.git "$projectPath"

# Caminho para o arquivo JAR no projeto clonado
jarPath="$projectPath/out/artifacts/validacao_login_senha_jar"

# Verifica se o arquivo JAR existe no projeto
if [ -f "$jarPath/validacao-login-senha.jar" ]; then
    echo "Iniciando o arquivo JAR do projeto..."
    java -jar "$jarPath/validacao-login-senha.jar"
    echo "Arquivo JAR do projeto iniciado com sucesso."
else
    echo "Arquivo JAR do projeto não encontrado."
fi
