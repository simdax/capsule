(
s.waitForBoot({
	~buffer.free;
	Buffer.read(s, "son.wav".resolveRelative,
		action:{ |b|
			~buffer = b;
	})
})
)
(
Ndef(\player, { | rate=1 |
	PlayBuf.ar(2, ~buffer,
		rate,
		doneAction: Done.freeSelf)
});
Ndef(\effects, { |freq = 20|
	var sigIn = Ndef(\player) * 3;
	// var eq = LPF.ar(sigIn, LinLin.kr(freq, 0, 1, 200, 20000).poll);
	// var eq = LPF.ar(sigIn, MouseX.kr(200, 1000, 1, 0), 2);
	// var eq = LPF.ar(sigIn, Saw.kr(20, 200, MouseX.kr(150, 500)), 2);
	//var eq = LPF.ar(sigIn, SinOsc.kr(100, 0, 10, 4000), 2);
	var eq = FreeVerb.ar(sigIn, 1, 1);
	// var eq = Ringz.ar(sigIn, MouseX.kr(150, 200, 1), 0.125);
	// var eq = Resonz.ar(sigIn, MouseX.kr(3350, 5500, 1), 0.005, 0.0125);
	eq;
});
)

Ndef(\player).set(\rate, 0.7)

Ndef(\effects).fadeTime = 0;
Ndef(\effects).play

Ndef(\effects).set(\freq, 3)
