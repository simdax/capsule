(
var b = r{ |val|
	var zigzag = [0, 3, -1, 2, -2, 1, -3];
	var accord = [0, 0, 0, 1, 1, 1, -1, -1, -1];
	var base = [0, 2, 4];
	var pos = 0;
	loop {
		var t = zigzag[val] * -1;
		base = base + accord.rotate(t)[..2].rotate(pos);
		pos = pos + t;
		val = base.yield;
	}
};
var c = r{ |val|
	var base = [0, 2, 4];
	loop{
		var tmp = switch(val,
			0, [0, 0, 0],
			1, [1, 1, 1], 2, [-1, 0, 0], 3, [0, 1, 1],
			6, [-1, -1, -1], 5, [0, 0, 1], 4, [1, 1, 0],
		);
		val = (base + tmp).yield;
	}
};
var mel = [0, 1, 3, 2] + 4;
var appos = [0, 0, 1, 0, -1, 0, 0, 0];
var chords = [0, 3, 1, -1].collect{arg i; i ! 8}.flatten;

SynthDef(\a, {|freq = 440, amp = 1|
	var sig;
	sig = [LFCub.ar(freq), LFTri.ar(freq - 0)]
	* EnvGen.kr(Env([0, 1, 0.1, 0], [0.1, 0.2, 1]), doneAction: 2);
	Out.ar([0, 1], sig * amp / 8);
}).add;

Event.addEventType(\bob, { |s|
	~scale = c.next(~chords %7).collect(_.degreeToKey(~scale));
//	~degree = [-3, -2, 1] ++ ~degree;
	// ~amp = 0.002 ! ~degree.size;
	~type = \note;
	currentEnvironment.play;
});
Event.addParentType(\bob, (
	\type, \bob,
	\instrument, \a,
	\chords, chords.iter.repeat,
	\scale, Scale.major,
	\amp, 0.122468,
	\tempo, 4
));

Pdef(\io,
	Ppar([
		Pbind(
			\type, \bob,
			\degree, Pseq([[0, 1, 2], \r], inf),
		),
		Pbind(
			\type, \bob,
			\degree, mel.iter.repeat,
			\mtranspose, Prand([0, 1, -1], inf),
		)
	])
);
Pdef(\io).play;
)