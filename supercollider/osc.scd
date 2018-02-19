(
var f = { |msg, time, replyAddr, recvPort|
	var value = msg[1];
	value.postln;
	// Ndef(~current).set(\freq, value);
	// Ndef(\player).set(\rate, value.round(0.5));
};
var oscs1 =
[
	"/wii/1/button/1" -> f,
	"/wii/1/button/2" -> f,
	"/wii/1/button/A" -> f,
	"/wii/1/button/B" -> f,
	"/wii/1/button/Minus" -> f,
	"/wii/1/button/Plus" -> f,
	"/wii/1/accel/pry/0" -> f,
	"/wii/1/accel/pry/1" -> f,
	"/wii/1/accel/pry/2" -> f,
	"/wii/1/accel/pry/3" -> f
].asDict;
var oscs2 =
[
	"/wii/2/button/1" -> f,
	"/wii/2/button/2" -> f,
	"/wii/2/button/A" -> f,
	"/wii/2/button/B" -> f,
	"/wii/2/button/Minus" -> f,
	"/wii/2/button/Plus" -> f,
	"/wii/2/accel/pry/0" -> f,
	"/wii/2/accel/pry/1" -> f,
	"/wii/2/accel/pry/2" -> f,
	"/wii/2/accel/pry/3" -> f,
].asDict;

var list_f = { |list|
	var word = list.items[list.value];
		if (list.selection.includes(list.value),
		{OSCdef(word.asSymbol).enable},
		{OSCdef(word.asSymbol).disable}
	)
};
Window.closeAll;
OSCdef.freeAll;
(oscs1 ++ oscs2).keysValuesDo { |key, val|
	OSCdef(key.asSymbol, val, key.asSymbol).disable
};
w = FlowView(nil, 500@300).front;
ListView(w, 200@300)
.selectionMode_(\multi)
.selection_([])
.items_(oscs1.keys.asArray)
.selectionAction_(list_f);
ListView(w, 200@300)
.selectionMode_(\multi)
.selection_([])
.items_(oscs2.keys.asArray)
.selectionAction_(list_f);
)
