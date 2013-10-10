growl = require('growl')
i = 1
minutes = null
restCount = pomodoroCount = 0
pomodoros = rests = 0
start = new Date
startMessage = "inicializando el conteo #{start.toString()}"
growl(startMessage)
console.log(startMessage)

printElapsedTime = ->		
	if i%60 == 0
		if restCount > 0 then restCount--
		minutes++
		i=1
		message = "han pasado #{minutes} minutos"		
		console.log(message)
	if minutes % 25 == 0 && restCount==0
		if pomodoros > 0 
			rests++
			message = "es un buen momento paratomar un descanso de 5 minutos"			
		pomodoros++
		restCount = 300		
		growl(message, {sticky: true})
	i += 1	

setInterval(printElapsedTime, 1000)

process.on('SIGTSTP', -> 
  endMessage()
  process.exit(0)
);

process.on('SIGINT', -> 
  endMessage()
  process.exit(0)
);

endMessage = ->
	message = "Fin del conteo, pasaron: #{minutes}m #{i}s y lograste: #{pomodoros} pomodoros con #{rests} descansos"
	console.log(message)
	growl(message, {sticky: true})