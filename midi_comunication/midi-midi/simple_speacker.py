import rtmidi_python as rtmidi

midi_out = rtmidi.MidiOut()
midi_out.open_port(0)

midi_out.send_message([0x90, 48, 100]) # Note on
midi_out.send_message([0x80, 48, 100]) # Note off
