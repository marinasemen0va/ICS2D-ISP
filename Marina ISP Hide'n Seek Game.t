%Marina Semenova
%Valentina Krasteva
%June 11, 2018
%This is a matching game between terms and images of computer hardware, with an objective to find a smiley hidden behind an image

%Set Screen Up
import GUI
setscreen ("noecho")
setscreen ("nocursor")

%Declaration Section
var mainWin := Window.Open ("position: 300;300, graphics: 640;400") %opens window
var rangeX, rangeY, button : int %used to track user input
var pic1, pic2, pic3, pic4, pic5, pic6, pic7, pic8, pic9, pic10 : int %pictures
var smiley : int %smiley picture
var score : int := 0 %counter for user score
var playButton, instructionsButton, exitButton, menuButton : int %GUI buttons
forward proc mainMenu %proc
forward proc userInput %proc
forward proc instructions %proc
forward proc display %proc
var randNum, randNumSmiley : int %randomises image positions
var xPos : array 1 .. 10 of int := init (30, 150, 270, 390, 510, 30, 150, 270, 390, 510) %randomises image positions
var yPos : array 1 .. 10 of int := init (140, 140, 140, 140, 140, 250, 250, 250, 250, 250) %randomises image positions
var imageTerm : array 1 .. 10 of string %assigns the 10 terms a position
var storeRandNum : int %stores the randNum so that when the pictures are re-drawn they aren't randomised again
var smileyPressed : boolean := false %assigned true when the smiley is pressed and used to display win by smiley message
var images : array 1 .. 10 of int %stores the images so that when the answer is wrong the right image is displayed

%Program Title
proc title
    cls
    locate (1, 35)
    for x : 0 .. 400
	drawline (0, 0 + x, 640, 0 + x, 93)
    end for
    colourback (93)
    put "Hide'n Seek"
    put " "
end title

%Music
process music
    play ("4efg>2abge<4ccdfgfg,>aa1a<")
end music

%Program Introduction
proc introduction
    title
    fork music
    menuButton := GUI.CreateButton (280, 200, 0, "Menu", mainMenu)
    put " ~ This program is designed to test your knowledge of computer hardware!"
    put " ~ You will have to match the term to the image of the corresponding hardware!"
    put " ~ Behind one of the images a smiley is hidden, and if you find it, you win!"
    %Animation
    for x : 0 .. 90 %background
	drawline (0, 230 + x, 640, 230 + x, 76)
    end for
    for x : 0 .. 360 %move
	drawfilloval (-51 + x, 275, 40, 40, 76) %erase
	drawfilloval (-50 + x, 275, 40, 40, 68) %face
	drawfilloval (-70 + x, 285, 5, 5, 0) %eye
	drawfilloval (-30 + x, 285, 5, 5, 0) %eye
	drawfilloval (-70 + x, 284, 2, 2, 7) %pupil
	drawfilloval (-30 + x, 284, 2, 2, 7) %pupil
	drawfillarc (-50 + x, 275, 20, 5, 180, 360, 12) %mouth
	delay (10)
	View.Update
    end for
    for x : 1 .. 40     %face
	drawoval (310, 275, x, x, 68)
	drawoval (310, 276, x, x, 68)
    end for
    for x : 1 .. 5     %eyes
	drawoval (290, 285, x, x, 0)
	drawoval (290, 286, x, x, 0)
	drawoval (330, 285, x, x, 0)
	drawoval (330, 286, x, x, 0)
    end for
    for x : 1 .. 2     %pupils
	drawoval (290, 284, x, x, 7)
	drawoval (290, 285, x, x, 7)
	drawoval (330, 284, x, x, 7)
	drawoval (330, 285, x, x, 7)
    end for
    for x : 1 .. 20     %mouth animation
	drawfillarc (310, 275, 20, 5 + x, 180, 360, 68)     %erase
	drawfillarc (310, 275, 20, 5 + x, 180, 360, 12)     %draw
	delay (70)
	View.Update
    end for
end introduction

%Main Menu
body proc mainMenu
    title
    %Reset score
    score := 0
    %Randomizes the position of images
    randNum := Rand.Int (1, 10)
    randNumSmiley := Rand.Int (1, 10)
    storeRandNum := randNum
    %Buttons
    GUI.Hide (menuButton)
    playButton := GUI.CreateButton (265, 250, 0, "New Game", userInput)
    instructionsButton := GUI.CreateButton (265, 200, 0, "Instructions", instructions)
    exitButton := GUI.CreateButton (280, 150, 0, "Exit", GUI.Quit)
