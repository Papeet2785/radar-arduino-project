# Arduino Radar

A simple Arduino radar project built using an **Arduino Uno**, an **HC-SR04 ultrasonic sensor**, and an **SG90 servo motor**. The Arduino continuously sweeps the ultrasonic sensor across an angle range while sending angle and distance data over the serial port. A **Processing** application visualizes the data as a real-time radar display.

This project was created while learning Arduino and Processing, following the excellent tutorial by **TimeForDillon**.

---

## Features

- 📡 Real-time obstacle detection
- 🔄 Servo-based 180° radar sweep
- 📏 Distance measurement using the HC-SR04 ultrasonic sensor
- 🖥️ Live radar visualization using Processing
- 🔌 Serial communication between Arduino and Processing

---

## Hardware

- Arduino Uno
- HC-SR04 Ultrasonic Sensor
- SG90 Servo Motor
- Breadboard
- Jumper wires

---

## Software

- Arduino IDE
- Processing 4
- Processing Serial library

---

## Project Structure

```
Arduino-Radar/
├── Arduino/
│   └── Arduino_Radar.ino
├── Processing/
│   └── Radar_Display.pde
└── README.md
```

---

## How it Works

1. The servo rotates the ultrasonic sensor from one side to the other.
2. At each angle, the HC-SR04 measures the distance to the nearest object.
3. The Arduino sends data over Serial in the format:

```
angle,distance.
```

Example:

```
90,17.
```

4. The Processing application reads this serial data and renders a radar-style visualization.

---

## Running the Project

### Arduino

1. Open the Arduino sketch.
2. Select your Arduino Uno.
3. Upload the sketch.
4. Close the Serial Monitor (Processing needs exclusive access to the serial port).

### Processing

1. Open the Processing sketch.
2. Update the serial port if necessary.

Example (Linux):

```java
new Serial(this, "/dev/ttyACM0", 9600);
```

Example (Windows):

```java
new Serial(this, "COM3", 9600);
```

3. Run the sketch.

---

## Linux Notes

On Linux, make sure your user has permission to access the serial port.

For example:

```bash
sudo usermod -aG dialout $USER
```

Then log out and back in.

If you're using NixOS or another Wayland-based system, Processing may render menus incorrectly. Launching it with X11 compatibility fixes the issue:

```bash
_JAVA_AWT_WM_NONREPARENTING=1 GDK_BACKEND=x11 Processing
```

---

## Demo

The radar display updates in real time, showing:

- Green scanning beam
- Red detected objects
- Continuous servo sweep

---

## Credits

Tutorial by **TimeForDillon**.

This repository contains my implementation created while learning Arduino, Processing, serial communication, and basic sensor integration.
