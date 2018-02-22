"""Class that maps OSC addresses to handlers."""
import collections
import logging
import re
import os
import time


from pythonosc import udp_client

Handler = collections.namedtuple(
    typename='Handler',
    field_names=('callback', 'args'))

def send_to_client(arg_name, arg_value):
#  parser = argparse.ArgumentParser()
#  parser.add_argument("--ip", default="127.0.0.1",
#  help="The ip of the OSC server")
#  parser.add_argument("--port", type=int, default=57120,
#  help="The port the OSC server is listening on")
#  args = parser.parse_args()
  
  print("arg:", arg_name, "value:", arg_value)
  client = udp_client.SimpleUDPClient("127.0.0.1", 57120)
  client.send_message(arg_name , arg_value)

####################################################



def yolo_swag(arg_name, arg_value):
#  print ("===========================================> OK it's working    a:", arg_name, "  b:", arg_value)
  f = open("isadora_wii/tmp", 'a')
  to_save = str(time.time()) + " : " + arg_name + " : " + str(arg_value) + "\n"
  f.write(to_save)
  print(to_save)
  send_to_client(arg_name, arg_value)
#  help(self)
#  print ("self.func:", self._print_file)



class Dispatcher(object):
  """Register addresses to handlers and can match vice-versa."""

  def __init__(self):
    self._map = collections.defaultdict(list)
    self._default_handler = yolo_swag

#    os.system("mkdir -p isadora_wii")
#    path = get_save_path()
#    print("the path:", path)
#    f = open(path, 'w')
#
#
#    self._print_file = f

  def map(self, address, handler, *args):
    """Map a given address to a handler.

    Args:
      - address: An explicit endpoint.
      - handler: A function that will be run when the address matches with
                 the OscMessage passed as parameter.
      - args: Any additional arguments that will be always passed to the
              handlers after the osc messages arguments if any.
    """
    # TODO: Check the spec:
    # http://opensoundcontrol.org/spec-1_0
    # regarding multiple mappings
    self._map[address].append(Handler(handler, list(args)))
#    print("=========4444========", "address:", address, "args", args)
#   

  def handlers_for_address(self, address_pattern):
   # print("toi\n")
    """yields Handler namedtuples matching the given OSC pattern."""
    # First convert the address_pattern into a matchable regexp.
    # '?' in the OSC Address Pattern matches any single character.
    # Let's consider numbers and _ "characters" too here, it's not said
    # explicitly in the specification but it sounds good.
    escaped_address_pattern = re.escape(address_pattern)
    pattern = escaped_address_pattern.replace('\\?', '\\w?')


 #   print(">>>>>>", escaped_address_pattern, "<<<<\n")
 #   print("######", pattern, "#####\n")
    # '*' in the OSC Address Pattern matches any sequence of zero or more
    # characters.
    pattern = pattern.replace('\\*', '[\w|\+]*')
 #   print("######", pattern, "#####\n")
    # The rest of the syntax in the specification is like the re module so
    # we're fine.
    pattern = pattern + '$'
 #   print("######", pattern, "#####\n")
    pattern = re.compile(pattern)
 #   print("######", pattern, "#####\n")
    matched = False

 #   print(self._map.items())

    for addr, handlers in self._map.items():
   #   print("addr:", addr)
   #   print("handlers:", handlers)
   #   print("item:", self.map.items)
      if (pattern.match(addr)
        or (('*' in addr) and re.match(addr.replace('*','[^/]*?/*'), address_pattern))):
        yield from handlers
        matched = True

    if not matched and self._default_handler:
      logging.debug('No handler matched but default handler present, added it.')
      yield Handler(self._default_handler, [])
    matched = False

def wiimote_handler(a, b, c):
  print("le caca c'est VRAIMENT delicieux\n")
  print("a:", a, "b:", b, "c:", c)

  def set_default_handler(self, handler):
    """Sets the default handler.

    Must be a function with the same constaints as with the self.map method
    or None to unset the default handler.
    """
#    print("yoooo\n");
    self._default_handler = _default_handler
