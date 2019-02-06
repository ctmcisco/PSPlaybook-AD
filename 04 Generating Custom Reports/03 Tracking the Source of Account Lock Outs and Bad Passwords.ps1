#region Prep work for lockouts
# Account lockout Event ID
$LockOutID = 4740

# Find the PDC
(Get-ADDomain).PDCEmulator
$PDCEmulator = (Get-ADDomain).PDCEmulator

# Query event log
Get-WinEvent -ComputerName $PDCEmulator -FilterHashtable @{
    LogName = 'Security'
    ID = $LockOutID
}
#endregion

#region Parse the event
# Assign to a variable
$events = Get-WinEvent -ComputerName $PDCEmulator -FilterHashtable @{
    LogName = 'Security'
    ID = $LockOutID
}

# Examine some properties
$events[0].Message

# Regex?
$events[0].Message -match 'Caller Computer Name:\s+(?<caller>[^\s]+)'
$Matches.caller

# Cool, but not as easy as:
$events[0].Properties
$events[0].Properties[1].Value

# For all events:
ForEach($event in $events){
    [pscustomobject]@{
        UserName = $event.Properties[0].Value
        CallerComputer = $event.Properties[1].Value
        TimeStamp = $event.TimeCreated
    }
}

#endregion

#region Prep work for bad passwords

#endregion