//
//  iTvNotification.h
//  iTv
//
//  Created by Amen on 16/6/24.
//  Copyright © 2016年 Amen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iTvNotification : NSObject

/**
 *  返回存储状态
 *  如果对象不合法（didReceiveRemoteNotification userInfo对象），则返回NO
 *
 *  @param didReceiveRemoteNotification userInfo对象
 *
 *  @return bool 是否成功存储
 */

+ (BOOL)saveNotification:(NSDictionary *)userInfo;

@end
