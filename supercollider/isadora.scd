(
var files = "db.yaml".resolveRelative.parseYAMLFile;
s.waitForBoot({
	files.keysValuesDo{ |key, options|
		var name = key;
		"opening %\n".postf(name);
		Buffer.read(s, ("music/" ++ name ++ ".wav").resolveRelative,
			options['from'],
			options['to'],
			action:	{arg b;
				Ndef(name.asSymbol, { | rate = 1, t_trig = 1 |
					PlayBuf.ar(2, b,
						LinLin.kr(rate, 0, 1, 0.8, 1.1),
						t_trig,
						doneAction: Done.freeSelf)
					)
				});
				options['effects'] !? {
					options['effects'].do{ arg effect;
					effect.keysValuesDo { effect_name, opt;
						Ndef((name ++ effect_name).asSymbol, { |freq = 1|
							var sigIn, rate;
							sigIn = Ndef(name.asSymbol);
							rate = LinExp.kr(freq, 0, 1, opt['range'][0], opt[\range][1]);
							HPF.ar(sigIn, rate);
							// opt[\type].ar(sigIn, rate);
						});
					} }
				}
			)
		}
	})
)