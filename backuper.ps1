# Define the paths and credentials for the remote server
$remoteUser = "username"
$remoteServer = "server address"
$remotePath = "/path/to/backup"
$localDriveLetter = "C:"  # Replace with the drive letter you want to back up
$shadowDriveLetter = "X:"  # Replace with an unused drive letter

# Create a shadow copy
$shadowId = & vshadow.exe -p $localDriveLetter

# Expose the shadow copy as a drive
& vshadow.exe -el=$shadowId, $shadowDriveLetter

# Sync the snapshot to the remote location
$rsyncPath = "/cygdrive/" + $shadowDriveLetter.Replace(':', '')
& rsync -az --delete $rsyncPath $remoteUser@$remoteServer:$remotePath

# Remove the shadow copy
& vshadow.exe -da
