#init vars
growl = require 'growl'
fs = require 'fs'
prompt = require 'prompt'
i = 1
minutes = restCount = pomodoroCount = pomodoros = rests = hours = minutes_left = 0
start = new Date
savePath = __dirname + "/reports/report_on_#{start.toDateString().split(" ").join("-")}.txt"

#messages:
startMessage = ->
	message = "Inicializando el conteo #{start.toString()}"
	growl(message, {sticky: true, sound: 'default', title: 'CoffeeNoti' })
	console.log(message)	
	
pomodoroBreakMessage = ->
	message = "es un buen momento paratomar un descanso de 5 minutos"
	growl(message, {sticky: true, sound: 'default', title: 'CoffeeNoti'})
	console.log(message)

pomodoroContinueMessage = ->
	message = "el tiempo de descanso termino, a trabajar!! llevas #{pomodoros-1} pomodoros"
	growl(message, {sticky: true, sound: 'default', title: 'CoffeeNoti'})
	console.log(message)

endMessage =(hours, minutes_left) ->
	message = "Fin del conteo, pasaron: #{hours}h #{minutes_left}m #{i}s y lograste: #{pomodoros-1} pomodoros con #{rests} descansos"	
	growl(message, {sticky: true, sound: 'default', title: 'CoffeeNoti'})
	console.log(message)

#print results
printResults = ->
	hours = Math.round(minutes/60)
	minutes_left = minutes%60
	endMessage(hours, minutes_left)

pritifyReport = (description) ->
	buffer = "\nEl dia de hoy inverti #{hours}h #{minutes_left}m #{i}s haciendo #{description}, inicie a las #{start.toTimeString()} y terminé a las #{new Date().toTimeString()}"

#core process
printElapsedTime = ->		
	if i%60 == 0
		if restCount > 0  
			restCount-- 
			if restCount == 0
				pomodoroContinueMessage()
				rests++
		else 
			pomodoroCount++			
		minutes++		
		i=1
		console.log("ET #{minutes}m")
	if pomodoroCount % 25 == 0
		if pomodoros > 0
			restCount = 5		
			pomodoroBreakMessage()
		pomodoroCount = 1		
		pomodoros++
	i += 1	

#read today's report if already exists or creates a new report file
writeReport = (file, description)->
	buffer = pritifyReport(description)	
	fs.appendFile file, buffer, (err) ->
  		if err 
  			throw err
  		console.log('It\'s saved!')
  		endProcess()

#ask for description
askForDescription = ->
	process.stdin.resume();
	process.stdin.setEncoding('utf8');
	#i left coding here...


#start process
startMessage()
setInterval(printElapsedTime, 1000)

# end process listeners
process.on('SIGTSTP', -> 
  printResults()
  description = askForDescription()
  writeReport(savePath, description)
);

process.on('SIGINT', -> 
  printResults()
  description = askForDescription()
  writeReport(savePath, description)
);

#end process 
endProcess = ->
	process.exit(0)