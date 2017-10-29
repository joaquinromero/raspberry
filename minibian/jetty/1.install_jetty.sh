#!/bin/bash
cd /usr/lib
wget http://central.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.7.v20170914/jetty-distribution-9.4.7.v20170914.tar.gz
tar -xzvf jetty-distribution-9.4.7.v20170914.tar.gz
rm jetty-distribution-9.4.7.v20170914.tar.gz
mv jetty-distribution-9.4.7.v20170914/ jetty-9.4.7
