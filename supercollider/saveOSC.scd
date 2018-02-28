(
OSCdef(\io, { arg msg;
	a.postln;
	a[0] = a[0].add(msg[1]);
	a[1] = a[1].add(msg[2]);
	a[2] = a[2].add(msg[3]);
	a[3] = a[3].add(msg[4]);
}, "/wii/1/accel/pry");
)

(
a = [[], [], [], []];
{
	var now = thisThread.beats;
	OSCdef(\io).enable;
	while {thisThread.beats - now < 10}
	{
		"recording".postln;
		(1 / 60).wait;
	};
	OSCdef(\io).disable;
	"finish".postln;
	Archive.global.put(\OSC, a)
}.fork;
)


a.plot
89.rand.hash