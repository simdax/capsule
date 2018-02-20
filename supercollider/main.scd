// main
(
var morceaux = [\nature, \debussy];
var effects = [\hpf, \rev];
var oscs = [\roll -> {Ndef(\rev).set()}];
var times = [10, 23];
Ndef(\main).fadeTime = 2;
Pbind(
	\type, \rest,
	\index, Pseries(),
	\ndef, Pseq(morceaux, inf),
	\effects, Pseq(effects, inf),
	\dur, Pseq(times, inf),
	\finish, Pfunc{ arg ev;
		Ndef(\main).source = Ndef(ev.ndef);
		(ev.effects.asArray ++ \main).reduce { arg a, b;
			Ndef(a) <<> Ndef(b)
		};
		true
	}
).trace.play
)
