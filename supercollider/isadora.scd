(
s.waitForBoot({
	["ocean", "son"].do { arg name;
		Buffer.read(s, (name ++ ".wav").resolveRelative,
		action:	{arg b;
				Ndef(name.asSymbol, { | rate = 1 |
					PlayBuf.ar(2, b,
						LinLin.kr(rate, 0, 1, 0.8, 1.1),
						doneAction: Done.freeSelf)
				});
		})
	}
})
)

(

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

(
Ndef(\waves, { |freq = 1|
	var sigIn = Ndef(\ocean) * 1;
	var rate = LinExp.kr(freq, 0, 1, 20, 15000).poll;
	var eq = HPF.ar(sigIn, rate);
	eq;
});
)

Ndef(\ocean).play
Ndef(\waves).set()play

Ndef(\ocean).set(\rate, 1)

Ndef(\effects).fadeTime = 0;
Ndef(\effects).play

Ndef(\effects).set(\freq, 0)


OSCFunc.trace