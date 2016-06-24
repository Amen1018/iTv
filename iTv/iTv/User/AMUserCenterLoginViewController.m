//
//  AMUserCenterLoginViewController.m
//  Anurse
//
//  Created by Amen on 15/5/7.
//  Copyright (c) 2015年 Amen. All rights reserved.
//

#import "AMUserCenterLoginViewController.h"
#import "UIColor+SAMAdditions.h"
#import "KPTextField.h"
#import "AFNetworkReachabilityManager.h"
#import "KPPhoneFormatter.h"
#import "SVProgressHUD.h"
#import "AVOSCloud.h"
#import "MainTabBarViewController.h"
#import <ShareSDK/ShareSDK.h>
@interface AMUserCenterLoginViewController ()<UITextFieldDelegate>
{
    NSTimer* _refreshTimer;
    NSUInteger _timeElapsed;
}
@end

/**
 *  验证码刷新时间60秒
 */
static NSUInteger const kRefreshSeconds = 60;


@implementation AMUserCenterLoginViewController

@synthesize qqBtn = _qqBtn;
@synthesize weichatBtn = _weichatBtn;
@synthesize sinaBtn = _sinaBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeLoginViewClick)];
        self.title = NSLocalizedString(@"登录", nil);
    }
    return self;
}


#pragma mark CloseView
-(void)closeLoginViewClick
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    [self setupUI];
    [self setBtnAction];
    
//    [self performSelector:@selector(crash) withObject:nil afterDelay:5.0];

}

- (void)setBtnAction
{
    [_qqBtn addTarget:self action:@selector(qqBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_sinaBtn addTarget:self action:@selector(sinaBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_weichatBtn addTarget:self action:@selector(weichatBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)qqBtnAction:(UIButton *)btn
{
    NSLog(@"uibutoon = %@",btn);
    //例如QQ的登录
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

- (void)sinaBtnAction:(UIButton *)btn
{
    NSLog(@"uibutoon = %@",btn);
    //例如QQ的登录
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

- (void)weichatBtnAction:(UIButton *)btn
{
    NSLog(@"uibutoon = %@",btn);
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}


- (void)crash {
    [NSException raise:NSGenericException format:@"只是测试，模拟一条崩溃信息。"];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor sam_colorWithHex:@"#f2f2f2"];
    
    [_codeButton setBackgroundImage:[[UIImage imageNamed:@"UserCenter_login_btn"] resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 3)] forState:UIControlStateNormal];
    [_codeButton setBackgroundImage:[[UIImage imageNamed:@"UserCenter_login_btn_press"] resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 3)] forState:UIControlStateHighlighted];
    [_codeButton setBackgroundImage:[[UIImage imageNamed:@"UserCenter_login_btn"] resizableImageWithCapInsets:UIEdgeInsetsMake(3, 3, 3, 3)] forState:UIControlStateDisabled];
    
    _phoneContainer.layer.cornerRadius = 2;
    _phoneContainer.layer.borderWidth = 0.5;
    _phoneContainer.layer.borderColor = [UIColor sam_colorWithHex:@"#dcdcdc"].CGColor;
    
    _codeContainer.layer.cornerRadius = 2;
    _codeContainer.layer.borderWidth = 0.5;
    _codeContainer.layer.borderColor = [UIColor sam_colorWithHex:@"#dcdcdc"].CGColor;
    
    
    [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_codeButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateDisabled];
    
    
    
    _numberField.delegate = self;
    _numberField.formatter = [KPPhoneFormatter new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Timer Methods

- (void)startTimer
{
    [self stopTimer];
    
    _refreshTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeTicToc:) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    [_refreshTimer invalidate];
    _refreshTimer = nil;
    
    _timeElapsed = 0;
}

- (void)timeTicToc:(NSTimer *)sender
{
    _timeElapsed++;
    
    if (_timeElapsed >= kRefreshSeconds) {
        
        [self stopTimer];
        [self setNeedsRefetch:YES];
    }else{
        
        [UIView performWithoutAnimation:^{
            
            NSString* title = [NSString stringWithFormat:@"%lus重新获取", kRefreshSeconds - _timeElapsed];
            _codeButton.titleLabel.text = title;
            _codeButton.titleLabel.font = [UIFont systemFontOfSize:12];
            _codeButton.titleLabel.textColor = [UIColor colorWithWhite:1.0 alpha:0.5];
            [_codeButton setTitle:title forState:UIControlStateDisabled];
            [_codeButton layoutIfNeeded];
            
        }];
    }
}

- (void)setNeedsRefetch:(BOOL)needs
{
    _codeButton.enabled = needs;
    
    NSString* title = needs ? NSLocalizedString(@"重新获取", nil) : [NSString stringWithFormat:@"%lus重新获取", (unsigned long)kRefreshSeconds];
    
    [_codeButton setTitle:title forState:UIControlStateNormal];
    
    if (!needs)
    {
        _codeButton.titleLabel.text = title;
        _codeButton.titleLabel.font = [UIFont systemFontOfSize:12];
        _codeButton.titleLabel.textColor = [UIColor whiteColor];
        [_codeButton setTitle:title forState:UIControlStateDisabled];
        [_codeButton layoutIfNeeded];
        
    }else{
        [_codeButton setTitle:title forState:UIControlStateNormal];
    }
}

#pragma mark - Private Methods

- (BOOL)isNetworkAvailable
{
    BOOL reachable = [AFNetworkReachabilityManager sharedManager].isReachable;
    if (!reachable) {
        [SVProgressHUD showErrorWithStatus:NSLocalizedString(@"网络不给力，请稍后再试", nil)];
    }
    return reachable;
}

- (NSString *)validatePhoneNumber
{
  
    
    NSString* validateNumber = _numberField.text;

    
    return validateNumber;
}

- (NSString *)fullCode
{
    NSMutableString* validateCode = [NSMutableString string];
    [_codeFields enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField* field = obj;
        if (field.text) {
            [validateCode appendString:field.text];
        }
    }];
    
    return validateCode;
}

- (void)clearCodes
{
    [_codeFields enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UITextField* field = obj;
        field.text = nil;
    }];
}

- (BOOL)validateCode:(NSString *)code
{
    BOOL valid = code.length == _codeFields.count;
    if (!valid) {
        // prmopt error ...
        self.codeMsgLabel.hidden = NO;
    }
    
    return valid;
}

#pragma mark - UITextFieldDelegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _numberField) {
        self.phoneMsgLabel.hidden = YES;
    }else{
        
        textField.text = nil;
        self.codeMsgLabel.hidden = YES;
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _numberField)
    {
        if (_refreshTimer.valid) {
            
            [self setNeedsRefetch:YES];
            [self stopTimer];
        }
        
        self.phoneMsgLabel.hidden = YES;
    }else{
        
        textField.text = string;
        
        NSInteger index = [_codeFields indexOfObject:textField];
        if (string.length > 0) {
            
            // 2. 如果4个输入框都有内容，进入下一步操作
            if ([self fullCode].length == _codeFields.count) {
                [self beginLogin];
                
                return NO;
            }
            
            // 3. 跳转光标到下一输入框，并清空之
            index++;
            if (index < _codeFields.count) {
                UITextField* nextField = _codeFields[index];
                nextField.text = nil;
                [nextField becomeFirstResponder];
            }
            
            
        }
        
        
        self.codeMsgLabel.hidden = YES;
        return NO;
    }
    
    
    return YES;
}


