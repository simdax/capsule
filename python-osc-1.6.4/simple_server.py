"""Small example OSC server

This program listens to several addresses, and prints some information about
received packets.
"""
import argparse
import math
import os

from pythonosc import dispatcher
from pythonosc import osc_server
from pprint import pprint

def print_volume_handler(unused_addr, args, volume):
  print("[{0}] ~ {1}".format(args[0], volume))

def print_compute_handler(unused_addr, args, volume):
  try:
    print("[{0}] ~ {1}".format(args[0], args[1](volume)))
  except ValueError: pass

def toto():
  print("je suis un lapin")

if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("--ip",
      default="127.0.0.1", help="The ip to listen on")
  parser.add_argument("--port",
      type=int, default=4242, help="The port to listen on")
  args = parser.parse_args()

  dispatcher = dispatcher.Dispatcher()
  pprint(dispatcher)
  print(callable(dispatcher))
  print(ascii(dispatcher))
  print(repr(dispatcher))
  # help(dispatcher)
  print(dispatcher.__dict__)
  print("---------------\n")

  print(dispatcher.__dict__)
  dispatcher.map("/acc", print)
  dispatcher.map("/acc2", print)
  dispatcher.map("/volume", print_volume_handler, "Volume")
  dispatcher.map("/logvolume", print_compute_handler, "Log volume", math.log)
  
  
  server = osc_server.ThreadingOSCUDPServer(
  (args.ip, args.port), dispatcher)
  print("Serving on {}".format(server.server_address))
  server.serve_forever()
