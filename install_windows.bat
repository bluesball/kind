@echo off

setlocal enabledelayedexpansion

REM Verificar se o Kind está instalado
if not exist "%ProgramFiles%\kind\kind.exe" (
    echo Instalando o Kind...

    REM Baixar e instalar o Kind
    curl.exe -Lo kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-windows-amd64.exe
    move kind "%ProgramFiles%\kind\kind.exe"
)

REM Verificar se o kubectl está instalado
if not exist "%ProgramFiles%\kubectl\kubectl.exe" (
    echo Instalando o kubectl...

    REM Criar uma pasta temporária para o download do kubectl
    mkdir kubectl_temp
    cd kubectl_temp

    REM Baixar o kubectl
    curl.exe -LO "https://dl.k8s.io/release/$(curl.exe -L -s https://dl.k8s.io/release/stable.txt)/bin/windows/amd64/kubectl.exe"

    REM Mover o kubectl para a pasta de instalação
    move kubectl.exe "%ProgramFiles%\kubectl\kubectl.exe"

    REM Voltar para a pasta inicial e excluir a pasta temporária
    cd ..
    rmdir /s /q kubectl_temp
)

REM Definir o caminho de busca para incluir o Kind e o kubectl
set "PATH=%PATH%;%ProgramFiles%\kind;%ProgramFiles%\kubectl"

REM Solicitar o nome do cluster a ser criado
set /p "cluster_name=Nome do cluster: "

REM Solicitar a quantidade de workers desejados
set /p "worker_count=Quantidade de workers desejados: "

REM Criar o arquivo de configuração do cluster
(
    echo kind: Cluster
    echo apiVersion: kind.x-k8s.io/v1alpha4
    echo nodes:
    echo - role: control-plane
) > kind-config.yaml

REM Adicionar workers ao arquivo de configuração
for /l %%i in (1, 1, %worker_count%) do (
    echo - role: worker >> kind-config.yaml
)

REM Criar o cluster Kind
kind create cluster --name "%cluster_name%" --config kind-config.yaml --wait 1m

REM Configurar o contexto do Kubernetes para o cluster Kind
kubectl.exe cluster-info --context "kind-%cluster_name%"

endlocal
