//
//  MainTabBarViewController.m
//  amen
//
//  Created by Amen on 15/3/25.
//  Copyright (c) 2015年 Amen. All rights reserved.
//

#import "MainTabBarViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //add NavleftBtn
    self.navigationItem.hidesBackButton = YES;
    
    //title
    self.title = NSLocalizedString(@"nurseviewcontrollertitle", nil);
    
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSArray * classNameArray = @[@"AMNewsViewController",@"AMNurseViewController",@"AMMusicViewController",@"UserCenterViewController"];
        NSArray * titleArray = @[@"精选",@"探索",@"活动",@"我"];
        NSArray * imageNameArray  =@[@"TAB_IMAGES_1",@"TAB_IMAGES_2",@"TAB_IMAGES_3",@"TAB_IMAGES_4"];
        
        NSMutableArray * tempArray = [NSMutableArray array];
        for (int i = 0; i < classNameArray.count; i ++) {
            UIViewController * viewController = [[NSClassFromString(classNameArray[i]) alloc]init];
            viewController.hidesBottomBarWhenPushed = NO;
            UINavigationController * nai = [[UINavigationController alloc]initWithRootViewController:viewController];
            UIImage * image = [UIImage imageNamed:imageNameArray[i]];
            UITabBarItem * item = [[UITabBarItem alloc]initWithTitle:titleArray[i] image:image tag:i];
            nai.tabBarItem = item;
            [tempArray addObject:nai];
        }
        self.viewControllers = tempArray;
        
        self.tabBar.translucent = NO;
        if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.) {
            self.tabBar.tintColor = [UIColor redColor];
        }else
        {
            self.tabBar.tintColor = [UIColor redColor];
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
