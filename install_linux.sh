#!/bin/bash

##
## Instala o Kind na máquina do dev
## joaopaulo@ueg.br
##

# Verificar a arquitetura do processador
arch=$(uname -m)

# Função para instalar um cluster Kind
install_cluster() {
    # Solicitar o nome do cluster a ser criado
    read -p "Nome do cluster: " cluster_name

    # Solicitar a quantidade de workers desejados
    read -p "Quantidade de workers desejados: " worker_count

    # Criar o arquivo de configuração do cluster
    cat <<EOF > kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
EOF

    # Adicionar workers ao arquivo de configuração
    for ((i=0; i<$worker_count; i++)); do
        echo "- role: worker" >> kind-config.yaml
    done

    # Criar o cluster Kind
    kind create cluster --name "$cluster_name" --config kind-config.yaml --wait 1m

    # Configurar o contexto do Kubernetes para o cluster Kind
    kubectl cluster-info --context "kind-$cluster_name"
}

# Função para listar clusters Kind
list_clusters() {
    echo "Clusters instalados:"
    kind get clusters

    PS3="Selecione uma opção: "
    options=("Deletar um cluster" "Voltar")
    select opt in "${options[@]}"; do
        case $opt in
            "Deletar um cluster")
                read -p "Digite o nome do cluster a ser deletado: " cluster_name
                kind delete cluster --name "$cluster_name"
                break
                ;;
            "Voltar")
                break
                ;;
            *) echo "Opção inválida";;
        esac
    done
}

# Menu principal
PS3="Selecione uma ação: "
actions=("Instalar cluster" "Listar clusters" "Sair")
select action in "${actions[@]}"; do
    case $action in
        "Instalar cluster")
            install_cluster
            break
            ;;
        "Listar clusters")
            list_clusters
            break
            ;;
        "Sair")
            break
            ;;
        *) echo "Opção inválida";;
    esac
done
