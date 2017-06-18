#pragma comment(lib, "crypt32.lib") 
#pragma comment(lib, "advapi32.lib") 
#define _WIN32_WINNT 0x0400 
#include <stdio.h> 
#include <windows.h> 
#include <wincrypt.h> 
#define MY_ENCODING_TYPE  (PKCS_7_ASN_ENCODING | X509_ASN_ENCODING) 
#define KEYLENGTH  0x00800000 
void HandleError(char *s); 
//-------------------------------------------------------------------- 
//  These additional #define statements are required. 
#define ENCRYPT_ALGORITHM CALG_RC4 
#define ENCRYPT_BLOCK_SIZE 8 
//   Declare the function EncryptFile. The function definition 
//   follows main. 
BOOL EncryptFile( 
    PCHAR szSource, 
    PCHAR szDestination, 
    PCHAR szPassword); 
//-------------------------------------------------------------------- 
//   Begin main. 
void main(void) { 
    CHAR szSource[100]; 
    CHAR szDestination[100]; 
    CHAR szPassword[100]; 
    printf("Encrypt a file. \n\n"); 
    printf("Enter the name of the file to be encrypted: "); 
    scanf("%s",szSource); 
    printf("Enter the name of the output file: "); 
    scanf("%s",szDestination); 
    printf("Enter the password:"); 
    scanf("%s",szPassword); 
    //-------------------------------------------------------------------- 
    // Call EncryptFile to do the actual encryption. 
    if(EncryptFile(szSource, szDestination, szPassword)) { 
        printf("Encryption of the file %s was a success. \n", szSource); 
        printf("The encrypted data is in file %s.\n",szDestination); 
    } else { 
        HandleError("Error encrypting file!"); 
    } 
} // End of main 
//-------------------------------------------------------------------- 
//   Code for the function EncryptFile called by main. 
static BOOL EncryptFile( 
    PCHAR szSource, 
    PCHAR szDestination, 
    PCHAR szPassword) 
