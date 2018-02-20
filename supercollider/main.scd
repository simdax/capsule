// main
(
var toggleNdef = {arg ndef;
	if (dico[ndef.asSymbol])
	{Ndef(ndef).stop; dico[ndef.asSymbol] = false}
	{Ndef(ndef).play; dico[ndef.asSymbol] = true}
};
var morceaux = [\nature, \debussy, ];
var effect =   [[\hpf], \rev];
var times = [10];
var dico = (debussy: false, nature: false);
Pbind(
	\type, \rest,
	\index, Pseries(),
	// \dur, Pseq(times, inf),
	\finish, Pfunc{ arg ev;
		morceaux[ev.index].asArray
		.do { arg piece;
			toggleNdef.(piece)
		};
		true
	}
).trace.play
)
