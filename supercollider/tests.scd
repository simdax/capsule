(
~setOSC = {arg wiimote, address, ndef, value;
	var add = 'wii/' ++ wiimote ++ '/' ++ (
		'roll': "accel/pry/0",
		'yaw': "accel/pry/1",
		'pitch': "accel/pry/2",
		'accel': "accel/pry/3",
		'A': "button/A",
		'B': "button/B",
	)[address] ? address;
	OSCdef(add.postln, { arg msg;
		Ndef(ndef).xset(value, msg[1].asFloat.postln)
	}, add);
}
)

(
Ndef(\hpf) <<> Ndef(\lpf) <<> Ndef(\nature);
OSCdef.freeAll;
~setOSC.(1, \roll, \hpf, \freq);
~setOSC.(2, \pitch, \lpf, \freq);
Ndef(\nature).send;
Ndef(\hpf).play;
)

(
Ndef(\phaser) <<> Ndef(\scriabine);
Ndef(\phaser).play
)
