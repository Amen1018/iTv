//
//  UserLoginViewController.m
//  iTv
//
//  Created by Amen on 16/5/27.
//  Copyright © 2016年 Amen. All rights reserved.
//

#import "UserLoginViewController.h"

@interface UserLoginViewController ()

@end

@implementation UserLoginViewController

@synthesize qqImageView = _qqImageView;
@synthesize weiChatImageView = _weiChatImageView;
@synthesize sinaImageView = _sinaImageView;

@synthesize sinaBtn = _sinaBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeLoginViewClick)];
        self.title = @"登录";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _qqImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qqClieck:)];
    [_qqImageView addGestureRecognizer:singleTap];
    
    [_sinaBtn setImage:[UIImage imageNamed:@"UserCenter_login_sina_enter"] forState:UIControlStateHighlighted];
    
}

-(void)qqClieck:(UITapGestureRecognizer *)send
{
    NSLog(@"send = %@",send);
    _qqImageView.highlighted = YES;
}


#pragma mark CloseView
-(void)closeLoginViewClick
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
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
