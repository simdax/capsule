(
var in = {\in.ar};
// Ndef.clear;
// always play this both ugens (in - out)
Ndef(\in).play;
Ndef(\out, { arg side = 0;
	// SoundIn.ar(in.value);
	Limiter.ar(
		Pan2.ar(in.value, LinLin.kr(side, 0, 1, -1, 1))
	)
}).play;
// list of differents effects to plug between
Ndef(\rev, { arg mix = 0.5, room = 0.33, damp = 0.33;
	FreeVerb.ar(in.value, mix, room, damp)
});
Ndef(\hpf, { arg freq = 1, mul = 1;
	HPF.ar(in.value, LinLin.kr(freq, 0, 1, 20, 20000).poll)
});
Ndef(\lpf, { arg freq = 1, mul = 1;
	LPF.ar(in.value, LinLin.kr(freq, 0, 1, 20, 20000))
});
Ndef(\phaser, { arg depth = 0.5, rate = 1, fb = 0.3, cfb = 0.1, rot = 1.5707963267949;
	Phaser1.ar(in.value, depth, rate, fb, cfb, rot)
});
)
