// start main process, loading every sounds
(
"isadora.scd".resolveRelative.load;
)
// helpers:
// setPart put an effect and link it with wiimote
(
var setOSC = {arg wiimote, address, ndef, value;
	// type of event
	var add = 'wii/' ++ wiimote ++ '/' ++ (
		'roll': "accel/pry/0",
		'yaw': "accel/pry/1",
		'pitch': "accel/pry/2",
		'accel': "accel/pry/3",
		'A': "button/A",
		'B': "button/B",
	)[address] ? address;
	// add a callback for the OSC event
	OSCdef(add.postln, { arg msg;
		Ndef(ndef).xset(value, msg[1].asFloat.postln)
	}, add);
};
~setPart = { arg in, effects, oscs;
	// sound generators chain
	([\out] ++ effects ++ \in).reduce{ arg a, b;
		Ndef(a) <<> Ndef(b); b;
	};
	// OSC
	OSCdef.freeAll; //clean
	oscs.do{ arg args; //then set for every array
		setOSC.(*args);
	};
	Ndef(\in).source = Ndef(in).send; //set source and start play
};
)
// test with Scriabine
// you can adapt the gain of every block in the chain
// you have to read it from right to left (scriabine then lpf then hpf then out)
(
~setPart.(\scriabine, [\hpf, \lpf],
	[
		// the effect chain
		// which wiimote, wich part of the wiimote, wich effect, wich param in this effect
		[1, \roll, \hpf, \freq],
		[2, \roll, \lpf, \freq],
	]
);
)

// DO YOUR TEST with the GUI that appears
// TRY changing the gain for every effect manually
// THEN with the wiimote

// GOOD LUCK :) HAVE FUN !