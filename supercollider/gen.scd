Event.addEventType(\ndef, {
	Ndef(~ndef).set(\freq, ~freq);
	Ndef(~ndef).send
})

(
Ndef(\a, { arg freq;
	var sig = SinOsc.ar(freq);

	sig * EnvGen.kr(Env.perc)
}).play;

)

Ndef(\a)[1]= {arg freq; SinOsc.ar(freq * 1.5, 0.542, 0.5)}
Ndef(\a)[2]= {arg freq; SinOsc.ar(freq * 1.05, 0.542, 0.5)}
Ndef(\a)[3]= 0
(
Pdef(\a, Pbind(
	\type, \ndef,
	\ndef, \a,
	\degree, Pseq([4, 0, 0, 1, 2], inf),
	\dur, Pseq([1, 2, 1, 3, 1], inf),
	\tempo, 15
)).play
)
