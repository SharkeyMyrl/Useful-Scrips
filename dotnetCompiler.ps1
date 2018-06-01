 #Entry Point#
##Main Script##
cls
"Hello Master."
Start-Sleep 1
cls
think

function think{
    $cmd = Read-Host "What shall I do for you?"
    Switch($cmd){
        'CompileCS' {
            $file = Read-Host "What file?"
            C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe $PSScriptRoot\$file
            "Process Finished"
            Start-Sleep 2
            Wait
            break
        }
        'CompileCSExt' {
            $file = Read-Host "What's the full file extension?"
            C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe $file
            "Process Finished"
            Start-Sleep 2
            Wait
            break
        }
        'Night'{
            "Goodnight master"
            Start-Sleep 2
            exit
        }
        'Shutdown'{
            "Shutdown computer master..."
            Start-Sleep 2
            Stop-Computer -Force
        }
        'Restart'{
            "Restarting computer master..."
            Start-Sleep 2
            Restart-Computer -Force
        }
        default {}
    }

}

##$pass = Read-Host -Prompt 'Password'-AsSecureString