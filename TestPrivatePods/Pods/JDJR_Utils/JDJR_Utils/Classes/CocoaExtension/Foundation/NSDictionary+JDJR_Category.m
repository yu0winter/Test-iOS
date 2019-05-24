//
//  NSDictionary+JDJR_Category.m
//  JDJR_Utils
//
//  Created by 成勇 on 2018/9/13.
//

#import "NSDictionary+JDJR_Category.h"
#import "NSString+JDJR_Category.h"

@implementation NSDictionary (JDJR_Category)

/**
 👍 安全的获取字典中的value值
 
 @param key 对应的key
 @return 返回value值
 */
- (id)jdjr_safeObjectForKey:(id)key {
    if (key == nil) {
        return nil;
    }
    id value = [self objectForKey:key];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

/**
 👍 返回指定类型的value值
 
 @param key 对应的key
 @param aClass 指定类型
 @return 返回value值
 */
- (id)jdjr_safeObjectForKey:(id)key class:(Class)aClass {
    id value = [self jdjr_safeObjectForKey:key];
    if ([value isKindOfClass:aClass]) {
        return value;
    }
    return nil;
}

/**
 👍 返回字典中bool值
 
 @param key 对应的key
 @return 返回value值
 */
- (bool)jdjr_boolForKey:(id)key {
    id value = [self jdjr_safeObjectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

/**
 👍 返回字典中float值
 
 @param key 对应的key
 @return 返回value值
 */
- (CGFloat)jdjr_floatForKey:(id)key {
    id value = [self jdjr_safeObjectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0;
}

/**
 👍 返回字典中integer值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSInteger)jdjr_integerForKey:(id)key {
    id value = [self jdjr_safeObjectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value integerValue];
    }
    return 0;
}

/**
 👍 返回字典中int值
 
 @param key 对应的key
 @return 返回value值
 */
- (int)jdjr_intForKey:(id)key {
    id value = [self jdjr_safeObjectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

/**
 👍 返回字典中long值
 
 @param key 对应的key
 @return 返回value值
 */
- (long)jdjr_longForKey:(id)key {
    id value = [self jdjr_safeObjectForKey:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longValue];
    }
    return 0;
}

/**
 👍 返回字典中number值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSNumber *)jdjr_numberForKey:(id)key {
    id value = [self jdjr_safeObjectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    if ([value respondsToSelector:@selector(jdjr_numberValue)]) {
        return [value jdjr_numberValue];
    }
    return nil;
}

/**
 👍 返回字典中string值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSString *)jdjr_stringForKey:(id)key {
    id value = [self jdjr_safeObjectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    if ([value respondsToSelector:@selector(stringValue)]) {
        return [value stringValue];
    }
    return nil;
}

/**
 👍 返回字典中dictionary值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSDictionary *)jdjr_dictionaryForKey:(id)key {
    return [self jdjr_safeObjectForKey:key class:[NSDictionary class]];
}

/**
 👍 返回字典中array值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSArray *)jdjr_arrayForKey:(id)key {
    return [self jdjr_safeObjectForKey:key class:[NSArray class]];
}

/**
 👍 返回字典中NSMutableDictionary值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSMutableDictionary *)jdjr_mutableDictionaryForKey:(id)key {
    return [self jdjr_safeObjectForKey:key class:[NSMutableDictionary class]];
}

/**
 👍 返回字典中mutableArray值
 
 @param key 对应的key
 @return 返回value值
 */
- (NSMutableArray *)jdjr_mutableArrayForKey:(id)key {
    return [self jdjr_safeObjectForKey:key class:[NSMutableArray class]];
}

@end

@implementation NSMutableDictionary (JDJR_Category)

/**
 🤝 安全设置字典数据
 
 @param anObject 对应对象
 @param key 对应key
 */
- (void)jdjr_safeSetObject:(id)anObject forKey:(id)key {
    if (key && anObject) {
        [self setObject:anObject forKey:key];
    }
}

/**
 🤝 指定删除对应key的value值
 
 @param key 对应key
 */
- (void)jdjr_safeRemoveObjectForKey:(id)key {
    if (key) {
        [self removeObjectForKey:key];
    }
}

@end
