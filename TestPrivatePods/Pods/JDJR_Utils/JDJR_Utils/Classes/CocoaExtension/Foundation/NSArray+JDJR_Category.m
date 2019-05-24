//
//  NSArray+JDJR_Category.m
//  JDJR_Utils
//
//  Created by 成勇 on 2018/9/13.
//

#import "NSArray+JDJR_Category.h"
#import "NSString+JDJR_Category.h"

@implementation NSArray (JDJR_Category)

/**
 👍 取出指定位置元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (id)jdjr_safeObjectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

/**
 👍 取出指定位置元素 指定类型
 
 @param index 数组index位置
 @return 返回元素
 */
- (id)jdjr_safeObjectAtIndex:(NSUInteger)index class:(Class)aClass {
    id value = [self jdjr_safeObjectAtIndex:index];
    if ([value isKindOfClass:aClass]) {
        return value;
    }
    return nil;
}

/**
 👍 取出指定位置bool类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (bool)jdjr_boolAtIndex:(NSUInteger)index {
    id value = [self jdjr_safeObjectAtIndex:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    return NO;
}

/**
 👍 取出指定位置CGFloat类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (CGFloat)jdjr_floatAtIndex:(NSUInteger)index {
    id value = [self jdjr_safeObjectAtIndex:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value floatValue];
    }
    return 0;
}

/**
 👍 取出指定位置NSUInteger类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSInteger)jdjr_integerAtIndex:(NSUInteger)index {
    id value = [self jdjr_safeObjectAtIndex:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value integerValue];
    }
    return 0;
}

/**
 👍 取出指定位置int类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (int)jdjr_intAtIndex:(NSUInteger)index {
    id value = [self jdjr_safeObjectAtIndex:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    return 0;
}

/**
 👍 取出指定位置long类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (long)jdjr_longAtIndex:(NSUInteger)index {
    id value = [self jdjr_safeObjectAtIndex:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longValue];
    }
    return 0;
}

/**
 👍 取出指定位置NSNumber类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSNumber *)jdjr_numberAtIndex:(NSUInteger)index {
    id value = [self jdjr_safeObjectAtIndex:index];
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    if ([value respondsToSelector:@selector(jdjr_numberValue)]) {
        return [value jdjr_numberValue];
    }
    return nil;
}

/**
 👍 取出指定位置NSString类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSString *)jdjr_stringAtIndex:(NSUInteger)index {
    id value = [self jdjr_safeObjectAtIndex:index];
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    if ([value respondsToSelector:@selector(stringValue)]) {
        return [value stringValue];
    }
    return nil;
}

/**
 👍 取出指定位置NSDictionary类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSArray *)jdjr_arrayAtIndex:(NSUInteger)index {
    return [self jdjr_safeObjectAtIndex:index class:[NSArray class]];
}

/**
 👍 取出指定位置NSArray类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSDictionary *)jdjr_dictionaryAtIndex:(NSUInteger)index {
    return [self jdjr_safeObjectAtIndex:index class:[NSDictionary class]];
}

/**
 👍 取出指定位置NSMutableDictionary类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSMutableArray *)jdjr_mutableArrayAtIndex:(NSUInteger)index {
    return [self jdjr_safeObjectAtIndex:index class:[NSMutableArray class]];
}

/**
 👍 取出指定位置NSMutableArray类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSMutableDictionary *)jdjr_mutableDictionaryAtIndex:(NSUInteger)index {
    return [self jdjr_safeObjectAtIndex:index class:[NSMutableDictionary class]];
}

@end

@implementation NSMutableArray (JDJR_Category)

/**
 👍 数组添加对象
 
 @param anObject 对象
 */
- (void)jdjr_safeAddObject:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
    }
}

/**
 👍 指定位置插入对象
 
 @param anObject 对象
 @param index 指定位置
 */
- (void)jdjr_safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject && index <= self.count) {
        [self insertObject:anObject atIndex:index];
    }
}

/**
 👍 替换指定位置元素
 
 @param index 指定位置
 @param anObject 替换对象
 */
- (void)jdjr_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (anObject && index < self.count) {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
}

/**
 👍 删除指定位置对象
 
 @param index 指定位置
 */
- (void)jdjr_safeRemoveObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

/**
 👍 删除指定对象
 
 @param anObject 指定对象
 */
- (void)jdjr_safeRemoveObject:(id)anObject {
    if (anObject != nil) {
        [self removeObject:anObject];
    }
}

@end
