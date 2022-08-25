'======================================================================='

' Title: 2-Digit 7Segment LED Voltmeter 0-5
' Last Updated :  03.2022
' Author : A.Hossein.Khalilian
' Program code  : BASCOM-AVR 2.0.8.5
' Hardware req. : ATmega8 + 2-Digit 7Segment

'======================================================================='
$regfile = "m8def.dat"
$crystal = 8000000

Disable Interrupts

Config Portd = Output
Config Pinb.0 = Output
Config Pinc.0 = Output
Config Pinc.1 = Output

Catode1 Alias Portc.0
Catode2 Alias Portc.1
Anod Alias Portd
Led Alias Portb.0

Config Adc = Single , Prescaler = Auto , Reference = Avcc

Enable Interrupts
Enable Adc


Dim A As Byte
Dim C As Byte
Dim D As Byte

Dim A2d As Word
Dim Volt_s As Single
Dim Volt_w As Word

Led = 1
Wait 1
Led = 0
Wait 1

'-----------------------------------------------------------
Main:
Toggle Led

Start Adc
A2d = Getadc(5)
Stop Adc

Volt_s = A2d * 4.9
Volt_s = Volt_s / 1000
Volt_s = Volt_s * 10
Volt_w = Volt_s

A = Volt_w / 10
Gosub Show_segment_1

C = A * 10
D = Volt_w - C
A = D
Gosub Show_segment_2

Goto Main

'-----------------------------------------------------------

Show_segment_1:

Catode1 = 0                                           'on
Catode2 = 1                                           'off
Anod = Lookup(a , Data_code)
Waitms 10

Return

''''''''''''''''''''''''''''''

Show_segment_2:

Catode1 = 1                                           'off
Catode2 = 0                                           'on
Anod = Lookup(a , Data_code)
Waitms 10

Return


''''''''''''''''''''''''''''''

Data_code:
Data &B10111111                                             '0
Data &B10000110                                             '1
Data &B11011011                                             '2
Data &B11001111                                             '3
Data &B11100110                                             '4
Data &B11101101                                             '5
Data &B11111101                                             '6
Data &B10000111                                             '7
Data &B11111111                                             '8
Data &B11101111                                             '9

Return

'-----------------------------------------------------------
