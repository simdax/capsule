(
// load files infos
var files = "db.yaml".resolveRelative.parseYAMLFile;
// add effects to tracks callback
var effects = "effects.scd".resolveRelative.load; //module loader
// put sound files in playable tracks callback
var action = {arg name, options;
	{arg b;
		"ready for : %\n".postf(name);
		~buffers = ~buffers.add(b);
		Ndef(name.asSymbol, { | rate = 1, pos=0,  t_trig = 1, pan, hpf, lpf, gain|
			Pan2.ar(PlayBuf.ar(2, b,
				LinLin.kr(rate, 0, 1, 0.8, 1.1),
				t_trig,
				doneAction: Done.freeSelf)
			, pos)
		});
		effects.(name.asSymbol);
	}
};
// load sound files in memory
// here global (for reload no leak managment --- tldr)
~files = files;
s.waitForBoot({
	Ndef.clear;
	// here are range inputs
	Spec.add(\freq, [0, 1, \lin, 0.001]);
	~buffers.do(_.free);
	~buffers = [];
	// load
	files.keysValuesDo{ |key, options|
		var name = key;
		Buffer.read(s, ("music/" ++ name ++ ".wav").resolveRelative,
			options['from'],
			options['to'],
			action.value(name, options)
		);
	};
	// gui
	NdefMixer(s);
});
// main player
"main.scd".resolveRelative.load;
)
