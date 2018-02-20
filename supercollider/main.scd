// boucle principale
// lance main loop ++ effects ++ OSCs
(
// les differents morceaux effets dans l'ordre
// les keys avec underscore sont retires
var morceaux = [\nature, \debussy, [\_debussy, \scriabine], [\_scriabine, \oud]];
var effects = [\hpf, [\_hpf, \rev]];
var oscs = [\roll -> {Ndef(\rev).set()}];
var times = [1];
// transition entre les morceaux
Ndef(\main).fadeTime = 2;
Pbind(
	\type, \rest,
	\index, Pseries(),
	\ndef, Pseq(morceaux, inf),
	\effects, Pseq(effects, inf),
	\dur, Pseq(times, inf),
	\finish, Pfunc{ arg ev;
		// main func
		// remove underscores
		var effects = ev.effects.asArray;
		var ndefs = ev.ndef.asArray;
		[effects, ndefs].do { arg set;
			set.removeAllSuchThat{arg el; el.asString[0] == $_}
			.do{arg fx; fx.postln; Ndef(fx).stop};
		};
		// set main buffer
		Ndef(\main).source = Ndef(ndefs[0]);
		// and chain with effects
		(effects ++ \main).reduce { arg a, b, i;
			a.postln;
			Ndef(a) <<> Ndef(b)
		};
		// play and do not return ndef (trick)
		Ndef(effects[0]).play;
		true
	}
).trace.play
)
