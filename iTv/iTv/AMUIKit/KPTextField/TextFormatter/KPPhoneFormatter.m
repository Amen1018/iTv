//
//  KPPhoneFormatter.m
//  kaopu
//
//  Created by zhilei on 12/3/14.
//  Copyright (c) 2014 baina. All rights reserved.
//

#import "KPPhoneFormatter.h"



@implementation KPPhoneFormatter

- (id)init
{
    self = [super init];
    if (self) {
        
        self.maxInput = kDefaultFormatter.length;
    }
    
    return self;
}


+ (NSString *)parseString:(NSString *)string
{
    NSArray* componets = [kDefaultFormatter componentsSeparatedByString:@"-"];
    __block NSUInteger validateLen = 0;
    [componets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString* subStrs = obj;
        validateLen += subStrs.length;
    }];
    
    if (string.length < validateLen) {
        validateLen = string.length;
    }
    string = [string substringWithRange:NSMakeRange(0, validateLen)];
    
    NSMutableString* results = [NSMutableString stringWithString:string];
    
    NSUInteger appendedLoc = 0;
    
    for (NSUInteger i = 0; i < componets.count; i++)
    {
        NSString* subStrs = componets[i];
        appendedLoc += subStrs.length;
        
        if (appendedLoc >= string.length)
            break;
        
        [results insertString:@"-" atIndex:appendedLoc + i];
    }
    
    return results;
}

@end
