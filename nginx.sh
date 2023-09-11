#!/bin/bash 
#
# Instala Servidor - Automatização de Processos
#
# Vitor de Jesus
# CVS $Header$

shopt -s -o nounset 

#Variaveis de Configuração
server_root="/var/www/html"
server_port="80"
index_page="index.html"

# Titulo

echo "Iniciando Servidor Nginx ..."

if [ "$EUID" -ne 0 ]; then
        echo "Necessario Permissão de super user"
        sleep 3
        exit 1
fi

if ! command -v ngnix; then

        echo "O servidor nginx não está instalado. Vamos Instalar ..."
        sleep 3

        # Atualizar o apt-get
        apt-get update && apt-get upgrade -y
        sleep 3

        apt-get install nginx -y
        sleep 3

else
        echo "nginx já instalado!"

fi

if [[ ! -d "$server_root" ]]; then
        echo "Criando Diretorio Raiz do servidor ..."
        mkdir -p "$server_root"
        sleep 3
fi

if [[ ! -f "$server_root/$index_page" ]]; then
    echo "Criando a página de índice padrão..."
    echo "<html><body><h1>Bem-vindo ao meu servidor web! Prof° Vitor</h1></body></html>" > "$server_root/$index_page"
    sleep 3
fi

# Inicia o servidor Ngnix
echo "Iniciando o servidor nginx na porta $server_port..."
systemctl start nginx 
sleep 3

# Exibe informações sobre o servidor web
echo "O servidor web está em execução."
echo "Diretório raiz do servidor: $server_root"
echo "Porta do servidor: $server_port"
echo "Página de índice padrão: $index_page"
sleep 3

# Valida

#sleep 20

#apt-get remove apache2

#sleep 3

#rm -rf /var/www

# Finaliza o Script
exit 0
