"""Small example OSC server

This program listens to several addresses, and prints some information about
received packets.
"""
import argparse
import math
import os

#from pythonosc import osc_role
from pythonosc import dispatcher
from pythonosc import osc_server
from pprint import pprint

def print_volume_handler(unused_addr, args, volume):
  print("[{0}] ~ {1}".format(args[0], volume))

def print_compute_handler(unused_addr, args, volume):
  try:
    print("[{0}] ~ {1}".format(args[0], args[1](volume)))
  except ValueError: pass


####################################################
def get_save_path(): 
  count = 0
  for dirname, dirnames, filenames in os.walk('./isadora_wii/'):
      for filename in filenames:
          count += 1
  path = "./isadora_wii/rec" + str(count + 1)
  return (path);
####################################################
  

####################################################
def send_to_client(arg_name, arg_value, f_rec):
  parser = argparse.ArgumentParser()
  parser.add_argument("--ip", default="127.0.0.1",
  help="The ip of the OSC server")
  parser.add_argument("--port", type=int, default=4242,
  help="The port the OSC server is listening on")
  args = parser.parse_args()
  osc_role.set_client()
  
#  print("yolo------->>>> i am only here\n")
  
  client = udp_client.SimpleUDPClient(args.ip, args.port)
  
  client.send_message(arg_name , arg_value)

  t = time.time()
  to_save = str(t) + " : " + arg_name + " : " + str(arg_value) + "\n"
#  print(to_save)
  f_rec.write(to_save);
####################################################




def wiimote_handler(a, b, c):
  print("le caca c'est delicieur\n")
  print("a:", a, "b:", b, "c:", c)

if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  parser.add_argument("--ip",
      default="127.0.0.1", help="The ip to listen on")
  parser.add_argument("--port",
      type=int, default=4242, help="The port to listen on")

  args = parser.parse_args()
#  print("args:", args)
#  osc_role.set_serveur()

  os.system("mkdir -p isadora_wii")
  path = get_save_path()
#  print("__type__:", type(int(os.system("mv isadora_wii/tmp " + path))))
  if (os.system("mv isadora_wii/tmp " + path) != 1):
    os.system("touch isadora_wii/tmp")
  

  dispatcher = dispatcher.Dispatcher()


#  dispatcher.map("/acc", print)
#  dispatcher.map("/volume", print_volume_handler, "Volume")
#  dispatcher.map("/logvolume", print_compute_handler, "Log volume", math.log)
#  dispatcher.map("/wiimote", wiimote_handler, "Wiimote")
  
  
  server = osc_server.ThreadingOSCUDPServer(
  (args.ip, args.port), dispatcher)
  print("Serving on {}".format(server.server_address))
  server.serve_forever()