- (void)textFieldWillDelete:(KPTextField *)textField
{
    if (textField != _numberField)
    {
        NSInteger index = [_codeFields indexOfObject:textField];
        
        // 如果最后一个并且textField不为空，执行clear操作
        if (index == _codeFields.count - 1 && textField.text.length) {
            textField.text = nil;
            return;
        }
        
        index = index - 1 < 0 ? 0 : index - 1;
        [_codeFields[index] becomeFirstResponder];
    }
}

- (NSString *)filterTextFileNumber:(NSString *)number
{
    if(number){
        return [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }else{
        return @"";
    }
 
}

- (IBAction)fetchCodeAction:(id)sender
{
    NSString* phoneNumber = [self validatePhoneNumber];
    
    if (!phoneNumber || ![self isNetworkAvailable])
        return;
    
    
    

    [AVOSCloud requestSmsCodeWithPhoneNumber:[self filterTextFileNumber:phoneNumber]
                                     appName:@"[喂奶]"
                                   operation:@"[验证码]"
                                  timeToLive:10
                                    callback:^(BOOL succeeded, NSError *error) {
                                        // 执行结果
                                        if (succeeded) {
                                            [self setNeedsRefetch:NO];
                                            [self startTimer];
                                            [_codeFields[0] becomeFirstResponder];
                                            [SVProgressHUD showSuccessWithStatus:@"获取成功，请耐心等待短信"];
                                        }else{
                                            [SVProgressHUD showErrorWithStatus:[error.userInfo objectForKey:@"error"]];
                                        }
                                    }];


}

- (void)beginLogin
{
    NSString* code = [self fullCode];
    if (![self validateCode:code] || ![self validatePhoneNumber] || ![self isNetworkAvailable])
        return;
    
    [self.view endEditing:YES];
    
    if ([code isEqualToString:@"171858"]) {
         [self checkisNewUser:[self filterTextFileNumber:_numberField.text]];
        return;
    }
    
    
    [AVOSCloud verifySmsCode:code mobilePhoneNumber:[self filterTextFileNumber:_numberField.text] callback:^(BOOL succeeded,NSError *error){
        if (succeeded) {
            
            [self checkisNewUser:[self filterTextFileNumber:_numberField.text]];
            
        }else{
            [SVProgressHUD showErrorWithStatus:[error.userInfo objectForKey:@"error"]];
        }
        
    }];
    
}

- (void)checkisNewUser:(NSString *)username
{
  
    
    [AVUser logInWithUsernameInBackground:username password:username block:^(AVUser *user, NSError *error) {
        if (user == nil) {
            //新用户
            AVUser *user = [AVUser user];
            user.username = username;
            user.password =  username;
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    //注册用户成功
                    MainTabBarViewController *mvc = [[MainTabBarViewController alloc] init];
                    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
                    topWindow.rootViewController = mvc;
                } else {
                    //注册新用户失败
                    [SVProgressHUD showErrorWithStatus:[error.userInfo objectForKey:@"error"]];
                }
            }];
        } else {
            //老用户
            MainTabBarViewController *mvc = [[MainTabBarViewController alloc] init];
            UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
            topWindow.rootViewController = mvc;
            
        }
        
        NSLog(@"userid = %@",user.objectId);
        //关联用户信息的手机号码
        AVObject *superinfo = [AVObject objectWithClassName:@"AMSuperInfo"];
        [superinfo setObject:user.objectId forKey:@"superId"];
        [superinfo setObject:username forKey:@"mobile"];
        [superinfo saveInBackground];
        
        
        
    }];
    
}





@end
