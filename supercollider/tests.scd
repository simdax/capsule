(
var setOSC = {arg wiimote, address, ndef, value;
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
};
~setPart = { arg in, effects, oscs;
	([\out] ++ effects ++ \in).reduce{ arg a, b;
		a.postln; b.postln;
		Ndef(a) <<> Ndef(b); b;
	};
	OSCdef.freeAll;
	oscs.do{ arg args;
		setOSC.(*args);
	};
	Ndef(\in).source = Ndef(in).send;
};
)

(
"isadora.scd".resolveRelative.load;
)

(
~setPart.(\scriabine, [\hpf],
	[
		// [1, \roll, \hpf, \freq],
		// [2, \roll, \lpf, \freq],
	]
);
)