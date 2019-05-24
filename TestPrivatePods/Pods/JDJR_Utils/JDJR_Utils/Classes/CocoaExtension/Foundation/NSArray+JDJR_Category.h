//
//  NSArray+JDJR_Category.h
//  JDJR_Utils
//
//  Created by 成勇 on 2018/9/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSArray (JDJR_Category)

/**
 👍 取出指定位置元素

 @param index 数组index位置
 @return 返回元素
 */
- (id)jdjr_safeObjectAtIndex:(NSUInteger)index;

/**
 👍 取出指定位置元素 指定类型
 
 @param index 数组index位置
 @return 返回元素
 */
- (id)jdjr_safeObjectAtIndex:(NSUInteger)index class:(Class)aClass;

/**
 👍 取出指定位置bool类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (bool)jdjr_boolAtIndex:(NSUInteger)index;

/**
 👍 取出指定位置CGFloat类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (CGFloat)jdjr_floatAtIndex:(NSUInteger)index;

/**
 👍 取出指定位置NSUInteger类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSInteger)jdjr_integerAtIndex:(NSUInteger)index;

/**
 👍 取出指定位置int类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (int)jdjr_intAtIndex:(NSUInteger)index;

/**
 👍 取出指定位置long类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (long)jdjr_longAtIndex:(NSUInteger)index;

/**
 👍 取出指定位置NSNumber类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSNumber *)jdjr_numberAtIndex:(NSUInteger)index;

/**
 👍 取出指定位置NSString类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSString *)jdjr_stringAtIndex:(NSUInteger)index;

/**
 👍 取出指定位置NSDictionary类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSDictionary *)jdjr_dictionaryAtIndex:(NSUInteger)index;

/**
 👍 取出指定位置NSArray类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSArray *)jdjr_arrayAtIndex:(NSUInteger)index;

/**
 👍 取出指定位置NSMutableDictionary类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSMutableDictionary *)jdjr_mutableDictionaryAtIndex:(NSUInteger)index;

/**
 👍 取出指定位置NSMutableArray类型元素
 
 @param index 数组index位置
 @return 返回元素
 */
- (NSMutableArray *)jdjr_mutableArrayAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (JDJR_Category)

/**
 👍 数组添加对象
 
 @param anObject 对象
 */
- (void)jdjr_safeAddObject:(id)anObject;

/**
 👍 指定位置插入对象

 @param anObject 对象
 @param index 指定位置
 */
- (void)jdjr_safeInsertObject:(id)anObject atIndex:(NSUInteger)index;

/**
 👍 替换指定位置元素

 @param index 指定位置
 @param anObject 替换对象
 */
- (void)jdjr_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

/**
 👍 删除指定位置对象

 @param index 指定位置
 */
- (void)jdjr_safeRemoveObjectAtIndex:(NSUInteger)index;

/**
 👍 删除指定对象

 @param anObject 指定对象
 */
- (void)jdjr_safeRemoveObject:(id)anObject;

@end
