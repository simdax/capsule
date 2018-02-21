(
Ndef(\rev, { arg mix = 0.5, room = 0.33, damp = 0.33;
	 FreeVerb.ar(\in.ar, mix, room, damp)
}).play;
Ndef(\hpf, { arg freq = 1, mul = 1;
	HPF.ar(\in.ar, LinLin.kr(freq, 0, 1, 20, 5000))
}).play;
Ndef(\pan, { arg side = 0;
	Pan2.ar(\in.ar, LinLin.kr(side, 0, 1, -1, 1))
}).play;
Ndef(\lpf, { arg freq = 1, mul = 1;
	 LPF.ar(\in.ar, LinLin.kr(freq, 0, 1, 20, 5000))
}).play;
Ndef(\phaser, { arg depth= 0.5, rate= 1, fb= 0.3, cfb= 0.1, rot= 1.5707963267949;
	Phaser1.ar(\in.ar, depth, rate, fb, cfb, rot)
});
)
