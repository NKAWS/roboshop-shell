   echo"<<<<<<<<<<<<<<<<Create Catalogue Service >>>>>>>>>>>>>>>"
cp catalogue.service /etc/systemd/system/catalogue.service
   echo"<<<<<<<<<<<<<<<<Create Mongodb Repo >>>>>>>>>>>>>>>"
cp mongo.repo /etc/yum.repos.d/mongo.repo
   echo"<<<<<<<<<<<<<<<<Install nodejs Repos >>>>>>>>>>>>>>>"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
   echo"<<<<<<<<<<<<<<<<Install NodeJS >>>>>>>>>>>>>>>"
yum install nodejs -y
   echo "<<<<<<<<<<<<<<<<Create Application User >>>>>>>>>>>>>>>"
useradd roboshop
   echo"<<<<<<<<<<<<<<<<Create Application Directory >>>>>>>>>>>>>>>"
mkdir /app
   echo"<<<<<<<<<<<<<<<<Download Application Content >>>>>>>>>>>>>>>"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
    echo"<<<<<<<<<<<<<<<<Extraction Application Content >>>>>>>>>>>>>>>"
cd /app
unzip /tmp/catalogue.zip
cd /app
    echo"<<<<<<<<<<<<<<<<Download nodeJS dependencies >>>>>>>>>>>>>>>"
npm install
    echo"<<<<<<<<<<<<<<<<Install Mongo client >>>>>>>>>>>>>>>"
yum install mongodb-org-shell -y
    echo"<<<<<<<<<<<<<<<<Load Catalogue schema >>>>>>>>>>>>>>>"
mongo --host mongodb.nkdevops74.online </app/schema/catalogue.js

    echo"<<<<<<<<<<<<<<<<Start Catalogue service >>>>>>>>>>>>>>>"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
