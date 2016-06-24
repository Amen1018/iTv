//
//  AMNewsDetailedViewController.m
//  iTv
//
//  Created by Amen on 16/5/26.
//  Copyright © 2016年 Amen. All rights reserved.
//

#import "AMNewsDetailedViewController.h"

@interface AMNewsDetailedViewController ()

@end

@implementation AMNewsDetailedViewController

@synthesize detailedDict = _detailedDict;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"detailedDict = %@",_detailedDict);
    

    
}


#pragma mark TOWebView
- (void)addWebView
{
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
