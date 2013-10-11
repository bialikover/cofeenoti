#init vars
growl = require('growl')
i = 1
minutes = restCount = pomodoroCount = pomodoros = rests = 0
start = new Date

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

endMessage = ->
	message = "Fin del conteo, pasaron: #{minutes}m #{i}s y lograste: #{pomodoros-1} pomodoros con #{rests} descansos"	
	growl(message, {sticky: true, sound: 'default', title: 'CoffeeNoti'})
	console.log(message)

#core process
startMessage()
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

#start process
setInterval(printElapsedTime, 1000)

# end process listeners
process.on('SIGTSTP', -> 
  endMessage()
  process.exit(0)
);

process.on('SIGINT', -> 
  endMessage()
  process.exit(0)
);