#!/bin/bash

sudo yum update -y && sudo yum upgrade -y
sudo yum install -y git

if [ -e /usr/bin/wget ]
 then
   echo "wget is installed"
else
   echo "installing wget to download packages: "
   yum install wget -y
fi

# downloading java package
echo "checking java is installed in the system: "
java -version 2> /dev/null
if [ $? -ne 0 ]
 then
   echo "java is not installed in the system, Downloading package"
   wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz
   echo "extracting package: "
   tar -xvzf jdk-17_linux-x64_bin.tar.gz
   rm -rf jdk-17_linux-x64_bin.tar.gz
   mv jdk* java
   echo "JAVA_HOME=$PWD/java/bin" >> ~/.bash_profile
   echo "PATH=$PATH:$JAVA_HOME" >> ~/.bash_profile
   echo "export PATH" >> ~/.bash_profile
   source ~/.bash_profile
else
   echo "java is installed and its version is $(java -version 2>&1 | awk '/java/{print $3}') and its location is $JAVA_HOME." 
fi

# installing tomcat
echo "checking tomcat is installed in the system: "
echo
echo
echo
if [ -e $PWD/tomcat ]
 then
   echo "tomcat is present"
else
   wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.68/bin/apache-tomcat-9.0.68.tar.gz
   tar -xvzf apache-tomcat-9.0.68.tar.gz
   rm -rf apache-tomcat-9.0.68.tar.gz
   mv apache* tomcat
fi
