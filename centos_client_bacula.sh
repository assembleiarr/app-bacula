#!/bin/bash
# /root/bacula_enterprise_install.sh
# Centos 7
# Altere abaixo de acordo com o URL exclusivo do pacote de boas vindas da Bacula Enterprise
# Ex.: in https://www.baculasystems.com/dl/<xxx>/rpms/bin/8.6.5/rhel7-64/
secret_url="<xxx>"
# Mude a seguir de acordo com a versão que deseja instalar:
version="10.0.8"
# Isso vai configurar o repositório do Bacula Enterprise (não mude mais nada):
rpm --import https://www.baculasystems.com/dl/keys/BaculaSystems-Public-Signature-08-2017.asc
echo "
[Bacula-Enterprise]
name = Red Hat Enterprise - Bacula-Enterprise
baseurl = https://www.baculasystems.com/dl/"$secret_url"/rpms/bin/"$version"/rhel7-64/
enabled = 1
protect = 0
gpgcheck = 1
" > /etc/yum.repos.d/Bacula-Enterprise.repo
yum -y install bacula-enterprise-client
service bacula-fd restart
# Bacula Client instalado com sucesso.
# Regras de Firewall
# Se Firewalld
firewall-cmd --permanent --zone=public --add-port=9102/tcp
service firewalld restart
# Desabilita selinux:
setenforce 0
sudo sed -i "s/enforcing/disabled/g" /etc/selinux/config
