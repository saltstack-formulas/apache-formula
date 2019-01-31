# Hardening list

This formula enforce security recommandations from [CIS Benchmarks](https://www.cisecurity.org/cis-benchmarks/) site

From ***CIS_Apache_HTTP_Server_2.4_Benchmark_v1.4.pdf*** document

## List of items managed in this formula with their references

## 2. Minimize Apache Modules
- [ ] 2.1 Enable Only Necessary Authentication and Authorization Modules (Not Scored)
- [X] 2.2 Enable the Log Config Module (**Scored**)
- [X] 2.3 Disable WebDAV Modules (**Scored**)
- [X] 2.4 Disable Status Module (**Scored**)
- [X] 2.5 Disable Autoindex Module (**Scored**)
- [ ] 2.6 Disable Proxy Modules (**Scored**)
- [X] 2.7 Disable User Directories Modules (**Scored**)
- [X] 2.8 Disable Info Module (**Scored**)
## 3. Principles, Permissions, and Ownership
- [X] 3.1 Run the Apache Web Server as a non-root user (**Scored**)
- [X] 3.2 Give the Apache User Account an Invalid Shell (**Scored**)
- [ ] 3.3 Lock the Apache User Account (**Scored**)
- [X] 3.4 Set Ownership on Apache Directories and Files (**Scored**)
- [ ] 3.5 Set Group Id on Apache Directories and Files (**Scored**)
- [ ] 3.6 Restrict Other Write Access on Apache Directories and Files (**Scored**)
- [X] 3.7 Secure Core Dump Directory (**Scored**)
- [ ] 3.8 Secure the Lock File (**Scored**)
- [X] 3.9 Secure the Pid File (**Scored**)
- [X] 3.10 Secure the ScoreBoard File (**Scored**)
- [X] 3.11 Restrict Group Write Access for the Apache Directories and Files (**Scored**)
- [X] 3.12 Restrict Group Write Access for the Document Root Directories and Files (**Scored**)
## 4. Apache Access Control
- [X] 4.1 Deny Access to OS Root Directory (**Scored**)
- [ ] 4.2 Allow Appropriate Access to Web Content (Not Scored)
- [X] 4.3 Restrict Override for the OS Root Directory (**Scored**)
- [X] 4.4 Restrict Override for All Directories (**Scored**)
## 5. Minimize Features, Content and Options
- [X] 5.1 Restrict Options for the OS Root Directory (**Scored**)
- [X] 5.2 Restrict Options for the Web Root Directory (**Scored**)
- [X] 5.3 Minimize Options for Other Directories (**Scored**)
- [X] 5.4 Remove Default HTML Content (**Scored**)
- [X] 5.5 Remove Default CGI Content printenv (**Scored**)
- [X] 5.6 Remove Default CGI Content test-cgi (**Scored**)
- [X] 5.7 Limit HTTP Request Methods (**Scored**)
- [X] 5.8 Disable HTTP TRACE Method (**Scored**)
- [X] 5.9 Restrict HTTP Protocol Versions (**Scored**)
- [X] 5.10 Restrict Access to .ht* files (**Scored**)
- [ ] 5.11 Restrict File Extensions (**Scored**)
- [ ] 5.12 Deny IP Address Based Requests (**Scored**)
- [ ] 5.13 Restrict Listen Directive (**Scored**)
- [ ] 5.14 Restrict Browser Frame Options (**Scored**)
## 6. Operations - Logging, Monitoring and Maintenance
- [X] 6.1 Configure the Error Log (**Scored**)
- [ ] 6.2 Configure a Syslog Facility for Error Logging (**Scored**)
- [X] 6.3 Configure the Access Log (**Scored**)
- [X] 6.4 Log Storage and Rotation (**Scored**)
- [ ] 6.5 Apply Applicable Patches (**Scored**)
- [ ] 6.6 Install and Enable ModSecurity (**Scored**)
- [ ] 6.7 Install and Enable OWASP ModSecurity Core Rule Set (**Scored**)
## 7. SSL/TLS Configuration
- [ ] 7.1 Install mod_ssl and/or mod_nss (**Scored**)
- [ ] 7.2 Install a Valid Trusted Certificate (**Scored**)
- [ ] 7.3 Protect the Server's Private Key (**Scored**)
- [X] 7.4 Disable the SSL v3.0 Protocol (**Scored**)
- [ ] 7.5 Restrict Weak SSL/TLS Ciphers (**Scored**)
- [X] 7.6 Disable SSL Insecure Renegotiation (**Scored**)
- [X] 7.7 Ensure SSL Compression is not Enabled (**Scored**)
- [ ] 7.8 Restrict Medium Strength SSL/TLS Ciphers (**Scored**)
- [ ] 7.9 Disable the TLS v1.0 Protocol (**Scored**)
- [ ] 7.10 Enable OCSP Stapling (**Scored**)
- [ ] 7.11 Enable HTTP Strict Transport Security (**Scored**)
## 8. Information Leakage
- [X] 8.1 Set ServerToken to 'Prod' (**Scored**)
- [X] 8.2 Set ServerSignature to 'Off' (**Scored**)
- [ ] 8.3 Information Leakage via Default Apache Content (**Scored**)
- [ ] 8.4 Information Leakage via ETag (**Scored**)
## 9. Denial of Service Mitigations
- [X] 9.1 Set TimeOut to 10 or less (**Scored**)
- [X] 9.2 Set the KeepAlive directive to On (**Scored**)
- [X] 9.3 Set MaxKeepAliveRequests to 100 or greater (**Scored**)
- [X] 9.4 Set KeepAliveTimeout Low to Mitigate Denial of Service (**Scored**)
- [X] 9.5 Set Timeout Limits for Request Headers (**Scored**)
- [X] 9.6 Set Timeout Limits for the Request Body (**Scored**)
## 10. Request Limits
- [ ] 10.1 Set the LimitRequestLine directive to 512 or less (**Scored**)
- [ ] 10.2 Set the LimitRequestFields directive to 100 or less (**Scored**)
- [ ] 10.3 Set the LimitRequestFieldsize directive to 1024 or less (**Scored**)
- [ ] 10.4 Set the LimitRequestBody directive to 102400 or less (**Scored**)
## 11. Enable SELinux to Restrict Apache Processes
- [ ] 11.1 Enable SELinux in Enforcing Mode (**Scored**)
- [ ] 11.2 Run Apache Processes in the httpd_t Confined Context (**Scored**)
- [ ] 11.3 Ensure the httpd_t Type is Not in Permissive Mode (**Scored**)
- [ ] 11.4 Ensure Only the Necessary SELinux Booleans are Enabled (Not Scored)
## 12. Enable AppArmor to Restrict Apache Processes
- [ ] 12.1 Enable the AppArmor Framework (**Scored**)
- [ ] 12.2 Customize the Apache AppArmor Profile (Not Scored)
- [ ] 12.3 Ensure Apache AppArmor Profile is in Enforce Mode (**Scored**)
