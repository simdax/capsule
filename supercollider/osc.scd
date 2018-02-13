(
var oscs=
[
	"/accelerometer/raw/x",
	"/accelerometer/raw/y",
	"/accelerometer/raw/z",
	"/accelerometer/linear/x",
	"/accelerometer/linear/y",
	"/accelerometer/linear/z",
	"/accelerometer/gravity/x",
	"/accelerometer/gravity/y",
	"/accelerometer/gravity/z",
	"/rotation_vector/r1",
	"/rotation_vector/r2",
	"/rotation_vector/r3",
	"/rotation_vector/r4",
	"/orientation/azimuth",
	"/orientation/pitch",
	"/orientation/roll",
	"/light",
	"/gps/longitude",
	"/gps/latitude",
	"/gps/speed",
	"/gps/accuracy",
	"/proximity"
];
var glob = 0;
var freq = 440;
var f = { |msg, time, replyAddr, recvPort|
	var value = (msg[1].asFloat.abs);
	Ndef(\effects).set(\freq, value);
};
var list_f = { |list|
	var word = list.items[list.value];
		if (list.selection.includes(list.value),
		{OSCdef(word.asSymbol).enable},
		{OSCdef(word.asSymbol).disable}
	)
};
Window.closeAll;
OSCdef.freeAll;
oscs.do { |name|
	OSCdef(name.asSymbol, f, name.asSymbol).disable
};
w = Window().front;
l = ListView(w, 200@300)
.selectionMode_(\multi)
.selection_([])
.items_(oscs)
.selectionAction_(list_f);
)
