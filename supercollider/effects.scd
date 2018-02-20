(
Ndef(\rev, { arg mix = 0.5, room = 0.33, damp = 0.33;
	 FreeVerb.ar(\in.ar, mix, room, damp)
}).play;
Ndef(\hpf, { arg freq = 440, mul = 1;
	 HPF.ar(\in.ar, freq)
}).play;
Ndef(\lpf, { arg freq = 440, mul = 1;
	 LPF.ar(\in.ar, freq)
}).play;
)
