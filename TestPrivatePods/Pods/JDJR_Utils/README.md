# JDJR_Utils

> 京东金融 基础工具库，包含有对`Foundation`等框架的扩展和一些基础工具

## 1. CocoaExtension 对 Cocoa 的扩展

### 1. UIDevice

> 对 UIDevice 类的一些扩展，比如 ip 地址 mac 地址等一些公用方法的扩展，一些特殊的扩展会在特定的模块中扩展的，这个基础工具类是大部分都会用到的

```Objective-C
/**
 获取局域网的Ip 地址

 @return 返回局域网ip地址
 */
- (NSString *)jdjr_localIP;

/**
 获取MAC地址

 @return mac地址
 */
- (NSString *)jdjr_getMacAddress;

/**
 获取子网掩码

 @return netmask
 */
-(NSString *)jdjr_getNetmask;

/**
 获取网关地址

 @return 网关地址
 */
- (NSString *)jdjr_getGatewayIPAddress;
```

### 2. NSDate

> 对时间类的一些扩展方法

```Objective-C
/**
 获取当前时间戳

 @return 返回对应时间的时间戳
 */
+ (NSString *)jdjr_currentTimeStr;

/**
 返回时间字符串

 @param format yyyy-MM-dd HH:mm:ss
 @return 返回时间字符串
 */
- (NSString *)jdjr_stringWithFormat:(NSString *)format ;
```
