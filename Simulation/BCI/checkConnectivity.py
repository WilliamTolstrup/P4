from robolink import *  # API to communicate with RoboDK
from robodk import *  # basic matrix operations

RDK = Robolink()

# Arrow keys program example

# get a robot
robot = RDK.Item('Kinova Gen3 6DOF NoV', ITEM_TYPE_ROBOT)
if not robot.Valid():
    print("No robot in the station. Load a robot first, then run this program.")
    pause(5)
    raise Exception("No robot in the station!")

print(robot.Joints())
