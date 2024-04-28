# This is a brief documentation of the process to setting up a php-laravel app on LAMP STACK

## STEP ONE
- I created the script that installed LAMP stack and also set - up a php laravel app that could be accessible on my master machine ip address.

- Here is a picture of the script running successfully
![script](/LAMP-Stack/screen-shots/script-run-1.png)
![script](/LAMP-Stack/screen-shots/script-run-2.png)
![script](/LAMP-Stack/screen-shots/script-run-3.png)
![script](/LAMP-Stack/screen-shots/script-run-4.png)
![script](/LAMP-Stack/screen-shots/script-run-5.png)
![script](/LAMP-Stack/screen-shots/script-run-6.png)
![script](/LAMP-Stack/screen-shots/script-run-7.png)

- The script is also here in this repo. You can also view it.

 - Picture of the laravel app being accessed through the master machine ip address (http://192.168.33.45/)

 ![Master machine output](/LAMP-Stack/screen-shots/app-on-master.png)

 ## STEP TWO
 - I then installed and configured ansible  and wrote a playbook to run the same script and get the same result i got on the master machine on the slave machine.

 - Here is a shot of the playbook after it ran successfully

 ![Slave machine output](/LAMP-Stack/screen-shots/playbook-run2.png)

 - Here is also a shot of the laravel app being accessed through the slave node ip address (http://192.168.33.51/)

 ![Slave machine output](/LAMP-Stack/screen-shots/app-on-slave.png)

