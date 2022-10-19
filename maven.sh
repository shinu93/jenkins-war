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
else
   echo "java is installed and its version is $(java -version 2>&1 | awk '/java/{print $3}') and its location is $JAVA_HOME." 
fi

# installing maven
echo "checking maven is installed in the system: "
mvn -version 2> /dev/null
if [ $? -ne 0 ]
 then
   echo "Maven is not installed, downloading package"
   wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz
   echo "extracting package: "
   tar -xvzf apache-maven-3.8.6-bin.tar.gz
   rm -rf apache-maven-3.8.6-bin.tar.gz
   mv apache* maven
   echo "M2_HOME=$PWD/maven" >> ~/.bash_profile
   echo "M2=$PWD/maven/bin" >> ~/.bash_profile
   echo "PATH=$PATH:$M2_HOME:$M2" >> ~/.bash_profile
else
  echo "maven is isntalled and it is located at $M2_HOME"
fi  

