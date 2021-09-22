# Linux_server_services_checker_v1
Script to monitor services on a Linux env, as it is works only with slack integration but email alerting could be another option.
The script works by attaching "tags" to every working and runnuning service, it will then check again a list or services provided by the user and also that services agains it own tag to avoid repetive alerting.
+
+
After stracting the content of the zip file, create a folder called "tags" inside the main folder.
Vim the .sh file and add the services to be monitored and the slack integration key in their respective variables.
When this is done, run the script manually the first time, if the script is able to find your serivces will create a tag file inside your tags folder for each services, is a perticular services isn't found the the correct services system name.
