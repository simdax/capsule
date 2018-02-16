(
var f = { |msg, time, replyAddr, recvPort|
	var value = msg[1];
	value.postln;
	Ndef(~current).set(\freq, value);
	// Ndef(\player).set(\rate, value.round(0.5));
};
var oscs=
[
	"/wii/1/button/1" -> {},
	"/wii/1/button/2" -> {},
	"/wii/1/button/A" -> {},
	"/wii/1/button/B" -> {},
	"/wii/1/button/Minus" -> {},
	"/wii/1/button/Plus" -> {},
	"/wii/1/accel/pry/0" -> f,
	"/wii/1/accel/pry/1" -> f,
	"/wii/1/accel/pry/2" -> f,
	"/wii/1/accel/pry/3" -> f,
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
