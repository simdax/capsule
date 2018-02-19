{arg ndef;
	// Ndef(ndef)[1] = \filter -> {arg in;
	// 	//..LPF.ar(in, 0)
	// 	in
	// };
	Ndef(ndef)[1] = \filter -> {arg in, reverb_damp = 0.33, reverb_room = 0.33;
		FreeVerb.ar(in, 0.2, reverb_room, reverb_damp)
	}
}
