<#
# Filtering for certain event logs

$skipEventLogs = 'Security','System' #Or any specfic Log that you prefer to search for
#Here is search for logs that has records | The $skipEventLogs; so we are skipping the events that we list in the skips event log 
$LogsToSearch = Get-WinEvent -ListLog * | Where-Object {$_.RecordCount -and ($skipEventLogs -notcontains $_.LogName)} | Select-Object -ExpandProperty LogName

$LogsToSearch

# If we hihligted this above code alone, it will not list the logs for Security and System Event
#>
<# -------------------------------------------------------------------- #>

#Computers to search
$ComputerName = 'GBDC01'

#Timeframe to search between
$StartTimeStamp = (Get-Date).AddHours(-12)
$EndTimeStamp = Get-Date

#Logs to skip OR include separated by commas - Choose one or neither
$includeEventLogs = 'System','Application'
#OR
$skipEventLogs = ''

#Output file path
$OutputFilePath = 'C:\extract\eventlogs.txt'

#endregion

#Index variable
$ComputerCount = 0
#For each loop here is going to loop through each of the specified computer name
ForEach($Computer in $ComputerName){
    $ComputerCount++
    Write-Progress -Activity "Processing computers" -Status "Processing $Computer" -PercentComplete ($ComputerCount/$ComputerName.Count*100) -Id 0

    If($includeEventLogs){
        $LogsToSearch = $includeEventLogs
        #Here where the Filtering happen
    }Else{
        $LogsToSearch = Get-WinEvent -ListLog * | Where-Object {$_.RecordCount -and ($skipEventLogs -notcontains $_.LogName)} | Select-Object -ExpandProperty LogName
    } #The $skipEventLogs; so we are skipping the events that we list in the skips event log 

    #Index variable
    $logCount = 0

    # Finally this is going to loop through this for each loop on line 51, we're going to loop through each of these logs
    ForEach ($log in $LogsToSearch){    
        $logCount++
        Write-Progress -Activity 'Processing logs' -Status "Processing $log" -PercentComplete ($logCount/$LogsToSearch.Count*100) -ParentId 0 -Id 1
        
        #Query; where the magic happens where we specify the computer name / Remote Computers
        Get-WinEvent -ComputerName $Computer -FilterHashtable @{
            'LogName' = $log
            'StartTime' = $StartTimeStamp
            'EndTime' = $EndTimeStamp    
        } | Out-File -FilePath $OutputFilePath -Append -Force
    }
    Write-Progress -Activity 'Processing logs' -Id 1 -Completed
}
#endregion