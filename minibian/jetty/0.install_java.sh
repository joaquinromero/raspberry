#!/bin/bash
#download oracle java
wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-arm32-vfp-hflt.tar.gz
mkdir /usr/lib/jvm
mv jdk-8u151-linux-arm32-vfp-hflt.tar.gz /usr/lib/jvm/
cd /usr/lib/jvm/
tar -xzvf jdk-8u151-linux-arm32-vfp-hflt.tar.gz
rm /usr/lib/jvm/jdk-8u151-linux-arm32-vfp-hflt.tar.gz

# add the new jdk alternatives (2000 is the priority and feel free to pick a different number):
update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk1.8.0_151/jre/bin/java 2000
update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_151/bin/javac 2000
# Now you should see the new jdk listed and you can switch between the alternatives with this command:
update-alternatives --config java
update-alternatives --config javac

nano /etc/profile.d/oraclejdk.sh
---------------
export J2SDKDIR=/usr/lib/jvm/jdk1.8.0_151
export J2REDIR=/usr/lib/jvm/jdk1.8.0_151/jre
export PATH=$PATH:/usr/lib/jvm/jdk1.8.0_151/bin:/usr/lib/jvm/jdk1.8.0_151/db/bin:/usr/lib/jvm/jdk1.8.0_151/jre/bin
export JAVA_HOME=/usr/lib/jvm/jdk1.8.0_151
export DERBY_HOME=/usr/lib/jvm/jdk1.8.0_151/db
# logout or restart, so if you want to use them right away run source /etc/profile.d/oraclejdk.sh
