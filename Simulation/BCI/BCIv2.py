import tkinter as tk
from pyautogui import press
import pyautogui
import time

height = 1080
width = 1920

labels = []
key = ''

box1Pressed = 0

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

X = 0
Y = 0
Z = 0
A = 0
B = 0
C = 0

gripper = 'closed'

pyautogui.moveTo(1920/2, 100)

def reset():
    global box1
    global box2
    global box3
    global box4
    global box5

    box1 = 'XYZ+'
    box2 = 'XYZ-'
    box3 = 'Home'
    box4 = 'ABC+'
    box5 = 'ABC-'

reset()

while True:
    mousePos = (pyautogui.position())

    if (286 - 236) < mousePos[0] < (286 + 236) and (150 - 100) < mousePos[1] < (150 + 100):
        label = tk.Label(frame, text=box1, bg='red', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=286, y=150, width=472, height=200)
        labels.append(label)
        box1Pressed = 1
        if box1 == 'XYZ+':
            box1 = 'X + 1'
            box2 = 'Y + 1'
            box3 = 'Grip'
            box4 = 'Z + 1'
            box5 = 'Back'
        elif box1 == 'X + 1':
            X = X + 1
        elif box1 == 'X - 1':
            X = X - 1
        elif box1 == 'A + 1':
            A = A + 1
        elif box1 == 'A - 1':
            A = A - 1
        root.update()
        time.sleep(0.1)
        pyautogui.moveTo(1920/2, 100)
    else:
        label = tk.Label(frame, text=box1, bg='white', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=286, y=150, width=472, height=200)
        labels.append(label)
        box1Pressed = 0


    if (1634 - 236) < mousePos[0] < (1634 + 236) and (150 - 100) < mousePos[1] < (150 + 100):
        label = tk.Label(frame, text=box2, bg='red', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=1634, y=150, width=472, height=200)
        labels.append(label)
        if box2 == 'XYZ-':
            box1 = 'X - 1'
            box2 = 'Y - 1'
            box3 = 'Grip'
            box4 = 'Z - 1'
            box5 = 'Back'
        elif box2 == 'Y + 1':
            Y = Y + 1
        elif box2 == 'Y - 1':
            Y = Y - 1
        elif box2 == 'B + 1':
            B = B + 1
        elif box2 == 'B - 1':
            B = B - 1
        root.update()
        time.sleep(0.1)
        pyautogui.moveTo(1920/2, 100)
    else:
        label = tk.Label(frame, text=box2, bg='white', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=1634, y=150, width=472, height=200)
        labels.append(label)
        keyPressed = 0

    if (960 - 236) < mousePos[0] < (960 + 236) and (540 - 100) < mousePos[1] < (540 + 100):
        label = tk.Label(frame, text=box3, bg='red', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=960, y=540, width=472, height=200)
        labels.append(label)
        if box3 == 'Grip':
            if gripper == 'closed':
                gripper = 'open'
            elif gripper == 'open':
                gripper = 'closed'
        elif box3 == 'Home':
            X = 0
            Y = 0
            Z = 0
            A = 0
            B = 0
            C = 0


        root.update()
        time.sleep(0.1)
        pyautogui.moveTo(1920 / 2, 100)

    else:
        label = tk.Label(frame, text=box3, bg='white', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=960, y=540, width=472, height=200)
        labels.append(label)
        keyPressed = 0


    if (268 - 236) < mousePos[0] < (286 + 236) and (930 - 100) < mousePos[1] < (930 + 100):
        label = tk.Label(frame, text=box4, bg='red', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=286, y=930, width=472, height=200)
        labels.append(label)
        if box4 == 'ABC+':
            box1 = 'A + 1'
            box2 = 'B + 1'
            box3 = 'Grip'
            box4 = 'C + 1'
            box5 = 'Back'
        elif box4 == 'Z + 1':
            Z = Z + 1
        elif box4 == 'Z - 1':
            Z = Z - 1
        elif box4 == 'C + 1':
            C = C + 1
        elif box4 == 'C - 1':
            C = C - 1
        root.update()
        time.sleep(0.1)
        pyautogui.moveTo(1920 / 2, 100)
    else:
        label = tk.Label(frame, text=box4, bg='white', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=286, y=930, width=472, height=200)
        labels.append(label)
        keyPressed = 0


    if (1634 - 236) < mousePos[0] < (1634 + 236) and (930 - 100) < mousePos[1] < (930 + 100):
        label = tk.Label(frame, text=box5, bg='red', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=1634, y=930, width=472, height=200)
        labels.append(label)

        if box5 == 'ABC-':
            box1 = 'A - 1'
            box2 = 'B - 1'
            box3 = 'Grip'
            box4 = 'C - 1'
            box5 = 'Back'
        elif box5 == 'Back':
            reset()
        root.update()
        time.sleep(0.1)
        pyautogui.moveTo(1920 / 2, 100)
    else:
        label = tk.Label(frame, text=box5, bg='white', fg='black', font=("Arial", 50, "bold"), bd=0)
        label.place(anchor='c', x=1634, y=930, width=472, height=200)
        labels.append(label)
        keyPressed = 0

    position = 'X:' + str(X) + '  Y:' + str(Y) + '  Z:' + str(Z) + '  A:' + str(A) + '  B:' + str(B) + '  C:' + str(C)

    label = tk.Label(frame, text=position, bg='black', fg='white', font=("Arial", 20, "bold"), bd=0)
    label.place(anchor='c', x=1920 / 2, y=1080 / 2 - 200)
    labels.append(label)

    label = tk.Label(frame, text=('Gripper is: ' + gripper), bg='black', fg='white', font=("Arial", 20, "bold"), bd=0)
    label.place(anchor='c', x=1920 / 2, y=1080 / 2 - 150)
    labels.append(label)

    root.update()

    for label in labels:
        label.destroy()
