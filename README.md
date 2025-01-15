# Create-SSL-certificate-with-the-Trusted-root-CA
# Create an SSL certificate with the Trusted root CA and code signing # This script creates an SSL certificate and imports it into the appropriate certificate stores.
# Create an SSL certificate with the Trusted root CA and code signing

# specified certificate properties : {Document Signing, Encrypting File System, Time Stamping, Secure Email, Code Signing, Client Authentication, Server Authentication}

## To ensure that the root CA certificate is trusted, code signing Certification is trusted you need to import it into the Trusted Root Certification Authorities store. Here is the updated script that includes this step

./"Create SSL With root CA.ps1"

like this
Version : 3
Valid from : 2 February 2016 23:39:39
Valid : 12 February 2041 23:39:39
PublicKey : RSA (4096 Bits) here
RawData : {48, 130, 3, 25...}
SerialNumber :
Subject :
Subject key identifier :
Authority Key Identifier.:
X500DistinguishedName....:
Basic Constraints........: Subject Type=CA Path Length Constraint=None
SignatureAlgorithm : sha256RSA
Signature hash Algorithm : sha256
Key Usage ... : Digital Signature, Certificate Signing, Off-line CRL Signing, CRL Signing (86)
Thumbprint :
Handle :
Issuer :
Subject :
Friendly name :
Public key parameters : 05 00
EnhancedKeyUsage properties...:

- Client Authentication
- Code Signing
- Document Signing
- Encrypting File System
- Secure Email
- OCSP Signing
- Server Authentication
- Time Stamping
  Extended Validation ...:
- [1] Certificate Policy:
  - Policy Identifier=1.3.6.1.4.1.4146.1.1
  - [1,1] Policy Qualifier Info:
    - Policy Qualifier Id=Root Program Flags
    - Qualifier: c0
- [2] Certificate Policy:
  - Policy Identifier=1.3.6.1.4.1.4146.1.2
  - [2,1] Policy Qualifier Info:
    - Policy Qualifier Id=Root Program Flags
    - Qualifier: c0
- [3] Certificate Policy:
  - Policy Identifier=2.23.140.1.1
  - [3,1] Policy Qualifier Info:
    - Policy Qualifier Id=Root Program Flags
    - Qualifier: c0
- [4] Certificate Policy:
  - Policy Identifier=2.23.140.1.3
  - [4,1] Policy Qualifier Info:
    - Policy Qualifier Id=Root Program Flags
    - Qualifier: c0

@fix Unauthenticated attributes and Details

This certificate is not valid for the selected purpose.

Issued to: HimuAiDev

Issued by: HimuAiDev

Valid from 15-01-2025 to 15-01-2041

Digital Signature Details

General

?

×

Advanced

Digital Signature Information
The certificate is not valid for the requested usage.

Signer information

Name:

Email:

Signing time:

HimuAiDev

Not available

15 January 2025 05:19:26

View Certificate

Countersignatures

Name of signer:

DigiCert Timesta ... Not available

Email address:

Timestamp

15 January 2025 05 :...

Details
