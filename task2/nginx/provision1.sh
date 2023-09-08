sudo apt-get update
sudo apt-get install -y openjdk-17-jre
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install -y jenkins
echo "--------Jenkins,Java installed"

echo "Skipping the initial setup"
echo 'JAVA_ARGS="-Djenkins.install.runSetupWizard=false"' >> /etc/default/jenkins

echo "Setting up users"
sudo rm -rf /var/lib/jenkins/init.groovy.d
sudo mkdir /var/lib/jenkins/init.groovy.d
sudo cp -v /vagrant/01_createAdminUser.groovy /var/lib/jenkins/init.groovy.d/

echo "Installing jenkins plugins"
sudo cp -v /vagrant/02_installPlugins.groovy /var/lib/jenkins/init.groovy.d/loadPlugins.groovy

echo "Restarting Jenkins"
sudo service jenkins restart

echo "Installing Nginx"
sudo apt-get update
sudo apt-get install -y nginx

echo "Generating ssl certificate"
sudo touch localhost.conf
sudo cp -v /vagrant/ssl_config.conf localhost.conf
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout localhost.key -out localhost.crt -config localhost.conf
sudo cp localhost.crt /etc/ssl/certs/localhost.crt
sudo cp localhost.key /etc/ssl/private/localhost.key

echo "Changing nginx configs"
sudo cp -v /vagrant/jenkins.itechart.labs /etc/nginx/sites-available/jenkins.itechart.labs
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/jenkins.itechart.labs /etc/nginx/sites-enabled/jenkins.itechart.labs
sudo systemctl restart nginx





