(
s.waitForBoot({
	~buffer.free;
	~applause.free;
	~ocean.free;
	Buffer.read(s, "ocean.wav".resolveRelative,
		action:{ arg b;
			~ocean = b;
	});
	Buffer.read(s, "applause.wav".resolveRelative, 44100 * 2.5, 44100 * 1,
		action:{ arg b;
			~applause = b;
	});
})
)
(
Ndef(\player, { | rate=1 |
	PlayBuf.ar(2, ~buffer,
		LinLin.kr(rate, 0, 1, 0.8, 1.1),
		doneAction: Done.freeSelf)
});
Ndef(\effects, { |freq = 1|
	var sigIn = Ndef(\player) * 10;
	var rate = LinLin.kr(freq, 0, 1, 200, 4000);
	var eq = HPF.ar(sigIn, rate);
	// var eq = LPF.ar(sigIn, MouseX.kr(200, 1000, 1, 0), 2);
	// var eq = LPF.ar(sigIn, Saw.kr(20, 200, MouseX.kr(150, 500)), 2);
	//var eq = LPF.ar(sigIn, SinOsc.kr(100, 0, 10, 4000), 2);
	// var out = FreeVerb.ar(eq, freq, 1);
	// var eq = Ringz.ar(sigIn, MouseX.kr(150, 200, 1), 0.125);
	// var eq = Resonz.ar(sigIn, MouseX.kr(3350, 5500, 1), 0.005, 0.0125);
	// out;
	eq;
});
)

Ndef(\waves, { |freq = 1|
	var sigIn = Ndef(\player) * 10;
	var rate = LinLin.kr(freq, 0, 1, 200, 4000);
	var eq = HPF.ar(sigIn, rate);
	eq;
});


Ndef(\player).play
Ndef(\player).set(\rate, 1)

Ndef(\effects).fadeTime = 0;
Ndef(\effects).play

Ndef(\effects).set(\freq, 0)


OSCFunc.trace