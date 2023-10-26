# Verifica se o Java está instalado
if (!(Test-Path -Path $installDir -PathType Container)) {
    Write-Host "Java não encontrado, instalando..."
    $url = "https://github.com/AdoptOpenJDK/openjdk17-binaries/releases/download/jdk-$javaVersion%2B35/OpenJDK$javaVersion-jre_x64_windows_hotspot_$javaVersion.7z"
    $downloadPath = "$env:TEMP\openjdk-$javaVersion.7z"

    # Baixar o JDK
    Invoke-WebRequest -Uri $url -OutFile $downloadPath

    # Extrair o JDK
    Expand-Archive -Path $downloadPath -DestinationPath $installDir

    # Definir a variável de ambiente JAVA_HOME
    [System.Environment]::SetEnvironmentVariable("JAVA_HOME", $installDir, [System.EnvironmentVariableTarget]::Machine)

    Write-Host "Java instalado com sucesso."
}

# Caminho para o diretório onde o projeto será clonado
$projectPath = "$env:USERPROFILE\Desktop\Cliente-Java"

# Verifica se o diretório do projeto já existe e o exclui
if (Test-Path -Path $projectPath -PathType Container) {
    Write-Host "Excluindo projeto existente..."
    Remove-Item -Path $projectPath -Force -Recurse
}

# Clona o projeto do GitHub
Write-Host "Clonando o projeto do GitHub..."
git clone https://github.com/FastTotem/Cliente-Java.git $projectPath

# Caminho para o arquivo JAR no projeto clonado
$jarPath = "$projectPath\out\artifacts\validacao_login_senha_jar"

# Verifica se o arquivo JAR existe no projeto
if (Test-Path -Path "$jarPath\validacao-login-senha.jar" -PathType Leaf) {
    Write-Host "Iniciando o arquivo JAR do projeto..."

    java -jar "$jarPath\validacao-login-senha.jar"
    Write-Host "Arquivo JAR do projeto iniciado com sucesso."
} else {
    Write-Host "Arquivo JAR do projeto não encontrado."
}