end mainMenu

%Instructions
body proc instructions
    GUI.Hide (playButton)
    GUI.Hide (instructionsButton)
    GUI.Hide (exitButton)
    title
    GUI.Show (menuButton)
    put " ~ You will be shown 10 different pieces of computer hardware"
    put " ~ At the bottom of the screen a computer hardware term will be displayed"
    put " ~ You will have to match the term to the corresponding image" 
    put " ~ Once you match the correct image, it will move to the bottom of the screen, "
    put "   overtop the term"
    put " ~ Behind one of  images is a smiley face"
    put " ~ If you find it before you match all the terms to the images you win!"
    put " ~ You lose if you match the wrong image with the term"
    put " ~ Your score will be displayed once you exit the game"
end instructions

%Draws Pictures in Randomized Positions (has processing to ensure index within array parameters)
proc pictures
    title
    randNum := storeRandNum
    Pic.Draw (smiley, xPos (randNumSmiley), yPos (randNumSmiley), picMerge)     %Smiley
    Pic.Draw (pic1, xPos (randNum), yPos (randNum), picMerge)     %1
    imageTerm (randNum) := "Hard drive"
    images (randNum) := pic1
    randNum += 1
    if randNum > 10 then
	randNum := 1
    end if
    imageTerm (randNum) := "CPU"
    images (randNum) := pic2
    Pic.Draw (pic2, xPos (randNum), yPos (randNum), picMerge)     %2
    randNum += 1
    if randNum > 10 then
	randNum := 1
    end if
    imageTerm (randNum) := "Floppy Disk"
    images (randNum) := pic3
    Pic.Draw (pic3, xPos (randNum), yPos (randNum), picMerge)     %3
    randNum += 1
    if randNum > 10 then
	randNum := 1
    end if
    imageTerm (randNum) := "Keyboard"
    images (randNum) := pic4
    Pic.Draw (pic4, xPos (randNum), yPos (randNum), picMerge)     %4
    randNum += 1
    if randNum > 10 then
	randNum := 1
    end if
    imageTerm (randNum) := "Monitor"
    images (randNum) := pic5
    Pic.Draw (pic5, xPos (randNum), yPos (randNum), picMerge)     %5
    randNum += 1
    if randNum > 10 then
	randNum := 1
    end if
    imageTerm (randNum) := "Motherboard"
    images (randNum) := pic6
    Pic.Draw (pic6, xPos (randNum), yPos (randNum), picMerge)     %6
    randNum += 1
    if randNum > 10 then
	randNum := 1
    end if
    imageTerm (randNum) := "Mouse"
    images (randNum) := pic7
    Pic.Draw (pic7, xPos (randNum), yPos (randNum), picMerge)     %7
    randNum += 1
    if randNum > 10 then
	randNum := 1
    end if
    imageTerm (randNum) := "RAM"
    images (randNum) := pic8
    Pic.Draw (pic8, xPos (randNum), yPos (randNum), picMerge)     %8
    randNum += 1
    if randNum > 10 then
	randNum := 1
    end if
    imageTerm (randNum) := "Speakers"
    images (randNum) := pic9
    Pic.Draw (pic9, xPos (randNum), yPos (randNum), picMerge)     %9
    randNum += 1
    if randNum > 10 then
	randNum := 1
    end if
    imageTerm (randNum) := "USB"
    images (randNum) := pic10
    Pic.Draw (pic10, xPos (randNum), yPos (randNum), picMerge)     %10
end pictures

