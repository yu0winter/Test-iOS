//
//  NSDictionary+JDJR_Category.h
//  JDJR_Utils
//
//  Created by 成勇 on 2018/9/13.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JDJR_Category)

/**
 🤝 安全的获取字典中的value值
 
 @param key 对应的key
 @return 返回value值
 */
- (id)jdjr_safeObjectForKey:(id)key;

/**
 🤝 返回指定类型的value值
 
 @param key 对应的key
 @param aClass 指定类型
 @return 返回value值
 */
- (id)jdjr_safeObjectForKey:(id)key class:(Class)aClass;

/**
 🤝 返回字典中bool值
 
 @param key 对应的key
 @return 返回value值
 */
- (bool)jdjr_boolForKey:(id)key;

/**
 🤝 返回字典中float值
 
 @param key 对应的key
 @return 返回value值
 */
- (CGFloat)jdjr_floatForKey:(id)key;

/**
 🤝 返回字典中integer值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSInteger)jdjr_integerForKey:(id)key;

/**
 👍 返回字典中int值
 
 @param key 对应的key
 @return 返回value值
 */
- (int)jdjr_intForKey:(id)key;

/**
 🤝 返回字典中long值
 
 @param key 对应的key
 @return 返回value值
 */
- (long)jdjr_longForKey:(id)key;

/**
 🤝 返回字典中number值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSNumber *)jdjr_numberForKey:(id)key;

/**
 🤝 返回字典中string值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSString *)jdjr_stringForKey:(id)key;

/**
 🤝 返回字典中dictionary值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSDictionary *)jdjr_dictionaryForKey:(id)key;

/**
 🤝 返回字典中array值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSArray *)jdjr_arrayForKey:(id)key;

/**
 🤝 返回字典中NSMutableDictionary值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSMutableDictionary *)jdjr_mutableDictionaryForKey:(id)key;

/**
 🤝 返回字典中mutableArray值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSMutableArray *)jdjr_mutableArrayForKey:(id)key;

@end

@interface NSMutableDictionary (JDJR_Category)

/**
 🤝 安全设置字典数据
 
 @param anObject 对应对象
 @param key 对应key
 */
- (void)jdjr_safeSetObject:(id)anObject forKey:(id)key;

/**
 🤝 指定删除对应key的value值
 
 @param key 对应key
 */
- (void)jdjr_safeRemoveObjectForKey:(id)key;

@end
