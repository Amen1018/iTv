//
//  UserCenterViewController.m
//  iTv
//
//  Created by Amen on 16/6/12.
//  Copyright © 2016年 Amen. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserLoginViewController.h"
#import "UserCallLogin.h"
@interface UserCenterViewController ()

@end

@implementation UserCenterViewController

@synthesize userTable = _userTable;
@synthesize headView = _headView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addTackView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 添加Head点击事件
-(void)addTackView
{
  
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headTap:)];
    
    _headView.userInteractionEnabled = YES;
    [_headView addGestureRecognizer:tapGesture];
}

#pragma mark HeadView点击事件
-(void)headTap:(UITapGestureRecognizer *)tapGesture
{
    
    [UserCallLogin callUserLogin:self];
}

/*
 添加UITableView
 */

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 180;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
//    UserCenterHeadTableViewCell *headerViewH = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UserTableHeadLogin"];
    
//    UserCenterHeadTableViewCell *headCell = [[UserCenterHeadTableViewCell alloc] init];
    
    
    return _headView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* ListIdentifier = @"ListIdentifier1";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ListIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ListIdentifier] ;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor colorWithRed:80/255.0f green:80/255.0f blue:80/255.0f alpha:1.0f ];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        
        
    }
    
    cell.textLabel.text = @"AA";
    
    return cell;
}
@end
