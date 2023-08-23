log = ${log}
   echo -e "\e[36m<<<<<<<<<<<<<<<< Create Catalogue Service >>>>>>>>>>>>>>\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service &>>${log}
   echo -e "\e[36m<<<<<<<<<<<<<<<< Create Mongodb Repo >>>>>>>>>>>>>>\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repoec &>>${log}
   echo -e "\e[36m<<<<<<<<<<<<<<<< Install nodejs Repos >>>>>>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
   echo -e "\e[36m<<<<<<<<<<<<<<<< Install NodeJS >>>>>>>>>>>>>>\e[0m"
yum install nodejs -y &>>${log}
   echo -e "\e[36m<<<<<<<<<<<<<<<< Create Application User >>>>>>>>>>>>>>\e[0m"
useradd roboshop &>>${log}
   echo -e "\e[36m<<<<<<<<<<<<<<<< Cleaning the content >>>>>>>>>>>>>>\e[0m"
rm -rf /app &>>${log}
   echo -e "\e[36m<<<<<<<<<<<<<<<< Create Application Directory >>>>>>>>>>>>>>\e[0m"
mkdir /app &>>${log}
   echo -e "\e[36m<<<<<<<<<<<<<<<< Download Application Content >>>>>>>>>>>>>>\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}
    echo -e "\e[36m<<<<<<<<<<<<<<<< Extraction Application Content >>>>>>>>>>>>>>\e[0m"
cd /app
unzip /tmp/catalogue.zip &>>${log}
cd /app
    echo -e "\e[36m<<<<<<<<<<<<<<<< Download nodeJS dependencies >>>>>>>>>>>>>>\e[0m"
npm install &>>${log}
    echo -e "\e[36m<<<<<<<<<<<<<<<<Install Mongo client >>>>>>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y &>>${log}
    echo -e "\e[36m<<<<<<<<<<<<<<<< Load Catalogue schema >>>>>>>>>>>>>>\e[0m"
mongo --host mongodb.nkdevops74.online </app/schema/catalogue.js &>>${log}

    echo -e "\e[36m<<<<<<<<<<<<<<<< Start Catalogue service >>>>>>>>>>>>>>\e[0m"
systemctl daemon-reload &>>${log}
systemctl enable catalogue &>>${log}
systemctl restart catalogue &>>${log}
