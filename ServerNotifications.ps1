"Intializing"

$prevData = @()
$prevData[0] = null
$prevData[1] = null

$intr = 1500 #15minutes 00seconds

cls
"Starting"
Server


function Server{

    #Run Server here and have it wait till process closes

    Check
    Server
}

function Check{
    #get current date and time
    $arr = ((get-date).ToString('') -replace " PM",'' -replace ":",'' -replace "/",'' -replace " AM",'') -split ' '

    #check if since script started server has shutdown before
    if($prevData[0] = null){
        $prevData[0] = $arr[0]
        $prevData[1] = $arr[1]
    }

    #check date it shutdown compared to previous shutdown
    if(prevData[0] - arr[0] = 0){

        #check time it shutdown compared to previous shutdown
        if(prevData[1] - arr[1] -le intr){ #if difference is less then 15 minutes
            "Server May Be in a Crash Loop"
            Notifications(1) #Notifies of possible Crash Loop
            Pause
            return
        }

        $prevData = $arr
        Notifications(0) #Notifies of shutdown
        return
    }

    $prevData = $arr
    Notifications(0) #Notifies of shutdown
    return
}

function Notifications($ver){
    $user = "sharkgaming.notifications@gmail.com"
    $pass = ConvertTo-SecureString -String "rootboot35" -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential $user, $pass
    if(ver = 0){$Sub = "Server Crashed/Shutdown"}
    if(ver = 1){$Sub = "Server May Be in a Crash Loop"}
    $mailParam = @{
        To = "**********@mms.att.net" # <10 digit number> @ <providers email to text/mms ext>
        From = $user
        Subject = $Sub
        Body = " "
        SmtpServer = "smtp.gmail.com"
        Port = 587
        Credential = $cred
    }
    Send-MailMessage @mailParam -UseSsl
}