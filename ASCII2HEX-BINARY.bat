@echo off
color 0a
REM ASCII Converter v1.0 by Stephan van de Kerkhof
REM ----------------------------------------------
REM Easy script to convert ASCII values to HEX or BINARY

REM Here we tell the script which conversion to perform, ASCII2HEX or ASCII2BINARY
set /p CONVERSIONTYPE="ASCII2BINARY or ASCII2HEX (1/2) "
If [%CONVERSIONTYPE%]==[1] (set CONVERSIONTYPE=ASCII2BINARY) else set CONVERSIONTYPE=ASCII2HEX

REM Set DEBUG to 1 to see more details about what's going on. Later on in the script, in specific point you want to monitor while processing you can echo if DEBUG==1.
set DEBUG=0

REM Make sure this value is empty on start, else we could have problems. Even though it's unlikely this variable has been previously used by another script or action, avoid any unneeded errors and empty it just to be sure everything goes fine.
set string=

REM %1 indicates a parameter, if none were given it will ask for a parameter using set /p later on.
set input=%1

REM If %1 is empty, no input was given while starting this script, better ask for user input else the script wouldn't do anything:
if [%1]==[] set /p input=Enter value %CONVERSIONTYPE%:

REM Set a terminator character so the parser knows where to stop en/decoding ...

REM Now we start parsing the input string:
:EXTRACT

REM Step 1. Extract the first character
set i=%input:~0,1%

REM Step 2. Get the ASCII value from the lookup table in this script ...
IF [%CONVERSIONTYPE%]==[ASCII2HEX] for /F "tokens=1,2,3,4 delims=;" %%a in (%~nx0) do if ";%%d"==";%i%" set ASCII=%%b
IF [%CONVERSIONTYPE%]==[ASCII2BINARY] for /F "tokens=1,2,3,4 delims=;" %%a in (%~nx0) do if ";%%d"==";%i%" set ASCII=%%c
if %DEBUG%==1 echo ascii=%ASCII%
if %DEBUG%==1 echo string1=%STRING%

REM Step 3. Add the value to the existing value in the STRING variable:
set STRING=%STRING%%ASCII%
if %DEBUG%==1 echo string2=%STRING%

REM Step 4. Remove the first character from the input string ...
set input=%input:~1%

REM Step 5. Look for our termination character, if it's found, exit the parser.
if [%input%]==[] goto :DONE

REM Step 6. Repeat untill the termination character has been found.
goto :EXTRACT

:DONE
REM I make a new variable here, called %DECODED%, so if we call this script externally or from another script, we can use the output later on by echoing %DECODED%.
set DECODED=%STRING%
echo.&&echo Decoded: %DECODED%&&echo.
pause
goto :EOF

REM Here's the lookup table, R indicating it's a record, HEX, BINARY, ASCII values follow after that.
REM NOTE: There is a quirk: input anything with a " and the syntax fails!

R;00;00000000; 
R;20;00100000;#
R;21;00100001;!
R;22;00100010;"
X;23;00100011;#
R;24;00100100;$
R;25;00100101;%
R;26;00100110;&
R;27;00100111;'
R;28;00101000;(
R;29;00101001;)
R;2B;00101011;+
R;2C;00101100;,
R;2D;00101101;-
R;2E;00101110;.
R;2F;00101111;/
R;30;00110000;0
R;31;00110001;1
R;32;00110010;2
R;33;00110011;3
R;34;00110100;4
R;35;00110101;5
R;36;00110110;6
R;37;00110111;7
R;38;00111000;8
R;39;00111001;9
R;3A;00111010;:
R;3B;00111011;;
R;40;01000000;@
R;41;01000001;A
R;42;01000010;B
R;43;01000011;C
R;44;01000100;D
R;45;01000101;E
R;46;01000110;F
R;47;01000111;G
R;48;01001000;H
R;49;01001001;I
R;4A;01001010;J
R;4B;01001011;K
R;4C;01001100;L
R;4D;01001101;M
R;4E;01001110;N
R;4F;01001111;O
R;50;01010000;P
R;51;01010001;Q
R;52;01010010;R
R;53;01010011;S
R;54;01010100;T
R;55;01010101;U
R;56;01010110;V
R;57;01010111;W
R;58;01011000;X
R;59;01011001;Y
R;5A;01011010;Z
R;5B;01011011;[
R;5C;01011100;\
R;5D;01011101;]
R;5F;01011111;_
R;61;01100001;a
R;62;01100010;b
R;63;01100011;c
R;64;01100100;d
R;65;01100101;e
R;66;01100110;f
R;67;01100111;g
R;68;01101000;h
R;69;01101001;i
R;6A;01101010;j
R;6B;01101011;k
R;6C;01101100;l
R;6D;01101101;m
R;6E;01101110;n
R;6F;01101111;o
R;70;01110000;p
R;71;01110001;q
R;72;01110010;r
R;73;01110011;s
R;74;01110100;t
R;75;01110101;u
R;76;01110110;v
R;77;01110111;w
R;78;01111000;x
R;79;01111001;y
R;7A;01111010;z
R;7B;01111011;{
R;7D;01111101;}
R;7E;01111110;~
:EOF
