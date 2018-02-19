(
var files = "db.yaml".resolveRelative.parseYAMLFile;
var effects = "effects.scd".resolveRelative.load;
var action = {arg name, options;
	{arg b;
		"ready for : %\n".postf(name);
		~buffers = ~buffers.add(b);
		Ndef(name.asSymbol, { | rate = 1, t_trig = 1, pan, hpf, lpf, gain|
			PlayBuf.ar(2, b,
				LinLin.kr(rate, 0, 1, 0.8, 1.1),
				t_trig,
				doneAction: Done.freeSelf)
		});
		effects.(name.asSymbol);
	}
};
~files = files;
s.waitForBoot({
	Ndef.clear;
	Spec.add(\freq, [0, 1, \lin, 0.001]);
	~buffers.do(_.free);
	~buffers = [];
	files.keysValuesDo{ |key, options|
		var name = key;
		Buffer.read(s, ("music/" ++ name ++ ".wav").resolveRelative,
			options['from'],
			options['to'],
			action.value(name, options)
		);
	};
	NdefMixer(s);
});
)

(
var toggleNdef = {arg ndef;
	if (dico[ndef.asSymbol])
	{Ndef(ndef).stop; dico[ndef.asSymbol] = false}
	{Ndef(ndef).play; dico[ndef.asSymbol] = true}
};
var morceaux = [\debussy, \nature, \debussy, [\debussy, \nature]];
var times = [10];
var dico = (debussy: false, nature: false);
Pbind(
	\type, \rest,
	\index, Pseries(),
	\dur, Pseq(times, inf),
	\finish, Pfunc{ arg ev;
		morceaux[ev.index].asArray
		.do { arg piece;
			toggleNdef.(piece)
		};
		true
	}
).trace.play
)