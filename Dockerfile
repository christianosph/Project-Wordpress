FROM ubuntu:20.04

# Instalando as dependências
RUN apt-get update && \
    apt-get install -y \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysql \
    curl \
    wget

# Baixando o wordpress
RUN wget https://wordpress.org/latest.tar.gz && \
    tar xvf latest.tar.gz && \
    mv wordpress /var/www/html/wordpress && \
    rm latest.tar.gz

#instalando adminer
#RUN wget apt-get install -y \adminer

# Configurando o apache
COPY apache2.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Definindo as variáveis de ambiente
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

#porta de escuta
EXPOSE 8080
EXPOSE 9000

# Iniciando o apache
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

#postgre