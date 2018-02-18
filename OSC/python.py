#!/usr/bin/env python

import liblo
port = 12345
target = liblo.Address(port)

# send message "/foo/message1" with int, float and string arguments
liblo.send(target, "/Carla/0/set_volume", 0.2)


