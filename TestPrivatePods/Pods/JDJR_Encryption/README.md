# JDJR_Encryption

> 京东金融 加密工具库

## 1. AES 加密

> 对称加密算法

```Objective-C
/**
 aes加密字符串

 @param jsonData 需要加密的Json字符串
 @param key 加密使用的key
 @param iv 使用CBC模式，需要一个向量iv，可增加加密算法的强度
 @return 加密后的字符串
 */

+(NSString*)AES128EncryptJsonData:(NSString*)jsonData Key:(NSString *)key iv:(NSString *)iv;


/**
 aes解密

 @param strData 需要解密的字符串
 @param key 加密使用的key
 @param iv 使用CBC模式，需要一个向量iv，可增加加密算法的强度
 @return 解密后的字符串
 */
+(NSString*)AES128DecryptStrData:(NSString*)strData Key:(NSString *)key iv:(NSString *)iv;
```

## 2. RSA 加密

> 非对称加密算法

```Objective-C
/**
 *  加密方法
 *
 *  @param str   需要加密的字符串
 *  @param path  '.der'格式的公钥文件路径
 */
+ (NSString *)encryptString:(NSString *)str publicKeyWithContentsOfFile:(NSString *)path;

/**
 *  解密方法
 *
 *  @param str       需要解密的字符串
 *  @param path      '.p12'格式的私钥文件路径
 *  @param password  私钥文件密码
 */
+ (NSString *)decryptString:(NSString *)str privateKeyWithContentsOfFile:(NSString *)path password:(NSString *)password;

/**
 *  加密方法
 *
 *  @param str    需要加密的字符串
 *  @param pubKey 公钥字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/**
 *  解密方法
 *
 *  @param str     需要解密的字符串
 *  @param privKey 私钥字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
```
