(
Ndef(\rev, { arg mix, room, damp;
	 FreeVerb.ar(\in.ar, mix, room, damp)
}).play;
Ndef(\hpf, { arg freq, mul;
	 HPF.ar(\in.ar, freq, mul)
}).play;
Ndef(\lpf, { arg freq, mul;
	 LPF.ar(\in.ar, freq, mul)
}).play;
)
