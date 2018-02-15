(
var oscs=
[
	"/wii/1/button/1" -> {},
	"/wii/1/button/2" -> {},
	"/wii/1/button/A" -> {~applause.play},
	"/wii/1/button/B" -> {},
	"/wii/1/button/Minus" -> {},
	"/wii/1/button/Plus" -> {},
	"/wii/1/accel/pry/0" -> { |msg, time, replyAddr, recvPort|
		var value = msg[1];
		value.postln;
		Ndef(\waves).set(\freq, value);
		// Ndef(\player).set(\rate, value.round(0.5));
	},
	"/wii/1/accel/pry/1" -> { |msg, time, replyAddr, recvPort|
		var value = msg[1];
		value.postln;
		Ndef(\waves).set(\freq, value);
		// Ndef(\player).set(\rate, value.round(0.5));
	},
	"/wii/1/accel/pry/2" -> { |msg, time, replyAddr, recvPort|
		var value = msg[1];
		value.postln;
		Ndef(\ocean).set(\rate, value * 5);
		// Ndef(\player).set(\rate, value.round(0.5));
	},
	"/wii/1/accel/pry/3" -> { |msg, time, replyAddr, recvPort|
		var value = msg[1];
		value.postln;
		Ndef(\waves).set(\freq, value);
		// Ndef(\player).set(\rate, value.round(0.5));
	},
].asDict;

~list_f = { |list|
	var word = list.items[list.value];
		if (list.selection.includes(list.value),
		{OSCdef(word.asSymbol).enable},
		{OSCdef(word.asSymbol).disable}
	)
};
Window.closeAll;
OSCdef.freeAll;
oscs.keysValuesDo { |key, val|
	val.postln;
	OSCdef(key.asSymbol, val, key.asSymbol).disable
};
w = Window().front;
l = ListView(w, 200@300)
.selectionMode_(\multi)
.selection_([])
.items_(oscs.keys.asArray)
.selectionAction_(~list_f);
)
