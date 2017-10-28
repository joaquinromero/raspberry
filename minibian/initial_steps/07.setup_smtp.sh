#To install the ssmtp (Simple S.M.T.P) package, use the following command:
apt-get install ssmtp
#edit the configuration file:
nano /etc/ssmtp/ssmtp.conf
-------------
#Change it from postmaster to the machines admin’s Email.
root=username@gmail.com

#Gmail smtp server.
mailhub=smtp.gmail.com:587
#Usually the name of the machine is automatically filled by the package setup, if the machine has a mailbox this should be fine, but if it doesn’t or the name is not the same as the mailbox adjust accordingly.
hostname=username@gmail.com
#Enable TLS for secure session communication.
UseSTARTTLS=YES
#The username of the sending mailbox.
AuthUser=username
#The password of the sending mailbox.., notice special chars
AuthPass=password

#Sends the hostname instead of root[root@hostname.FQDN].
FromLineOverride=yes
------------
#In order to make the default (root) “from” field be the server name, edit the /etc/ssmtp/revaliases file:
nano /etc/ssmtp/revaliases
-----------
#And add into it the desired translation which in our Gmail examples case will be:
root:machine-name@some-domain.com:smtp.gmail.com
-----------

# test that ssmtp setup was correct by sending an Email:
#The “-vvv” turns on verbosity output so don’t get alarmed… this is just in case you encounter any problems, you will have some sort of output to Google for.
#If all goes well, you should be getting the Email in a couple of seconds.
echo "Test message from Linux server using ssmtp" | sudo ssmtp -vvv your-email@some-domain.com
