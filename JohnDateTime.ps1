Write-Host "[INSTRUCCIONES]"
Write-Host "--------------------------------------------------------------------------------------------"
Write-Host "1.- Recomendacion: Descomprime Jhon the Ripper en la misma carpeta que este script."
Write-Host "2.- Directorio de ejecucion: john*.*\run"
Write-Host "3.- Preferentemente añade las ubicaciones de archivos y directorios sin espacios para un mejor funcionamiento."
Write-Host "--------------------------------------------------------------------------------------------"

$archivoHashes = Read-Host "Introduce la ubicacion del listado de hashes (Sha1Passwords.txt)"
$archivoDestino = Read-Host "Introduce la ubicacion del archivo destino de contraseñas crackeadas"
$directorioJohn = Read-Host "Introduce la ubicacion del directorio de John the Ripper"
$archivoTemp = Join-Path -Path $PWD -ChildPath "\temp.txt"
$contenido = ""
$contenido | Out-File -FilePath $archivoTemp

$fechaInicioScript = Get-Date
Write-Host "--------------------------------------------------------------------------------------------"
$fechaInicioScriptString = $fechaInicioScript.ToString("yyyy-MM-dd HH:mm:ss")
"Inicio del script: $fechaInicioScriptString" | Out-File -Append -Encoding utf8 $archivoDestino
$fechaInicioIteracion = $null
$contrasenas = Get-Content $archivoHashes
foreach ($contrasena in $contrasenas) {
    $fechaInicioIteracion = Get-Date
    $fechaInicioIteracionString = $fechaInicioIteracion.ToString("yyyy-MM-dd HH:mm:ss")
    "Inicio de iteración: $fechaInicioIteracionString" | Out-File -Append -Encoding utf8 $archivoDestino
    $contrasena | Out-File -FilePath "$archivoTemp" -Encoding utf8
    $Comando = "cd '$directorioJohn'; ./john --format=raw-sha1 --pot='$archivoDestino' '$archivoTemp'"	
    Invoke-Expression -Command $Comando
    $fechaFinIteracion = Get-Date
    $fechaFinIteracionString = $fechaFinIteracion.ToString("yyyy-MM-dd HH:mm:ss")
    "Fin de iteración: $fechaFinIteracionString" | Out-File -Append -Encoding utf8 $archivoDestino
}
$fechaFinScript = Get-Date
$fechaFinScriptString = $fechaFinScript.ToString("yyyy-MM-dd HH:mm:ss")
"Fin del script: $fechaFinScriptString" | Out-File -Append -Encoding utf8 $archivoDestino
Remove-Item $archivoTemp

Read-Host
