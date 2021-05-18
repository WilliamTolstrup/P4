import tkinter as tk
from pyautogui import press
import pyautogui
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

# define the move increment
move_speed = 10

from msvcrt import getch

move_direction = [0, 0, 0]

height = 1080
width = 1920

labels = []
key = ''

root = tk.Tk()
root.title('BCI')
root.geometry('1920x1080')
root.attributes('-fullscreen', True)

canvas = tk.Canvas(root, height=height, width=width)
canvas.pack()
frame = tk.Frame(root, bg='black')
frame.place(relwidth=1, relheight=1)
keyPressed = 0

root.bind('<Escape>', lambda e: root.destroy())

while True:
    mousePos = (pyautogui.position())

    if (286 - 236) < mousePos[0] < (286 + 236) and (150 - 100) < mousePos[1] < (150 + 100):
        label = tk.Label(frame, text='X+', bg='red', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=286, y=150, width=472, height=200)
        labels.append(label)
        if (keyPressed == 0):
            # press('down')
            # key = 'X+'
            move_direction = [1, 0, 0]
            keyPressed = 1
    else:
        label = tk.Label(frame, text='X+', bg='white', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=286, y=150, width=472, height=200)
        labels.append(label)
        keyPressed = 0

    if (960 - 236) < mousePos[0] < (960 + 236) and (150 - 100) < mousePos[1] < (150 + 100):
        label = tk.Label(frame, text='Y+', bg='red', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=960, y=150, width=472, height=200)
        labels.append(label)
        if (keyPressed == 0):
            # press('right')
            # key = 'Y+'
            move_direction = [0, 1, 0]
            keyPressed = 1
    else:
        label = tk.Label(frame, text='Y+', bg='white', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=960, y=150, width=472, height=200)
        labels.append(label)
        keyPressed = 0

    if (1634 - 236) < mousePos[0] < (1634 + 236) and (150 - 100) < mousePos[1] < (150 + 100):
        label = tk.Label(frame, text='Z+', bg='red', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=1634, y=150, width=472, height=200)
        labels.append(label)
        if (keyPressed == 0):
            # press('q')
            # key = 'Z+'
            move_direction = [0, 0, 1]
            keyPressed = 1
    else:
        label = tk.Label(frame, text='Z+', bg='white', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=1634, y=150, width=472, height=200)
        labels.append(label)
        keyPressed = 0

    if (578 - 236) < mousePos[0] < (578 + 236) and (540 - 100) < mousePos[1] < (540 + 100):
        label = tk.Label(frame, text='Grip', bg='red', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=578, y=540, width=472, height=200)
        labels.append(label)
        if (keyPressed == 0):
            # press('G')
            # key = 'Gripper'
            keyPressed = 1
    else:
        label = tk.Label(frame, text='Grip', bg='white', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=578, y=540, width=472, height=200)
        labels.append(label)
        keyPressed = 0

    if (1342 - 236) < mousePos[0] < (1342 + 236) and (540 - 100) < mousePos[1] < (540 + 100):
        label = tk.Label(frame, text='E-Stop', bg='red', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=1342, y=540, width=472, height=200)
        labels.append(label)
        if (keyPressed == 0):
            # press('E')
            # key = 'E-Stop'
            keyPressed = 1
    else:
        label = tk.Label(frame, text='E-Stop', bg='white', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=1342, y=540, width=472, height=200)
        labels.append(label)
        keyPressed = 0

    if (268 - 236) < mousePos[0] < (286 + 236) and (930 - 100) < mousePos[1] < (930 + 100):
        label = tk.Label(frame, text='X-', bg='red', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=286, y=930, width=472, height=200)
        labels.append(label)
        if (keyPressed == 0):
            # press('up')
            # key = 'X-'
            move_direction = [-1, 0, 0]
            keyPressed = 1
    else:
        label = tk.Label(frame, text='X-', bg='white', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=286, y=930, width=472, height=200)
        labels.append(label)
        keyPressed = 0

    if (960 - 236) < mousePos[0] < (960 + 236) and (930 - 100) < mousePos[1] < (930 + 100):
        label = tk.Label(frame, text='Y-', bg='red', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=960, y=930, width=472, height=200)
        labels.append(label)
        if (keyPressed == 0):
            # press('left')
            # key = 'Y-'
            move_direction = [0, -1, 0]
            keyPressed = 1
    else:
        label = tk.Label(frame, text='Y-', bg='white', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=960, y=930, width=472, height=200)
        labels.append(label)
        keyPressed = 0

    if (1634 - 236) < mousePos[0] < (1634 + 236) and (930 - 100) < mousePos[1] < (930 + 100):
        label = tk.Label(frame, text='Z-', bg='red', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=1634, y=930, width=472, height=200)
        labels.append(label)
        if (keyPressed == 0):
            # press('a')
            key = 'Z-'
            move_direction = [0, 0, -1]
            keyPressed = 1
    else:
        label = tk.Label(frame, text='Z-', bg='white', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=1634, y=930, width=472, height=200)
        labels.append(label)
        keyPressed = 0

    label = tk.Label(frame, text=key, bg='black', fg='white', font=("Arial", 50, "bold"), bd=0)
    label.place(anchor='c', x=1920 / 2, y=1080 / 2 - 200)
    labels.append(label)

    root.update()

    for label in labels:
        label.destroy()

        # make sure that a movement direction is specified
    if norm(move_direction) <= 0:
        continue

    # calculate the movement in mm according to the movement speed
    xyz_move = mult3(move_direction, move_speed)

    # get the robot joints
    robot_joints = robot.Joints()

    # get the robot position from the joints (calculate forward kinematics)
    robot_position = robot.SolveFK(robot_joints)

    # get the robot configuration (robot joint state)
    robot_config = robot.JointsConfig(robot_joints)

    # calculate the new robot position
    new_robot_position = transl(xyz_move) * robot_position

    # calculate the new robot joints
    new_robot_joints = robot.SolveIK(new_robot_position)

    # move the robot joints to the new position
    robot.MoveJ(new_robot_joints)

    move_direction = [0, 0, 0]
    # robot.MoveL(new_robot_joints)
