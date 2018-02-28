#!/Applications/SuperCollider/SuperCollider.app/Contents/MacOS/sclang

(
s.waitForBoot({
	var w = FlowView(bounds:400@200);
	Buffer.readChannel(s, "oudLoop.wav".resolveRelative,
		channels: 1,
		action: { arg b;
			a = b;
			Ndef(\oud, { arg rate = 1;
				PlayBuf.ar(1, b, rate,
					loop:1
				);
			})
		}
	);
	OSCdef(\rhythm, { arg msg;
		var val = msg[4].asFloat
		.linexp(0.2, 1, 1, 3, 3);
		Ndef(\oud).set(\rate, val);
	}, "/wii/1/accel/pry").disable;
	StaticText(w, 400@100)
	.string_("Brancher la manette 1.
Si des problemes sont à noter, verifier qu'osculator envoie bien le message /wii/1/accel/pry à localhost:57120 dans OSCulator.");
	Button(w)
	.string_("play")
	.action_{
		Ndef(\oud).play;
		Ndef(\oud).send;
		OSCdef(\rhythm).enable;
	};
	Button(w)
	.string_("stop")
	.action_{
		Ndef(\oud).stop;
		OSCdef(\rhythm).disable;
	};
});
)

// (
// // this generates sounds according to beats
// {
// 	var sig, chain, onsets, pips;
// 	// A simple generative signal
// 	// or, uncomment this line if you want to play the buffer in
// 	sig = PlayBuf.ar(1, a, BufRateScale.kr(a), loop: 1);
// 	chain = FFT(LocalBuf(512), sig);
// 	onsets = Onsets.kr(chain, MouseX.kr(0,4), \magsum);
// 	// You'll hear percussive "ticks" whenever an onset is detected
// 	pips = WhiteNoise.ar(EnvGen.kr(Env.perc(0.001, 0.1, 0.2), onsets));
// 	Pan2.ar(sig, -0.75, 0.2) + Pan2.ar(pips, 0.75, 1)
// }.play;
// )