%User Input
body proc userInput
    GUI.Hide (playButton)
    GUI.Hide (instructionsButton)
    GUI.Hide (exitButton)
    %Declaration
    var correct : int := 0     %is assigned the position of the matching image, used in processing where the parameters of the mouse click should be
    %Load pictures in RAM once
    pic1 := Pic.FileNew ("Hard drive.jpg")
    pic2 := Pic.FileNew ("CPU.jpg")
    pic3 := Pic.FileNew ("Floppy disk.jpg")
    pic4 := Pic.FileNew ("Keyboard.jpg")
    pic5 := Pic.FileNew ("Monitor.jpg")
    pic6 := Pic.FileNew ("Motherboard.jpg")
    pic7 := Pic.FileNew ("Mouse.jpg")
    pic8 := Pic.FileNew ("RAM.jpg")
    pic9 := Pic.FileNew ("Speakers.jpg")
    pic10 := Pic.FileNew ("USB.jpg")
    smiley := Pic.FileNew ("Smiley.jpg")
    %Output term, recieve user input, process whether right image or smiley pressed, output image
    %Term 8
    pictures
    locate (24, 39)
    put "RAM"
    for x : 1 .. 10
	if imageTerm (x) = "RAM" then
	    correct := x
	end if
    end for
    loop
	mousewhere (rangeX, rangeY, button)
	if button = 1 then
	    if (rangeX > xPos (correct) and rangeX < xPos (correct) + 100) and (rangeY > yPos (correct) and rangeY < yPos (correct) + 100) then
		locate (3, 1)
		Pic.Draw (pic8, 270, 30, picMerge)
		pic8 := Pic.FileNew ("Erase.jpg")
		delay (1000)
	    elsif (rangeX > xPos (randNumSmiley) and rangeX < xPos (randNumSmiley) + 100) and (rangeY > yPos (randNumSmiley) and rangeY < yPos (randNumSmiley) + 100) then
		smileyPressed := true
		display
		return
	    else
		for x : 1 .. 10
		    if (rangeX > xPos (x) and rangeX < (xPos (x) + 100)) and (rangeY > yPos (x) and rangeY < (xPos (x) + 100)) then
			Pic.Draw (images (x), 270, 30, picMerge)
		    end if
		end for
		delay (1000)
		display
		return
	    end if
	end if
	exit when button = 1
    end loop
    score += 1
    %Term 4
    pictures
    locate (24, 37)
    put "Keyboard"
    for x : 1 .. 10
	if imageTerm (x) = "Keyboard" then
	    correct := x
	end if
    end for
    loop
	mousewhere (rangeX, rangeY, button)
	if button = 1 then
	    if (rangeX > xPos (correct) and rangeX < xPos (correct) + 100) and (rangeY > yPos (correct) and rangeY < yPos (correct) + 100) then
		locate (3, 1)
		Pic.Draw (pic4, 270, 30, picMerge)
		pic4 := Pic.FileNew ("Erase.jpg")
		delay (1000)
	    elsif (rangeX > xPos (randNumSmiley) and rangeX < xPos (randNumSmiley) + 100) and (rangeY > yPos (randNumSmiley) and rangeY < yPos (randNumSmiley) + 100) then
		smileyPressed := true
		display
		return
	    else
		for x : 1 .. 10
		    if (rangeX > xPos (x) and rangeX < (xPos (x) + 100)) and (rangeY > yPos (x) and rangeY < (xPos (x) + 100)) then
			Pic.Draw (images (x), 270, 30, picMerge)
		    end if
		end for
		delay (1000)
		display
		return
	    end if
	end if
	exit when button = 1
    end loop
    score += 1
    %Term 10
    pictures
    locate (24, 39)
    put "USB"
    for x : 1 .. 10
	if imageTerm (x) = "USB" then
	    correct := x
	end if
    end for
    loop
	mousewhere (rangeX, rangeY, button)
	if button = 1 then
	    if (rangeX > xPos (correct) and rangeX < xPos (correct) + 100) and (rangeY > yPos (correct) and rangeY < yPos (correct) + 100) then
		locate (3, 1)
		Pic.Draw (pic10, 270, 30, picMerge)
		pic10 := Pic.FileNew ("Erase.jpg")
		delay (1000)
	    elsif (rangeX > xPos (randNumSmiley) and rangeX < xPos (randNumSmiley) + 100) and (rangeY > yPos (randNumSmiley) and rangeY < yPos (randNumSmiley) + 100) then
		smileyPressed := true
		display
		return
	    else
		for x : 1 .. 10
		    if (rangeX > xPos (x) and rangeX < (xPos (x) + 100)) and (rangeY > yPos (x) and rangeY < (xPos (x) + 100)) then
			Pic.Draw (images (x), 270, 30, picMerge)
		    end if
		end for
		delay (1000)
		display
		return
	    end if
	end if
	exit when button = 1
    end loop
    score += 1
    %Term 7
    pictures
    locate (24, 38)
    put "Mouse"
    for x : 1 .. 10
	if imageTerm (x) = "Mouse" then
	    correct := x
	end if
    end for
    loop
	mousewhere (rangeX, rangeY, button)
	if button = 1 then
	    if (rangeX > xPos (correct) and rangeX < xPos (correct) + 100) and (rangeY > yPos (correct) and rangeY < yPos (correct) + 100) then
		locate (3, 1)
		Pic.Draw (pic7, 270, 30, picMerge)
		pic7 := Pic.FileNew ("Erase.jpg")
		delay (1000)
	    elsif (rangeX > xPos (randNumSmiley) and rangeX < xPos (randNumSmiley) + 100) and (rangeY > yPos (randNumSmiley) and rangeY < yPos (randNumSmiley) + 100) then
		smileyPressed := true
		display
		return
	    else
		for x : 1 .. 10
		    if (rangeX > xPos (x) and rangeX < (xPos (x) + 100)) and (rangeY > yPos (x) and rangeY < (xPos (x) + 100)) then
			Pic.Draw (images (x), 270, 30, picMerge)
		    end if
		end for
		delay (1000)
		display
		return
	    end if
	end if
	exit when button = 1
    end loop
    score += 1
    %Term 2
    pictures
    locate (24, 39)
    put "CPU"
    for x : 1 .. 10
	if imageTerm (x) = "CPU" then
	    correct := x
	end if
    end for
    loop
	mousewhere (rangeX, rangeY, button)
	if button = 1 then
	    if (rangeX > xPos (correct) and rangeX < xPos (correct) + 100) and (rangeY > yPos (correct) and rangeY < yPos (correct) + 100) then
		locate (3, 1)
		Pic.Draw (pic2, 270, 30, picMerge)
		pic2 := Pic.FileNew ("Erase.jpg")
		delay (1000)
	    elsif (rangeX > xPos (randNumSmiley) and rangeX < xPos (randNumSmiley) + 100) and (rangeY > yPos (randNumSmiley) and rangeY < yPos (randNumSmiley) + 100) then
		smileyPressed := true
		display
		return
	    else
		for x : 1 .. 10
		    if (rangeX > xPos (x) and rangeX < (xPos (x) + 100)) and (rangeY > yPos (x) and rangeY < (xPos (x) + 100)) then
			Pic.Draw (images (x), 270, 30, picMerge)
		    end if
		end for
		delay (1000)
		display
		return
	    end if
	end if
	exit when button = 1
    end loop
    score += 1
    %Term 5
    pictures
    locate (24, 37)
    put "Monitor"
    for x : 1 .. 10
	if imageTerm (x) = "Monitor" then
	    correct := x
	end if
    end for
    loop
	mousewhere (rangeX, rangeY, button)
	if button = 1 then
	    if (rangeX > xPos (correct) and rangeX < xPos (correct) + 100) and (rangeY > yPos (correct) and rangeY < yPos (correct) + 100) then
		locate (3, 1)
		Pic.Draw (pic5, 270, 30, picMerge)
		pic5 := Pic.FileNew ("Erase.jpg")
		delay (1000)
	    elsif (rangeX > xPos (randNumSmiley) and rangeX < xPos (randNumSmiley) + 100) and (rangeY > yPos (randNumSmiley) and rangeY < yPos (randNumSmiley) + 100) then
		smileyPressed := true
		display
		return
	    else
		for x : 1 .. 10
		    if (rangeX > xPos (x) and rangeX < (xPos (x) + 100)) and (rangeY > yPos (x) and rangeY < (xPos (x) + 100)) then
			Pic.Draw (images (x), 270, 30, picMerge)
		    end if
		end for
		delay (1000)
		display
		return
	    end if
	end if
	exit when button = 1
    end loop
    score += 1
    %Term 9
    pictures
    locate (24, 37)
    put "Speakers"
    for x : 1 .. 10
	if imageTerm (x) = "Speakers" then
	    correct := x
	end if
    end for
    loop
	mousewhere (rangeX, rangeY, button)
	if button = 1 then
	    if (rangeX > xPos (correct) and rangeX < xPos (correct) + 100) and (rangeY > yPos (correct) and rangeY < yPos (correct) + 100) then
		locate (3, 1)
		Pic.Draw (pic9, 270, 30, picMerge)
		pic9 := Pic.FileNew ("Erase.jpg")
		delay (1000)
	    elsif (rangeX > xPos (randNumSmiley) and rangeX < xPos (randNumSmiley) + 100) and (rangeY > yPos (randNumSmiley) and rangeY < yPos (randNumSmiley) + 100) then
		smileyPressed := true
		display
		return
	    else
		for x : 1 .. 10
		    if (rangeX > xPos (x) and rangeX < (xPos (x) + 100)) and (rangeY > yPos (x) and rangeY < (xPos (x) + 100)) then
			Pic.Draw (images (x), 270, 30, picMerge)
		    end if
		end for
		delay (1000)
		display
		return
	    end if
	end if
	exit when button = 1
    end loop
    score += 1
    %Term 3
    pictures
    locate (24, 35)
    put "Floppy Disk"
    for x : 1 .. 10
	if imageTerm (x) = "Floppy Disk" then
	    correct := x
	end if
    end for
    loop
	mousewhere (rangeX, rangeY, button)
	if button = 1 then
	    if (rangeX > xPos (correct) and rangeX < xPos (correct) + 100) and (rangeY > yPos (correct) and rangeY < yPos (correct) + 100) then
		locate (3, 1)
		Pic.Draw (pic3, 270, 30, picMerge)
		pic3 := Pic.FileNew ("Erase.jpg")
		delay (1000)
	    elsif (rangeX > xPos (randNumSmiley) and rangeX < xPos (randNumSmiley) + 100) and (rangeY > yPos (randNumSmiley) and rangeY < yPos (randNumSmiley) + 100) then
		smileyPressed := true
		display
		return
	    else
		for x : 1 .. 10
		    if (rangeX > xPos (x) and rangeX < (xPos (x) + 100)) and (rangeY > yPos (x) and rangeY < (xPos (x) + 100)) then
			Pic.Draw (images (x), 270, 30, picMerge)
		    end if
		end for
		delay (1000)
		display
		return
	    end if
	end if
	exit when button = 1
    end loop
    score += 1
    %Term 1
    pictures
    locate (24, 36)
    put "Hard drive"
    for x : 1 .. 10
	if imageTerm (x) = "Hard drive" then
	    correct := x
	end if
    end for
    loop
	mousewhere (rangeX, rangeY, button)
	if button = 1 then
	    if (rangeX > xPos (correct) and rangeX < xPos (correct) + 100) and (rangeY > yPos (correct) and rangeY < yPos (correct) + 100) then
		locate (3, 1)
		Pic.Draw (pic1, 270, 30, picMerge)
		pic1 := Pic.FileNew ("Erase.jpg")
		delay (1000)
	    elsif (rangeX > xPos (randNumSmiley) and rangeX < xPos (randNumSmiley) + 100) and (rangeY > yPos (randNumSmiley) and rangeY < yPos (randNumSmiley) + 100) then
		smileyPressed := true
		display
		return
	    else
		for x : 1 .. 10
		    if (rangeX > xPos (x) and rangeX < (xPos (x) + 100)) and (rangeY > yPos (x) and rangeY < (xPos (x) + 100)) then
			Pic.Draw (images (x), 270, 30, picMerge)
		    end if
		end for
		delay (1000)
		display
		return
	    end if
	end if
	exit when button = 1
    end loop
    score += 1
    %Term 6
    pictures
    locate (24, 35)
    put "Motherboard"
    for x : 1 .. 10
	if imageTerm (x) = "Motherboard" then
	    correct := x
	end if
    end for
    loop
	mousewhere (rangeX, rangeY, button)
	if button = 1 then
	    if (rangeX > xPos (correct) and rangeX < xPos (correct) + 100) and (rangeY > yPos (correct) and rangeY < yPos (correct) + 100) then
		locate (3, 1)
		Pic.Draw (pic6, 270, 30, picMerge)
		pic6 := Pic.FileNew ("Erase.jpg")
		delay (1000)
	    elsif (rangeX > xPos (randNumSmiley) and rangeX < xPos (randNumSmiley) + 100) and (rangeY > yPos (randNumSmiley) and rangeY < yPos (randNumSmiley) + 100) then
		smileyPressed := true
		display
		return
	    else
		for x : 1 .. 10
		    if (rangeX > xPos (x) and rangeX < (xPos (x) + 100)) and (rangeY > yPos (x) and rangeY < (xPos (x) + 100)) then
			Pic.Draw (images (x), 270, 30, picMerge)
		    end if
		end for
		delay (1000)
		display
		return
	    end if
	end if
	exit when button = 1
    end loop
    score += 1
    display
end userInput

%Display
body proc display
    fork music
    title
    %Declaration
    var message : string  %used to personalize message according to score and whethet smileyPressed = true
    %Convert score to percent
    score := (score * 100) div 10
    %Personalizes the message based on input
    if score = 100 then
	message := "You got em' all! You win!"
    elsif smileyPressed = true then
	message := "You have won by getting the smiley!"
    else
	message := "Nice try!"
    end if
    %Output
    put message, " You got ", score, "% of the questions correct."
    %Menu
    GUI.Show (menuButton)
end display

%Goodbye
proc goodbye
    title
    put "Thank you for using Marina Semenova's matching game!"
    put " "
    put "Press any key to end this program" ..
    loop
	exit when hasch
    end loop
    Window.Close (mainWin)
end goodbye

%Main Program
introduction
loop
    exit when GUI.ProcessEvent
end loop
goodbye
%End of Program

