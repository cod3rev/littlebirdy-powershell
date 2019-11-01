# LittleBirdy for PowerShell

This is a PowerShell version of [LittleBirdy](https://github.com/jakepetroules/littlebirdy) for Windows users. It uses [GhostScript](http://www.ghostscript.com/) to strip permissions & remove passwords from PDF files. Take a look at the readme section of the original project for the history and the reason behind the name.

## Fork Info 

This flavor (PDF-RemovePass.ps1) is forked from [hartez](https://github.com/hartez/littlebirdy-powershell) & is the script which adds password removal. Much appreciation to his project as Google never would have found LittleBirdy w/out his PowerShell project indexed here.  :)

GhostScript & the initial littlebirdy-PowerShell project allows you to strip permissions from a PDF, and the original LittleBirdy script makes GhostScript easy to use for this purpose. This fork simply adds the functionality of stripping the password as well. 

## Does this version remove document passwords?

YES! The only prerequisite is you must know the password of the encrypted file(s). This is not a password cracking utility.

## Upcoming

May pivot to include a choice to strip permissions, strip the password, or both in the same script...

