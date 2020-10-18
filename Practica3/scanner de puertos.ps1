function Get-Teams{
$teams = Get-Team -User $sUserName | Format-Table -Property DisplayName, GroupId
Write-Host "YOURT TEAMS OF TEAMS ARE"
$teams
}

function Create-Teams{
$nombreEquipo = Read-Host "Type your team name"
$nuevoEquipo = New-Team -DisplayName $nombreEquipo
Write-Host "Your team class has been created."
$nuevoEquipo | Format-List -Property DisplayName, GroupId
}

function Remove-Teams{
Get-Team -User $sUserName | Format-Table -Property DisplayName, GroupId
$eliminarEquipo = Read-Host "Insert you ID of the Team-class you wish remove?"
Remove-Team -GroupId $eliminarEquipo
Write-Host "The team has been removed."
}

function addUser-Teams{
$usuario = Read-Host "Insert email-user to wish add"
Get-Team -User $sUserName | Format-Table -Property DisplayName, GroupId
$id = Read-Host "Insert the ID of the group to wish add him"
Add-TeamUser -GroupId $id -User $usuario -Role Member
Write-Host "The user has been added."
}

function changeImage-Teams{
$id2 = Read-Host "Insert ID of your group team"
$path = Read-Host "Insert the path of the direccion of the image"
Set-TeamPicture -GroupId $id2 -ImagePath $path
Write-Host "The image has been changed."
}

function generateReport-Teams{
$path = Read-Host "Insert the path that you want to save"
$name = Read-Host "Insert the name of the file"
$path2 = $path +  "\" +  $name
New-Item $path2
$info = Get-Team -User $sUserName | Select-Object -Property DisplayName, GroupId, Archived
Set-Content $path2 $info
Write-Host "The Report has been created."
}

$name=Read-Host -Prompt "¿cual es su correo?"
$sMessage=”Type your Office 365 credentials”
$TeamsCredentials=Get-Credential -UserName $name -Message $sMessage
Connect-MicrosoftTeams -Credential $TeamsCredentials
while ( 1 -eq 1){
Write-Host "Opciones [1] Ver Equipos [2] Crear Teams [3]Eliminar Teams [4]Agregar usuario [5]Cambiar imagen de un teams [6]Generar reporte [7]salir"
$a=Read-Host -Prompt "¿Que opcion elige?"
try{
switch($a){
1{
ver-teams
}
2{
 crear-teams
}
3{
eliminar-teams
}
4{
agregar-usuario
}
5{
cambiar-imagen
}
6{
generar-reporte
}
7{
exit
}
}
}catch{
continue
}
}