//
//  KPBankFormatter.m
//  kaopu
//
//  Created by zhilei on 3/3/15.
//  Copyright (c) 2015 baina. All rights reserved.
//

#import "KPBankFormatter.h"

@implementation KPBankFormatter



+ (NSString *)parseString:(NSString *)string
{
    if (string.length == 0)
        return string;
    
    
    NSMutableString* results = [NSMutableString stringWithString:string];

    NSInteger pivot = 4;
    NSUInteger seperatorCount = (string.length - 1) / pivot;

    for (NSUInteger i = 0; i < seperatorCount; i++) {
        [results insertString:@" " atIndex:i * pivot + i + pivot];
    }
    
    return results;
}


@end
