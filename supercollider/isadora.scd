(
var files = "db.yaml".resolveRelative.parseYAMLFile;
var action = {arg name, options;
	{arg b;
		"ready for : %\n".postf(name);
		~buffers = ~buffers.add(b);
		Ndef(name.asSymbol, { | rate = 1, t_trig = 1 |
			PlayBuf.ar(2, b,
				LinLin.kr(rate, 0, 1, 0.8, 1.1),
				t_trig,
				doneAction: Done.freeSelf)
		});
		options["effects"].do{ arg effect;
			effect.keysValuesDo { arg key, opt;
				var name_effect = (name ++ "_" ++ key).asSymbol;
				name_effect.postln;
				Ndef(name_effect.asSymbol, { |freq = 1|
					var sigIn, rate;
					sigIn = Ndef(name.asSymbol);
					rate = LinExp.kr(freq, 0, 1, opt["range"][0].asFloat, opt["range"][1].asFloat);					opt["type"].asSymbol.asClass().ar(sigIn, rate);
				});
			}
		}
	}
};
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
