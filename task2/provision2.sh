sudo apt-get update
sudo apt-get install -y openjdk-17-jre
wget -q -O /home/vagrant/swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.27/swarm-client-3.27.jar
# Start Jenkins Swarm client as a service
cat <<EOF | sudo tee /etc/systemd/system/jenkins-swarm.service
[Unit]
Description=Jenkins Swarm Client
After=network.target

[Service]
ExecStart=/usr/bin/java -jar /home/vagrant/swarm-client.jar -master http://172.20.11.10:8080 -username admin -password admin
Restart=always
Environment=JENKINS_URL=http://172.20.11.10:8080
Environment=JENKINS_TUNNEL=172.20.11.10:50000


[Install]
WantedBy=multi-user.target
EOF

# Enable and start the Jenkins Swarm client service
sudo systemctl enable jenkins-swarm
sudo systemctl start jenkins-swarm
