oo(
Event.addEventType(\ndef, {
	Ndef(~ndef).set(\freq, ~freq);
	Ndef(~ndef).send
});
Ndef.clear;
NdefMixer(s)
Pdef.gui
)

(
var vols = Array.exprand(4, 1, 0.1);

Ndef(\a, { arg freq, nbHarmo = 4, vol=0.2;
	var harmo = Array.exprand(nbHarmo, 1, 10);
	SinOsc.ar([freq * harmo],
		[0.15, 0.4],
		Array.fill(8, {arg i; vol / (i + 1)})
	)
	* EnvGen.kr(Env.perc)
});
//Ndef(\a)[1] = {arg freq; SinOsc.ar(freq * 1.5, 0.542, 0.5)}

)

(
Pdef(\a, Pbind(
	\type, \ndef,
	\ndef, \a,
	\degree, Pseq([4, 0, 0, 1, 2], inf),
	\dur, Pseq([1, 1, 2, 1, 3, 1], inf),
	\tempo, 3
)).play
)
(
Pdef(\accords, Pbind(
	\type, \ndef,
	\ndef, \a,
	\degree, [0, 2, 4].rotate(4),
	\octave, [1,2,3,4,5,6,7]
.)).play
)

{
	arg type = 1,
	renversement = ;
	Array.fill(3, {arg i; (i < 3).asInt})

}