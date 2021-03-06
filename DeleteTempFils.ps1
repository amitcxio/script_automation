<#
The sample scripts are not supported under any Microsoft standard support 
program or service. The sample scripts are provided AS IS without warranty  
of any kind. Microsoft further disclaims all implied warranties including,  
without limitation, any implied warranties of merchantability or of fitness for 
a particular purpose. The entire risk arising out of the use or performance of  
the sample scripts and documentation remains with you. In no event shall 
Microsoft, its authors, or anyone else involved in the creation, production, or 
delivery of the scripts be liable for any damages whatsoever (including, 
without limitation, damages for loss of business profits, business interruption, 
loss of business information, or other pecuniary loss) arising out of the use 
of or inability to use the sample scripts or documentation, even if Microsoft 
has been advised of the possibility of such damages.
#>

#requires -Version 3
Function Clear-OSCTempFile
{
    #This function is used to delete temp files such as Internet temp file in windows 8 
    #Get all items with ".tmp" in the $env:TEMP path 
    $TempFiles =Get-ChildItem -Path $env:TEMP -Recurse | Where-Object {$_.Extension -contains ".tmp" } 
    #Call the function to delete them
    DeleteTemp $TempFiles
    #Get all items with ".tmp" in Temporary Internet Files 
    $InternetTempPath = "C:\Users\$env:USERNAME\AppData\Local\Microsoft\Windows\Temporary Internet Files"
    $InternetTmpFiles= Get-ChildItem -Path  $InternetTempPath -Recurse |Where-Object {$_.Extension -contains ".tmp"}
    #Call the function to delete them
    DeleteTemp $InternetTmpFiles  
}
Function DeleteTemp($Files)
{
    #This function is to delete the file in an array
    Foreach ($File in $Files)
    {
        $path = $File.FullName
        If($path -ne $null)
        {
            Try
            {
                #Delete the item 
                Remove-Item -Path $path -Force -ErrorAction Stop
                Write-Host "Delete ""$path"" successfully."
            }
            Catch
            {
                Write-Warning """$path"":Access is denied. Please close the IE browser or related programs"
            }
        }
    }
}
Clear-OSCTempFile