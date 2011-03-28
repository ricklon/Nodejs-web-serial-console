var serialport = require("serialport");
var SerialPort = serialport.SerialPort; // localize object constructor
var sys = require("sys");
var count = 0;  


var sp = new SerialPort("/dev/tty.usbmodemfa141", { 
        parser: serialport.parsers.readline("\n"), 
	baudrate: 9600

});

//This line is asynchronous
sp.on("data", function (data) {
	console.log("Count: " + count++ + " Data: " + data);
  });

sp.write("25,25,25\r");
sp.write("255,255,255\r");

sp.write("25,25,25\r");

sp.write("0,0,0\r");



