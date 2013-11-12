# Simple coffeescript-node Notifier
This little snippet counts how much time have you spended in the task via growl notification, and it also throws a message using pomodoro technique.

= Why another notifier?
I wanted to learn coffeescript...
 And I got a problem: 
 For project management I wanted to count how much time I spend in certain task or project, so i decided to install a timer, but i didnt feel like using one from the app store, so I decided build my own in coffescript!

# Instalation
you just need to have node and npm installed.

= Install node-growl:

https://github.com/visionmedia/node-growl
 note: you can use ruby o brew to install terminal-notifier...
	   brew install terminal-notifier
node growl mod with sound package comes with this version.
make a dir for your reports eg: mkdir reports in  the same level of this file.

# How To use:
To start simply:
	node coffeenoti.js or
	coffee coffeenoti.coffee

To finish
	ctr + z || ctr + c
	and then type a comment in which you where working on.

Feel free to use or improve it :)

