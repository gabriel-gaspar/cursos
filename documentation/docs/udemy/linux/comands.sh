# Comando aprendidos neste capítulo

# Utilitários -------------------------------------------------------------------------------------------

# exibe usuario atual logado no sistema
whoami

# trocar de usuário
su
su - # trocar para o usuário root

clear # limpa terminal

ln /home/gaspar/contrato #cria hard link para arquivo
ln -s /home/gaspar/contrato #cria soft link para arquivo

man ls # acessa o manual do comando ls
whatis ls # obtém descrição de um comando
ls --help #

date # obtém a data atual

# Rede ---------------------------------------------------------------------------------------------------
ifconfig # Lista interfaces de rede
ip addr # Lista interfaces de rede
ip a # Lista interfaces de rede

# Sistema de arquivos ------------------------------------------------------------------------------------
# cd - change directory
cd /folderName
#pwd - print working directory
pwd
# ls - list
ls  # lista o conteúdo de um diretório
ls -l # lista e detalha o conteúdo de um diretório
ls -ltr # lista com detalhes, ordena por tempo em ordem reversa
ls -ltr | more #  comando com paginação (por causa do more)
ls -l *[xy]* # lista arquivos que satisfizerem o wildcard
ls -l * xy * # lista arquivos que satisfizerem o wildcard
ls -l ?bcd* # lista arquivos que satisfizerem o wildcard
ls -l *xyz # lista arquivos que satisfizerem o wildcard
ls -l abc* # lista arquivos que satisfizerem o wildcard


# Manipulação de arquivos e textos
touch gaspar.txt   # cria um arquivo
rm -f gaspar.txt   # remove um arquivo
rm -Rf folderName   # remove uma pasta
touch arquivo[1..9]-xyz # cria arquivos seguindo o padrão do wildcard
cp ./gaspar.txt ./gaspar_backuo.txt  #faz uma cópia do arquivo
mkdir documentos # cria um diretório
mv gaspar.txt gabriel.txt # renomeia o arquivo
mv gabriel.txt /tmp # move um arquivo

echo "hello world" > hellofile
echo "hello again" >> hellofile
cat hellofile
more logFile # uma página por vez do arquivo no terminal
less logFile # uma página por vez do arquivo no terminal em ordem reversa
head -5 logFile # as 5 primeiras linhas do arquivo
tail -5 logFile # as 5 ultimas linhas do arquivo
touch fileWithOutput
ls -ltr > fileWithOutput # escreve a saída de um comando em um arquivo
ls -ltr | tee fileWithOutput # exibe a saída e escreve ela em um arquivo
echo "tee command and apend option" | tee -a fileWithOutput

cut -c1 filename # de cada linha do arquivo pega o primeiro caractere
cut -c1,2,4 filename # de cada linha do arquivo pega os caracteres 1, 2 e 4
cut -c1-3 filename # de cada linha do arquivo pega os caracteres de 1 a 3
cut -c1-3,6-8 filename # de cada linha do arquivo, pega os caracteres de 1 a 3 e de 6 a 8
cut -d: -f 6,7 /etc/passwd # em um arquivo com campos delimitados por ":", de cada linha extrai os 6º e 7º campos
ls -ltr | cut -c40-51 | grep dez # EU QUE FIZZZ \o/
# O comando awk considera o espaço como delimitador padrão
ls -ltr | awk '{print $6,$7,$8}' # EU QUE FIZZ, faz a mesma coisa que o comando anterior
ls -ltr | awk '{print $NF}' # retorna a ultima coluna da saída do comando ls
# Para usar um delimitador diferente, como "":""
awk -F: '{print $6,$7}' /etc/passwd
# O comando abaixo vai trocar o segundo campo por Gaspar e vai printar o resultado
# $0 significa printar todos os campos
echo "Hello Gabriel" | awk '{$2="Gaspar"} ; print $0'
aws 'length($0)>15' listaDeChamada # retorna apenas os nomes que possuem mais de 15 caracteres
ls -l | awk '{if($NF == "listaDeChamada") print $0;}' # retorna apenas linha cuja ultima coluna vale listaDeChamada
ls -ltr | awk '{print $1}' | cut -c1 | awk '{if($0 == "-") print $0;}' | wc -w # EU QUE FIZZZ, conta a quantidade de arquivos no diretório atual
ls -ltr | awk '{print $1}' | cut -c1 | awk '{if($0 == "d") print $0;}' | wc -w # conta a quantidade de diretórios no diretório atual


grep gaspar listaDeChamada # vai buscar todas as linhas que contenham a palavra gaspar
grep -c gaspar listaDeChamada # retorna a quantidade de ocorrencias do comando acima
grep -i GasPAR listaDeChamada # ignorar letras maiusculas e minusculas na busca
grep -n gaspar listaDeChamada # busca as linhas que contenham a palvra gaspar e informa o numero da linha no resultado
grep -vi gaspar listaDeChamada # retorna tudo menos as linhas que contiverem a palavra gaspar
egrep -i "GasPaR|Luzia" listaDeChamada # mesma coisa que o grep, mas busca mais de uma keyword

wc listaDeChamada  # retorna n° linhas/words/bytes
wc -l listaDeChamada # retorna n° de linhas
wc -w listaDeChamada # retorna n° palavras
wc -c listaDeChamada # retorna n° de bytes

# Comprimindo arquivos de uma pasta
tar cvf nomeDoContainer.tar /path/to/folder # comprime o conteúdo de uma pasta para um arquivo .tar
tar xvf nomeDoContainer.tar # descompactar o conteúdo no diretório atual
gzip nomeDoContainer.tar # gera um arquivo ainda mais compactado, no formato tar.gz
gzip -d nomeDoContainer.tar.gz # descompacta o arquivo .tar.gz de voltar para o arquivo .tar

# Recortando arquivos
# Esse comando vai reduzir o arquivo para 40 bytes. Haverá perda de conteúdo.
truncate -s 40 nomeDoArquivo

# Combinando arquivos
cat lista1 lista2 > lista3
# Dividindo arquivos
# a lista vai ser dividida em vários arquivos menores, cada 1 contendo 2 linhas da lista original
# sublista é o prefixo que cada arquivo vai ter, seguido de um sufixo de ordenação (a,b,c,d etc...)
split -l 2 listaDePaises sublista 
                
# Busca de arquivos (retornam o caminho do arquivo, caso seja encontrado)
find . -name gaspar.txt # a partir do caminho atual, procura pelo arquivo
find / -name gaspar.txt # procura o arquivo a partir da raíz do sistema (necessário acesso root)
locate gaspar.txt # procura o arquivo

# Controle de usuários ------------------------------------------------------------------------------------
passwd # inicia algoritmo para troca da senha do usuário atual
passwd userId # inicia algoritmo para troca da senha de um usuário (necessário estar como root)
passwd - # inicia algoritmo para troca da senha do usuário root (necessário estar como root)

# Controle de permissões -
chmod g-w jerry
chmod u-w jerry
chmod a-r jerry
chmod u+w jerry
chmod a+r jerry
chmod g+rw jerry
chmod o+w jerry
chmod ugo-x jerry

# trocar o dono de um arquivo
chown root gaspar.txt
# trocar o grupo ao qual um arquivo pertecente
chgrp root gaspar.txt
# Ajustes finos de permissões
getfacl path/to/file
setfacl -m u:userName:rwx /path/to/file
setfacl -m g:groupName:rw path/to/file
setfacl -dm "rwx" /path/to/file
setfacl -b /path/to/file

