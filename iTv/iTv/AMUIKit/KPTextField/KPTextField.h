//
//  KPTextField.h
//  kaopu
//
//  Created by zhilei on 12/3/14.
//  Copyright (c) 2014 baina. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KPTextFormatter;
@interface KPTextField : UITextField

@property (nonatomic, strong) KPTextFormatter* formatter;
@property (nonatomic, assign) IBInspectable BOOL disableMenu;

@end


@protocol KPTextFieldDelegate <UITextFieldDelegate>

@optional
- (void)textFieldWillDelete:(UITextField *)textField;
- (void)textFieldDidDelete:(UITextField *)textField;
- (void)textFieldTextDidChange:(UITextField *)textField;

@end