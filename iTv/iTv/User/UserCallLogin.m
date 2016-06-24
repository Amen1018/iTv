//
//  UserCallLogin.m
//  iTv
//
//  Created by Amen on 16/6/16.
//  Copyright © 2016年 Amen. All rights reserved.
//

#import "UserCallLogin.h"
#import "AMUserCenterLoginViewController.h"
#import "UserLoginViewController.h"

@implementation UserCallLogin

+(void)callUserLogin:(id)selfView
{
    AMUserCenterLoginViewController *uLogin = [[AMUserCenterLoginViewController alloc] init];
    UINavigationController *UserNav = [[UINavigationController alloc]initWithRootViewController:uLogin];
    [UserNav setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [selfView presentViewController:UserNav animated:YES completion:NULL];
}

@end
