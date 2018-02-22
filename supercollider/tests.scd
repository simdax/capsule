(
var setOSC = {arg wiimote, address, ndef, value;
	var add = 'wii/' ++ wiimote ++ '/' ++ (
		'pitch': "accel/pry/0",
		'roll': "accel/pry/1",
		'yaw': "accel/pry/2",
		'accel': "accel/pry/3",
		'A': "button/A",
		'B': "button/B",
	)[address] ? address;
	OSCdef(add.postln, { arg msg;
		Ndef(ndef).xset(value, msg[1].asFloat)
	}, add);
};
~setPart = { arg in, effects, oscs;
	([\out] ++ effects ++ \in).reduce{ arg a, b;
		Ndef(a) <<> Ndef(b); // chaining
		b; // just syntax (must return symbol and not ndef instance in reduce chain)
	};
	OSCdef.freeAll;
	oscs.do{ arg args;
		setOSC.(*args);
	};
	Ndef(\in).source = Ndef(in).send;
};
)


(
Window.closeAll;
"isadora.scd".resolveRelative.load;
)

(
	~setPart.(\nature, [\hpf],
	[
		[1, \pitch, \hpf, \freq],
		//	[1, \roll, \lpf, \freq],
	]
);
)
