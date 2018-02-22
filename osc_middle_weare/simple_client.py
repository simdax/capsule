"""Small example OSC client

This program sends 10 random values between 0.0 and 1.0 to the /filter address,
waiting for 1 seconds between each value.
"""
import argparse
import random
import time
import os
import time

from pythonosc import osc_message_builder
from pythonosc import udp_client
#from pythonosc import osc_role


def get_save_path(): 
  count = 0
  for dirname, dirnames, filenames in os.walk('./isadora_wii/'):
      for filename in filenames:
          count += 1
  path = "./isadora_wii/rec" + str(count + 1)
  return (path);
  

def send_to_client(arg_name, arg_value, f_rec):
  parser = argparse.ArgumentParser()
  parser.add_argument("--ip", default="127.0.0.1",
  help="The ip of the OSC server")
  parser.add_argument("--port", type=int, default=4242,
  help="The port the OSC server is listening on")
  args = parser.parse_args()
#  osc_role.set_client()
  
#  print("yolo------->>>> i am only here\n")
  
  client = udp_client.SimpleUDPClient(args.ip, args.port)
  
  client.send_message(arg_name , arg_value)

  t = time.time()
  to_save = str(t) + " : " + arg_name + " : " + str(arg_value) + "\n"
  print(to_save)
  f_rec.write(to_save);


if __name__ == "__main__":
  os.system("mkdir -p isadora_wii")
  path = get_save_path()
  print("the path:", path)
  f = open(path, 'w')
  a = 0
  for a in range(2000):
    send_to_client("/acc", random.random(), f)
    time.sleep(0.5)
    send_to_client("/wiimote", 2.42, f)
    time.sleep(0.5)
    send_to_client("/NO_NAME", random.random(), f)
    time.sleep(0.5)
  f.close

