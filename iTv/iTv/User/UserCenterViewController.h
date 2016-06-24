//
//  UserCenterViewController.h
//  iTv
//
//  Created by Amen on 16/6/12.
//  Copyright © 2016年 Amen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)IBOutlet UITableView *userTable;

@property (nonatomic,weak)IBOutlet UIView *headView;

@end
