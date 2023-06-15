# Criação de Clusters Kubernetes com Kind

Este projeto consiste em scripts para criar clusters Kubernetes utilizando o Kind (Kubernetes in Docker) e o kubectl. Os scripts estão disponíveis tanto para Windows quanto para Linux, permitindo a instalação do Kind e do kubectl, criação de clusters personalizados com a quantidade de workers desejada e configuração do contexto do Kubernetes.

## Pré-requisitos

- Sistema operacional: Windows ou Linux.
- [Kind](https://kind.sigs.k8s.io/) instalado no sistema.
- [kubectl](https://kubernetes.io/docs/tasks/tools/) instalado no sistema.
- [curl](https://curl.se/) instalado no sistema.

## Instalação

1. Clone o repositório para o seu sistema:
   ```
   git clone
   ```

2. Certifique-se de ter o Kind, o kubectl e o curl instalados corretamente no seu sistema.

3. Abra o prompt de comando ou terminal e navegue até o diretório onde você clonou o repositório.

4. Execute o script de criação do cluster de acordo com o seu sistema operacional:

- Windows:
  ```
  install_windows.bat
  ```

- Linux:
  ```
  ./install_linux.sh
  ```

5. Siga as instruções do script para informar o nome do cluster e a quantidade de workers desejada.

6. Aguarde até que o script crie o cluster Kind com as configurações especificadas.

7. Após a conclusão, o script exibirá as informações do cluster criado.

## Uso

Ao executar o script de criação do cluster, você será solicitado a informar o nome do cluster e a quantidade de workers desejada. O script criará um arquivo de configuração do cluster, adicionando os workers especificados. Em seguida, o Kind será utilizado para criar o cluster com base nas configurações fornecidas.

Após a criação do cluster, o script configurará o contexto do Kubernetes para o novo cluster e exibirá as informações relevantes, como o endpoint do cluster e o contexto atual.

## Opções Adicionais

- Para listar os clusters instalados com o Kind, execute o script de listagem de clusters de acordo com o seu sistema operacional:

- Windows:
 ```
 list-clusters.bat
 ```

- Linux:
 ```
 ./list-clusters.sh
 ```

- Para excluir um cluster, execute o script de exclusão de clusters de acordo com o seu sistema operacional:

- Windows:
 ```
 delete-cluster.bat
 ```

- Linux:
 ```
 ./delete-cluster.sh
 ```

Siga as instruções fornecidas pelo script para selecionar o cluster a ser removido.

## Contribuição

Contribuições são bem-vindas! Se você tiver sugestões, melhorias ou correções para o projeto, sinta-se à vontade para abrir um problema ou enviar uma solicitação pull.

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).
