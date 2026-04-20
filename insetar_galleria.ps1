$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

Write-Verbose "Comprobando permisos de administrador."

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "No tienes permisos de administrador.`nPor favor, ejecuta este script como Administrador."
    Break
}

Write-Verbose "Borrando antiguas configuraciones."

Try
{
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\" -Name "GalleryLocations"
    Write-Verbose "Borradas las antiguas galerias."
}
Catch
{
    Write-Verbose "No se encontraron antiguas galerias para borrar."
}

Write-Verbose "Añadiendo nueva configuracion."

$newValue = New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\"  `
    -Name 'GalleryLocations' -PropertyType MultiString -Value (
    'https://go.microsoft.com/fwlink/?linkid=851584',
    'https://raw.githubusercontent.com/Josegorn/GaleriaHyperV/refs/heads/main/galeria.json'
    )
$newValue.multistring

$newValue.multistring

Write-Verbose "Configuracion añadida."