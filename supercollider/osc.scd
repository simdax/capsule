(
var oscs=
[
	"/wii/1/button/1" -> {},
	"/wii/1/button/2" -> {},
	"/wii/1/button/A" -> {~applause.play},
	"/wii/1/button/B" -> {},
	"/wii/1/button/Minus" -> {},
	"/wii/1/button/Plus" -> {},
	"/wii/1/accel/pry" -> { |msg, time, replyAddr, recvPort|
		var value = msg[0];
		value.postln;
		Ndef(\effects).set(\freq, value);
		// Ndef(\player).set(\rate, value.round(0.5));
	},
	"/roll" -> {},
	"/yaw" -> {},
	"/pitch" -> {},
	"/accel" -> {}
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