//-------------------------------------------------------------------- 
//   Parameters passed are: 
//     szSource, the name of the input, a plaintext file. 
//     szDestination, the name of the output, an encrypted file to be 
//         created. 
//     szPassword, the password. 
{ 
    //-------------------------------------------------------------------- 
    //   Declare and initialize local variables. 
    FILE *hSource; 
    FILE *hDestination; 
    HCRYPTPROV hCryptProv; 
    HCRYPTKEY hKey; 
    HCRYPTHASH hHash; 
    PBYTE pbBuffer; 
    DWORD dwBlockLen; 
    DWORD dwBufferLen; 
    DWORD dwCount; 
    //-------------------------------------------------------------------- 
    // Open source file. 
    if(hSource = fopen(szSource,"rb")) { 
        printf("The source plaintext file, %s, is open. \n", szSource); 
    } else { 
        HandleError("Error opening source plaintext file!"); 
    } 
    //-------------------------------------------------------------------- 
    // Open destination file. 
    if(hDestination = fopen(szDestination,"wb")) { 
        printf("Destination file %s is open. \n", szDestination); 
    } else { 
        HandleError("Error opening destination ciphertext file!"); 
    } 
    //���»��һ��CSP��� 
    if(CryptAcquireContext( 
                &hCryptProv, 
                NULL,               //NULL��ʾʹ��Ĭ����Կ������Ĭ����Կ������ 
                //Ϊ�û���½�� 
                NULL, 
                PROV_RSA_FULL, 
                0)) { 
        printf("A cryptographic provider has been acquired. \n"); 
    } else { 
        if(CryptAcquireContext( 
                    &hCryptProv, 
                    NULL, 
                    NULL, 
                    PROV_RSA_FULL, 
                    CRYPT_NEWKEYSET))//������Կ���� 
        { 
            //������Կ�����ɹ������õ�CSP��� 
            printf("A new key container has been created.\n"); 
        } else { 
            HandleError("Could not create a new key container.\n"); 
        } 
    } 
    //-------------------------------------------------------------------- 
    // ����һ���Ự��Կ��session key�� 
    // �Ự��ԿҲ�жԳ���Կ�����ڶԳƼ����㷨�� 
    // ��ע: һ��Session��ָ�ӵ��ú���CryptAcquireContext�����ú��� 
    //   CryptReleaseContext �ڼ�Ľ׶Ρ��Ự��Կֻ�ܴ�����һ���Ự���̣� 
    //-------------------------------------------------------------------- 
    // Create a hash object. 
    if(CryptCreateHash( 
                hCryptProv, 
                CALG_MD5, 
                0, 
                0, 
                &hHash)) { 
        printf("A hash object has been created. \n"); 
    } else { 
        HandleError("Error during CryptCreateHash!\n"); 
    } 
    //-------------------------------------------------------------------- 
    // ��������������һ��ɢ�� 
    if(CryptHashData( 
                hHash, 
                (BYTE *)szPassword, 
                strlen(szPassword), 
                0)) { 
        printf("The password has been added to the hash. \n"); 
    } else { 
        HandleError("Error during CryptHashData. \n"); 
    } 
    //-------------------------------------------------------------------- 
    // ͨ��ɢ�����ɻỰ��Կ 
    if(CryptDeriveKey( 
                hCryptProv, 
                ENCRYPT_ALGORITHM, 
                hHash, 
                KEYLENGTH, 
                &hKey)) { 
        printf("An encryption key is derived from the password hash. \n"); 
    } else { 
        HandleError("Error during CryptDeriveKey!\n"); 
    } 
    //-------------------------------------------------------------------- 
    // Destroy the hash object. 
    CryptDestroyHash(hHash); 
    hHash = NULL; 
    //-------------------------------------------------------------------- 
    //  The session key is now ready. 
    //-------------------------------------------------------------------- 
    // ��Ϊ�����㷨�ǰ�ENCRYPT_BLOCK_SIZE ��С�Ŀ���ܵģ����Ա����ܵ� 
    // ���ݳ��ȱ�����ENCRYPT_BLOCK_SIZE �����������������һ�μ��ܵ� 
    // ���ݳ��ȡ� 
    dwBlockLen = 1000 - 1000 % ENCRYPT_BLOCK_SIZE; 
    //-------------------------------------------------------------------- 
    // Determine the block size. If a block cipher is used, 
    // it must have room for an extra block. 
    if(ENCRYPT_BLOCK_SIZE > 1) 
        dwBufferLen = dwBlockLen + ENCRYPT_BLOCK_SIZE; 
    else
        dwBufferLen = dwBlockLen; 
    //-------------------------------------------------------------------- 
    // Allocate memory. 
    if(pbBuffer = (BYTE *)malloc(dwBufferLen)) { 
        printf("Memory has been allocated for the buffer. \n"); 
    } else { 
        HandleError("Out of memory. \n"); 
    } 
    //-------------------------------------------------------------------- 
    // In a do loop, encrypt the source file and write to the source file. 
    do { 
        //-------------------------------------------------------------------- 
        // Read up to dwBlockLen bytes from the source file. 
        dwCount = fread(pbBuffer, 1, dwBlockLen, hSource); 
        if(ferror(hSource)) { 
            HandleError("Error reading plaintext!\n"); 
        } 
        //-------------------------------------------------------------------- 
        // �������� 
        if(!CryptEncrypt( 
                    hKey,           //��Կ 
                    0,              //�������ͬʱ����ɢ�кͼ��ܣ����ﴫ��һ�� 
                    //ɢ�ж��� 
                    feof(hSource),  //��������һ�������ܵĿ飬����TRUE.���������. 
                    //��FALSE����ͨ���ж��Ƿ��ļ�β�������Ƿ�Ϊ 
                    //���һ�顣 
                    0,              //���� 
                    pbBuffer,       //���뱻�������ݣ�������ܺ������ 
                    &dwCount,       //���뱻��������ʵ�ʳ��ȣ�������ܺ����ݳ��� 
                    dwBufferLen))   //pbBuffer�Ĵ�С�� 
        { 
            HandleError("Error during CryptEncrypt. \n"); 
        } 
        //-------------------------------------------------------------------- 
        // Write data to the destination file. 
        fwrite(pbBuffer, 1, dwCount, hDestination); 
        if(ferror(hDestination)) { 
            HandleError("Error writing ciphertext."); 
        } 
    } while(!feof(hSource)); 
    //-------------------------------------------------------------------- 
    //  End the do loop when the last block of the source file has been 
    //  read, encrypted, and written to the destination file. 
    //-------------------------------------------------------------------- 
    // Close files. 
    if(hSource) 
        fclose(hSource); 
    if(hDestination) 
        fclose(hDestination); 
    //-------------------------------------------------------------------- 
    // Free memory. 
    if(pbBuffer) 
        free(pbBuffer); 
    //-------------------------------------------------------------------- 
    // Destroy session key. 
    if(hKey) 
        CryptDestroyKey(hKey); 
    //-------------------------------------------------------------------- 
    // Destroy hash object. 
    if(hHash) 
        CryptDestroyHash(hHash); 
    //-------------------------------------------------------------------- 
    // Release provider handle. 
    if(hCryptProv) 
        CryptReleaseContext(hCryptProv, 0); 
    return(TRUE); 
} // End of Encryptfile 
//-------------------------------------------------------------------- 
//  This example uses the function HandleError, a simple error 
//  handling function, to print an error message to the standard error 
//  (stderr) file and exit the program. 
//  For most applications, replace this function with one 
//  that does more extensive error reporting. 
void HandleError(char *s) { 
    fprintf(stderr,"An error occurred in running the program. \n"); 
    fprintf(stderr,"%s\n",s); 
    fprintf(stderr, "Error number %x.\n", GetLastError()); 
    fprintf(stderr, "Program terminating. \n"); 
    exit(1); 
} // End of HandleError 

