# LittleBirdy for PowerShell

This is a PowerShell version of [LittleBirdy](https://github.com/jakepetroules/littlebirdy) for Windows users. It uses [GhostScript](http://www.ghostscript.com/) to strip permissions & remove passwords from PDF files. Take a look at the readme section of the original project for the history and the reason behind the name.

## Fork Info 

This flavor is forked from [hartez](https://github.com/hartez/littlebirdy-powershell) - much appreciation to his project as Google never woulda found LittleBirdy w/out his PowerShell project indexed here :)

GhostScript & the initial little-birdy PowerShell project allows you to strip permissions from a PDF, and the original LittleBirdy script makes GhostScript easy to use for this purpose. This fork simply adds the functionality of stripping the password as well. 

## Does this version remove document passwords?

YES! The only prerequisite is you must know the password of the encrypted file(s). This is not a password cracking utility.

