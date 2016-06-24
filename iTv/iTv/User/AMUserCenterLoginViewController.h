//
//  AMUserCenterLoginViewController.h
//  Anurse
//
//  Created by Amen on 15/5/7.
//  Copyright (c) 2015年 Amen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KPTextField;
@interface AMUserCenterLoginViewController : UIViewController


@property (nonatomic, weak) IBOutlet UIView* phoneContainer;
@property (nonatomic, weak) IBOutlet UIView* codeContainer;


@property (nonatomic, weak) IBOutlet UIButton* codeButton;
@property (nonatomic, weak) IBOutlet UITextField* countryCodeField;
@property (nonatomic, weak) IBOutlet KPTextField* numberField;
@property (strong, nonatomic) IBOutletCollection(KPTextField) NSArray *codeFields;


@property (nonatomic, weak) IBOutlet UILabel* phoneMsgLabel;
@property (nonatomic, weak) IBOutlet UILabel* codeMsgLabel;

@property (nonatomic,weak) IBOutlet UIButton* sinaBtn;
@property (nonatomic,weak) IBOutlet UIButton* weichatBtn;
@property (nonatomic,weak) IBOutlet UIButton* qqBtn;



@end
