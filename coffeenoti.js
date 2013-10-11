// Generated by CoffeeScript 1.6.3
var endMessage, growl, i, minutes, pomodoroBreakMessage, pomodoroContinueMessage, pomodoroCount, pomodoros, printElapsedTime, restCount, rests, start, startMessage;

growl = require('growl');

i = 1;

minutes = restCount = pomodoroCount = pomodoros = rests = 0;

start = new Date;

startMessage = function() {
  var message;
  message = "Inicializando el conteo " + (start.toString());
  growl(message, {
    sticky: true,
    sound: 'default',
    title: 'CoffeeNoti'
  });
  return console.log(message);
};

pomodoroBreakMessage = function() {
  var message;
  message = "es un buen momento paratomar un descanso de 5 minutos";
  growl(message, {
    sticky: true,
    sound: 'default',
    title: 'CoffeeNoti'
  });
  return console.log(message);
};

pomodoroContinueMessage = function() {
  var message;
  message = "el tiempo de descanso termino, a trabajar!! llevas " + (pomodoros - 1) + " pomodoros";
  growl(message, {
    sticky: true,
    sound: 'default',
    title: 'CoffeeNoti'
  });
  return console.log(message);
};

endMessage = function() {
  var message;
  message = "Fin del conteo, pasaron: " + minutes + "m " + i + "s y lograste: " + (pomodoros - 1) + " pomodoros con " + rests + " descansos";
  growl(message, {
    sticky: true,
    sound: 'default',
    title: 'CoffeeNoti'
  });
  return console.log(message);
};

startMessage();

printElapsedTime = function() {
  if (i % 60 === 0) {
    if (restCount > 0) {
      restCount--;
      if (restCount === 0) {
        pomodoroContinueMessage();
        rests++;
      }
    } else {
      pomodoroCount++;
    }
    minutes++;
    i = 1;
    console.log("ET " + minutes + "m");
  }
  if (pomodoroCount % 25 === 0) {
    if (pomodoros > 0) {
      restCount = 5;
      pomodoroBreakMessage();
    }
    pomodoroCount = 1;
    pomodoros++;
  }
  return i += 1;
};

setInterval(printElapsedTime, 1000);

process.on('SIGTSTP', function() {
  endMessage();
  return process.exit(0);
});

process.on('SIGINT', function() {
  endMessage();
  return process.exit(0);
});
