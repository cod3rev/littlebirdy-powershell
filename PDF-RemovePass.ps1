Clear-Host

function PDF-RemoveCred {

<#
    .SYNOPSIS 
        Strips passwords from PDF files in a batch using GhostScript

    .DESCRIPTION
        Adjust paths for the following variables for your environment:

        $pdfpath (current path of password-protected PDFs)
        $pdfnewpath (path where converted PDFs will be written to)
        $FONTPATH (should be the same if you're on Windows 10)
        $gspath (path to the GhostScript executable)
        $logpath (folder path to the script log)

        *** This script requires GhostScript >> https://www.ghostscript.com/ ***

        The current form of this function prompts the user to type in the password twice
        to confirm the initial entry. If no match, the script aborts.
        (Mainly for a work dealio / language gap)

    .SYNTAX
        PDF-RemoveCred <password>

    .EXAMPLE
        PDF-RemoveCred sunshine
#>

    Param(
        [Parameter(
            Position=0,
            Mandatory=$true,
            HelpMessage='Current password of the pdf file')]
        [string]$pwd1,

        [Parameter(
            Position=1,
            Mandatory=$true,
            HelpMessage='Current password of the pdf file')]
        [string]$pwd2

    )



    # Let's log the results to this location
        # If log doesn't exist, create it
        # If log does exist, clear it
    $logpath = "c:\temp\pdf"
    $log = "$logpath" + "\scriptlog.txt"
    if (!(Test-Path $log)){
        New-Item $log -ItemType file}
    else {
        Clear-Content $log}

    Add-Content -Path $log -Value "########################################"
    Add-Content -Path $log -Value "########## PDF-REMOVEPASS LOG ##########"
    Add-Content -Path $log -Value "########################################"
    Add-Content -Path $log -Value " "

    ###########################################################################
    # Paths to PDF files you want to strip the creds & to write new PDF files #
    ###########################################################################
    $pdfpath = "c:\temp\pdf"
    $pdfnewpath = "c:\temp\pdf\new"

    $FONTPATH = (Get-ChildItem env:WINDIR).Value + "\fonts"

    #################################################################################
    # GhostScript path - you may have to change this depending on your installation #
    #################################################################################
    $gspath = "C:\Program Files\gs\gs9.50\bin\gswin64c.exe"

    # Make sure GhostScript is installed
    if (!(Test-Path $gspath)) {
	    Write-Host "GhostScript is not installed at $gspath" -ForegroundColor Red
        Write-Host "GhostScript is required for this function & can be found at >> https://www.ghostscript.com"
        break
    }

    # Grab & store a list (array) of all PDFs in the path to this variable
    $PDFs = Get-ChildItem -Path $pdfpath | ? {$_ -like "*.pdf"}

    if ($thispass -eq $confpass){
        
        $pwd = $pwd1

        foreach ($f in $PDFs){
            Write-Host "Processing $f..." -ForegroundColor Green -NoNewline
            $thisfile = "$pdfpath" + "\$f"
            $outputfile = "$pdfnewpath" + "\$f"
            $now = Get-Date -Format "ddMMyyyy::hh.mm:ss"

            try {

                & $gspath -dQUIET -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sFONTPATH=$FONTPATH `
                -sPDFPassword="$pwd" -dPDFSettings=/prepress -dPassThroughJPEGImages=true `
                -sOutputFile="$outputfile" $thisfile
            
                Write-Host "complete" -ForegroundColor Yellow
                $content = "$now " + "Password removal for $thisfile successful"  
                Add-Content -Path $log -Value $content
                if ($LASTEXITCODE -ne 0){
                    break
                }

            }

            catch {
            
                Write-host "failed!" -ForegroundColor Red
                $content = "$now " + ">> Password removal for $thisfile failed! <<"
                Add-Content -Path $log -Value $content
            }

        }

    }

    else {

        Write-Host "Passwords do not match...exiting the script." -ForegroundColor Yellow

    }

}

$thispass = Read-Host -Prompt "PDF Password"
$confpass = Read-host -Prompt "Confirm Password"
PDF-RemoveCred $thispass $confpass