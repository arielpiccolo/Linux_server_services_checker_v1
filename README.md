# Linux_server_services_checker_v1
Ready to use script, as it is works only with slack integration but email alerting can be another option.
+
+
After stracting the content of the zip file, create a folder called "tags" inside the main folder.
Vim the .sh file and add the services to be monitored and the slack integration key in their respective variables.
When this is done, run the script manually the first time, if the script is able to find your serivces will create a tag file inside your tags folder for each services, is a perticular services isn't found the the correct services system name.
