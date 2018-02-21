// boucle principale
// lance main loop ++ effects ++ OSCs
(
// les differents morceaux effets dans l'ordre
// les keys avec underscore sont retires
var morceaux = [\nature, \debussy, [\_debussy, \oud], [\scriabine, \_oud]];
var effects = [\hpf];
var oscs = [
	[
		['wii/2/accel/pry/0', \hpf, \freq],
		// ['wii/2/accel/pry/0', \lpf, \freq]
	],
	// [
	// 	['wii/2/accel/pry/0', \rev, \room],
	// 	['wii/2/accel/pry/1', \rev, \damp]
	// ],
];
var times = [];
// transition entre les morceaux
Ndef(\main).fadeTime = 5;
Pbind(
	\type, \rest,
	\ndef, Pseq(morceaux, inf),
	\effects, Pseq(effects, inf),
	\oscs, Pseq(oscs, inf),
	\dur, Pseq(times, inf),
	\finish, Pfunc{ arg ev;
		// main func
		// remove underscores
		var effects = ev.effects.asArray;
		var ndefs = ev.ndef.asArray;
		[effects, ndefs].do { arg set;
			set.removeAllSuchThat{arg el; el.asString[0] == $_}
			.do{arg fx; Ndef(fx).stop};
		};
		// set main buffer
		Ndef(\main).source = Ndef(ndefs[0]);
		// and chain with effects
		(effects ++ \main).reduce { arg a, b;
			Ndef(a) <<> Ndef(b)
		};
		// play and do not return ndef (trick)
		Ndef(effects[0]).play;
		// bind with osc
		ev.oscs.do { arg osc;
			OSCdef(osc[0], { arg msg;
				Ndef(osc[1]).set(osc[2], msg[1].asFloat);
			}, osc[0]);
		};
		true
	}
).trace.play
)
