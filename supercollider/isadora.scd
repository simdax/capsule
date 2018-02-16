(
var files = "db.yaml".resolveRelative.parseYAMLFile;
var action = {arg name, options;
	{arg b;
		"ready for : %\n".postf(name);
		~buffers.push(b);
		Ndef(name.asSymbol, { | rate = 1, t_trig = 1 |
			PlayBuf.ar(2, b,
				LinLin.kr(rate, 0, 1, 0.8, 1.1),
				t_trig,
				doneAction: Done.freeSelf)
		});
		options['effects'] !? {
			options['effects'].do{ arg effect;
				effect.keysValuesDo { arg key, opt;
					var name_effect = (name ++ "_" ++ key).asSymbol;
					name_effect.postln;
					Ndef(name_effect, { |freq = 1|
						var sigIn, rate;
						sigIn = Ndef(name.asSymbol);
						rate = LinExp.kr(freq, 0, 1, opt['range'][0], opt[\range][1]);
						HPF.ar(sigIn, rate);
						// opt[\type].ar(sigIn, rate);
					}).gui;
				}
			}
		}
	}
};
s.waitForBoot({
	~buffers.do(_.free);
	files.keysValuesDo{ |key, options|
		var name = key;
		Buffer.read(s, ("music/" ++ name ++ ".wav").resolveRelative,
			options['from'],
			options['to'],
			action.value(name, options)
		);
	}
})
)

Ndef(\scriabinevolumeA).gui
Ndef(\oud).stop