# CAPSULE 2 => Supercollider module

Every file can be open with the Supercollider IDE, or executing 
/Application/PathOfSupercollider.app/MacOS/sclang

Supercollider allows easy music creation, defining simple Ugens
(simple one like Oscillator or more complicated like reverb effects,
or everything you want) in a function that you can plug together

A quick example in pseudo code

```
play { 
       var sig = Osc.ar(440);
       var out = Reverb.ar(sig, args for a reverb ....);
       Out.ar(0);
}

```
or dynamically

```
~sound = { Osc.ar(440) };
~sound[1] = {arg in; Reverb.ar(in)};
Button.action_{~sound.play;}
Button.action_{~sound.stop;}
Button.action_{~sound[1] = {another effect... };}
etc.
```

## supercollider

This module is intended to provide a Ableton-like (more) configurable
protype to link audio tracks with SuperCollider (SC) effects moving a
wiimote

1. Plug a wiimote with OSCulator (or similar softs) in port
localhost:75120 (can change, check `NetAddr.langPort` in SC)
1. open tests.scd, eval code in parenthesis
1. change values in last parenthesis and have fun

## config

config is intended to download wav files on youtube, which cannot
be put on github (too heavy)

## SaveOSC

SaveOsc allows one to record his moves wit a wiimote. It's a early
version of a more mature script with visualisation (forgotten in
Kantum mac...). For now, just eval the a.plot line for a visualisation.