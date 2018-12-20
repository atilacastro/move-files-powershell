$ORIGIN="\\192.168.250.150\backup\*"
$DESTINATION="E:\backup\"


$DIR= Test-Path "c:\Scripts"

Switch ($DIR){
    
    True {"Directory Does Exist"}

    False {"Directory Doesn't exist";
        echo "Directory will be created";
        New-Item -ItemType Directory -Path c: -Name Scripts
          }

    Default {"Houve algum erro na compilação dos dados"}
}

Write-Host "########################################################################################" >> "c:\Scripts\log.txt"

Write-Host "Perform backup copy of database to backup server" >> "c:\Scripts\log.txt"

#Comand below performs the Backup copy and the -Recurse parameter "Force" copying files already in the directory

Write-Host "########################################################################################" 

Copy-Item -Path $ORIGIN -Destination $DESTINATION -Recurse >> "c:\Scripts\log.txt"
#Command below will delete files with the lifetime of more than 30 days

Write-Host "########################################################################################"

$now = Get-Date
$Days="7"
$LastWrite = $Now.AddDays(-$Days)
$Files = Get-Childitem $DESTINATION  -Recurse | Where {$_.LastWriteTime -le "$LastWrite"}



if ($Files -ne $NULL)
    {
        foreach ($File in $Files) { 
                write-host "Removing file $File" -ForegroundColor "DarkRed" >>"c:\Scripts\log.txt"
                Remove-Item $File.FullName
                $Files2 = $Files | Out-String 
            }
        }
else
        {
           Write-Host "No (more) Files to remove!" -foregroundcolor "Green" >> "c:\Scripts\log.txt"
           $Files2 = "No files have been removed today!" | Out-String 
        }


Write-Host "################################################################" >> "c:\Scripts\log.txt"

Write-Host "Script has been executed $now" >> "c:\Scripts\log.txt"