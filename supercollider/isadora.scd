(
// load file, infos
var files = "db.yaml".resolveRelative.parseYAMLFile;
// put sound files in playable tracks callback
var action = {arg name, options;
    {arg b;
        "ready for : %\n".postf(name);
        ~buffers = ~buffers.add(b);
        Ndef(name.asSymbol, { | rate = 1, t_trig = 1, gain = 1|
            PlayBuf.ar(2, b,
				rate,
				// BufSampleRate.ir(b),
				// LinLin.kr(rate, 0, 1, 0.8, 1.1),
                t_trig,
                doneAction: Done.freeSelf) * gain
        });
    }
};
// load sound files in memory
// here global (for reload no leak managment --- tldr)
~files = files;
// s.quit;
s.waitForBoot({
    Ndef.clear;
    // here are range inputs
    ~buffers.do(_.free);
    ~buffers = [];
    // load audio files
    files.keysValuesDo{ |key, options|
        var name = key;
        Buffer.read(s, ("music/" ++ name ++ ".wav").resolveRelative,
            (options["from"].postln ? 0).asFloat * 44100,
            options['to'],
            action.value(name, options)
        );
    };
    // add effects to tracks
    "effects.scd".resolveRelative.load; //effect loader
    "specs.scd".resolveRelative.load; //specs (inputs range) loader
    // gui
    NdefMixer(s);
});
)
