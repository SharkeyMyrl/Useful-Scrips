"Intializing"

$prevDay = null
$prevTime = null
$prevYear = null

$intr = 15 #15minutes

$msgSent = false

cls
"Starting"
Server


function Server{

    #Run Server here and have it wait till process closes

    Check
    Server
}

function Check{
    if(!$prevDay.Value){
        $prevDay = (get-date).DayOfYear
        $prevTime = (Get-Date -Format hm)
        $prevYear = (get-date -UFormat %Y)
        #Notifications(0)
        #return
    }

    $dayDiff = $prevDay - (get-date).DayOfYear
    $timeDiff = $prevTime - (geget-date -Format HHmm)
    $yearDiff = $prevYear - (get-date -UFormat %Y)

    if($dayDiff -eq -1){
        if($timeDiff -le 2359 - $intr){
            Notifications(1)
            pause
            return
        }

        Notifications(0)
        return
    }

    if($dayDiff -eq 0){
        if($timeDiff -le $intr){
            Notifications(1)
            pause
            return
        }

        Notifications(0)
        return
    }
    if($yearDiff -eq -1){
        #Is it first day of new year and last shutdown was last day of last year
        if($dayDiff -eq (get-date -Year $prevYear -Month 12 -Day 30).DayOfYear ){ 
            if($timeDiff -le 2359 - $intr){
                Notifications(1)
                pause
                return
            }
        }

        Notifications(0)
        return
    }
       
    Notifications(0)
    return

}

function Notifications($ver){
    $user = "sharkgaming.notifications@gmail.com"
    $pass = ConvertTo-SecureString -String "rootboot35" -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential $user, $pass
    if($ver -eq 0){$Sub = "Server Crashed/Shutdown", $msgSent = false}
    if($ver -eq 1){$Sub = "Server May Be in a Crash Loop", $msgSent = true}
    $mailParam = @{
        To = "**********@mms.att.net" # <10 digit number> @ <providers email to text/mms ext>
        From = $user
        Subject = $Sub
        Body = " "
        SmtpServer = "smtp.gmail.com"
        Port = 587
        Credential = $cred
    }
	if($ver -eq 1 and $msgSent -eq true){}else{Send-MailMessage @mailParam -UseSsl}
}