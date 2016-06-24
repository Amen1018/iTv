//
//  KPTextFormatter.h
//  kaopu
//
//  Created by zhilei on 12/3/14.
//  Copyright (c) 2014 baina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPTextFormatter : NSObject

/**
 *  最大输入位数,默认为0
 */
@property (nonatomic, assign) NSUInteger maxInput;

/**
 *  格式化字符串，移除杂项字符
 *
 *  @param string 输入字符串
 *
 *  @return stripped string
 */
+ (NSString *)stripString:(NSString *)string;

/**
 *  格式化字符串
 *
 *  @param string 待格式化的字符串
 *
 *  @return formated string
 */
+ (NSString *)parseString:(NSString *)string;


- (NSString *)format:(NSString *)string withLocale:(NSLocale *)locale;

@end
