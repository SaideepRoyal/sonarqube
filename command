sudo apt update
sudo apt upgrade
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/pgdg.gpg
sudo apt update
sudo apt-get -y install postgresql postgresql-contrib
sudo systemctl enable postgresql
sudo passwd postgres (set the password)
su - postgres (to open)
createuser sonar
psql
ALTER USER sonar WITH ENCRYPTED password 'sonar';
CREATE DATABASE sonarqube OWNER sonar;
grant all privileges on DATABASE sonarqube to sonar;
\q
exit

sudo bash (to go for root folder)
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
apt update
apt install temurin-17-jdk
update-alternatives --config java
/usr/bin/java --version
exit

LINUX TERMAL TUNNING
sudo vim /etc/security/limits.conf (at the end of the file add ; sonarqube - nofile 65536 ; sonarqube - nproc  4096)
sudo vim /etc/sysctl.conf (At the end of the file ; vm.max_map_count = 262144)
sudo init 6 (to reboot the system)

SONARQUBE INSTALLATION
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.0.65466.zip
sudo apt install unzip
sudo unzip sonarqube-9.9.0.65466.zip -d /opt
sudo mv /opt/sonarqube-9.9.0.65466 /opt/sonarqube
sudo groupadd sonar
sudo useradd -c "user to run SonarQube" -d  /opt/sonarqube -g sonar sonar
sudo chown sonar:sonar /opt/sonarqube -R
sudo vim /opt/sonarqube/conf/sonar.properties (at user credentials remove # and add for sonar.jdbc.username=sonar & sonar.jdbc.password=sonar ; at postgres remove # and add for sonar.jdbc.url=jdbc:postresql://localhost:5432/sonarqube)
sudo vim /etc/systemd/system/sonar.service (add the file)



