// Generated by CoffeeScript 1.6.3
var endMessage, endProcess, fs, growl, hours, i, minutes, minutes_left, pomodoroBreakMessage, pomodoroContinueMessage, pomodoroCount, pomodoros, printElapsedTime, printResults, pritifyReport, prompt, restCount, rests, savePath, start, startMessage, writeReport;

growl = require('growl');

fs = require('fs');

prompt = require('prompt');

i = 1;

minutes = restCount = pomodoroCount = pomodoros = rests = hours = minutes_left = 0;

start = new Date;

savePath = __dirname + ("/reports/report_on_" + (start.toDateString().split(" ").join("-")) + ".txt");

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

endMessage = function(hours, minutes_left) {
  var message;
  message = "Fin del conteo, pasaron: " + hours + "h " + minutes_left + "m " + i + "s y lograste: " + (pomodoros - 1) + " pomodoros con " + rests + " descansos";
  growl(message, {
    sticky: true,
    sound: 'default',
    title: 'CoffeeNoti'
  });
  return console.log(message);
};

printResults = function() {
  hours = Math.round(minutes / 60);
  minutes_left = minutes % 60;
  return endMessage(hours, minutes_left);
};

pritifyReport = function(description) {
  var buffer;
  return buffer = "\nEl dia de hoy inverti 			 " + hours + "h " + minutes_left + "m " + i + "s haciendo " + description + ", 			 inicie a las " + (start.toTimeString()) + " y terminé a las " + (new Date().toTimeString());
};

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

writeReport = function(file, description) {
  var buffer;
  buffer = pritifyReport(description);
  return fs.appendFile(file, buffer, function(err) {
    if (err) {
      throw err;
    }
    console.log('It\'s saved!');
    return endProcess();
  });
};

startMessage();

setInterval(printElapsedTime, 1000);

process.on('SIGTSTP', function() {
  printResults();
  return writeReport(savePath, "prueba");
});

process.on('SIGINT', function() {
  printResults();
  return writeReport(savePath, "prueba");
});

endProcess = function() {
  return process.exit(0);
};

/*
//@ sourceMappingURL=coffeenoti.map
*/
