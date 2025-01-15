# Create an SSL certificate with the Trusted root CA and code signing
# This script creates an SSL certificate and imports it into the appropriate certificate stores.

# Variables
$CN = "HimuAiDev"
$IssuedTo = "FA-Nirob"
$Password = "Firuj@shd0003!"
$OutputPath = "A:\Codes\Test_Codes\"

# Ensure the output directory exists
if (-Not (Test-Path -Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath
}

# Create root certificate authority
$rootCAFilePath = $OutputPath + "HimuAiDev.cer"
$Subject = "CN=" + $CN
$rootCA = New-SelfSignedCertificate -certstorelocation cert:\currentuser\my -Subject $Subject -HashAlgorithm "SHA512" -KeyUsage CertSign, CRLSign
Export-Certificate -Cert $rootCA -FilePath $rootCAFilePath

# Import the root CA certificate into the Trusted Root Certification Authorities store
Import-Certificate -FilePath $rootCAFilePath -CertStoreLocation Cert:\LocalMachine\Root

# Import the root CA certificate into the Current User's My store
$rootCA = Import-Certificate -FilePath $rootCAFilePath -CertStoreLocation Cert:\CurrentUser\My

# Create Trusted SSL cert signed + code-signing certificate by certificate authority
$IssuedToClean = $IssuedTo.Replace(":", "-").Replace(" ", "_")
$sslCertFilePath = $OutputPath + $IssuedToClean + ".pfx"
$Subject = "CN=" + $IssuedTo
$sslCert = New-SelfSignedCertificate -Subject $Subject -Signer $rootCA `
    -KeyUsage KeyEncipherment, DigitalSignature `
    -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2,1.3.6.1.5.5.7.3.1,1.3.6.1.5.5.7.3.3,1.3.6.1.5.5.7.3.4,1.3.6.1.5.5.7.3.8,1.3.6.1.5.5.7.3.9,1.3.6.1.5.5.7.3.5,1.3.6.1.4.1.311.10.3.12,1.3.6.1.4.1.311.10.3.4,1.3.6.1.4.1.311.10.3.3,1.3.6.1.4.1.311.10.3.1,1.3.6.1.5.5.7.3.3,1.3.6.1.4.1.311.10.3.11,1.3.6.1.5.5.7.3.3") `
    -HashAlgorithm "SHA256" -KeyLength 4096 -NotAfter (Get-Date).AddYears(16)

# Export the SSL certificate
Export-PfxCertificate -Cert $sslCert -FilePath $sslCertFilePath `
    -Password (ConvertTo-SecureString -String $Password -Force -AsPlainText)

# Import the SSL cert signed + code-signing certificate by certificate authority
Import-PfxCertificate -FilePath $sslCertFilePath -CertStoreLocation Cert:\LocalMachine\My `
    -Password (ConvertTo-SecureString -String $Password -Force -AsPlainText)

# Restart the web management service
$service = Get-Service -Name webmanagement -ErrorAction SilentlyContinue
if ($service -and $service.Status -eq 'Running') {
    Stop-Service -Name webmanagement
    Start-Service -Name webmanagement
}
elseif ($service -and $service.Status -eq 'Stopped') {
    Start-Service -Name webmanagement
}
else {
    Write-Host "Web management service not found."
}

Write-Host "Root CA and SSL certificate creation complete. Certificates have been provisioned to the Windows Device Portal."

# Digitally sign code
$signtoolPath = "signtool.exe"

# Path to the file to be signed
$fileToSign = "A:\Codes\Test_Codes\test.exe"

# Path to the certificate
$certificatePath = "A:\Codes\Test_Codes\HimuAiDev.pfx"

# Certificate password
$certificatePassword = "Firuj@shd0003!"

# Sign the file
& $signtoolPath sign /f $certificatePath /p $certificatePassword /fd SHA256 /tr http://timestamp.digicert.com /td SHA256 $fileToSign

Write-Host "Code signing complete."

# Automate certificate validation.
$executablePath = "A:\Codes\Test_Codes\test.exe"
$signature = Get-AuthenticodeSignature -FilePath $executablePath

if ($signature.Status -eq "Valid") {
    Write-Host "Certificate is valid."
    exit 0
}
else {
    Write-Host "Certificate verification failed. Status: $($signature.Status)"
    exit 1
}
