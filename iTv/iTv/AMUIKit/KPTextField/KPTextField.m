//
//  KPTextField.m
//  kaopu
//
//  Created by zhilei on 12/3/14.
//  Copyright (c) 2014 baina. All rights reserved.
//

#import "KPTextField.h"
#import "KPTextFormatter.h"

#pragma mark - Class KPTextFieldDelegate

@interface KPTextFieldDelegate : NSObject<UITextFieldDelegate>

@property (nonatomic, weak) id<UITextFieldDelegate> delegate;
@property (nonatomic, strong) KPTextFormatter* formatter;

- (id)initWithDelegate:(id<UITextFieldDelegate>)delegate;

@end

@implementation KPTextFieldDelegate

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithDelegate:(id<UITextFieldDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    
    return self;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.delegate textFieldShouldBeginEditing:textField];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        return [self.delegate textFieldDidBeginEditing:textField];
    }
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.delegate textFieldShouldEndEditing:textField];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        return [self.delegate textFieldDidEndEditing:textField];
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    BOOL shouldReplace = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        shouldReplace = [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    // Bugfix KAOP 955 : Here we should check shouldReplace, it doesn't make sense if shouldReplace
    // is false and self.formatter still update the textfield.
    if (shouldReplace && self.formatter) {
        
        UITextPosition *origin = textField.selectedTextRange.start;
        
        NSString* supposedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString* formattedText = [self.formatter format:supposedText withLocale:[NSLocale currentLocale]];
        textField.text = formattedText;
        
        NSInteger offset = formattedText.length - supposedText.length;
        offset += range.length ? -range.length : 1;
        
        UITextPosition *endPosition = [textField positionFromPosition:origin offset:offset];
        textField.selectedTextRange = [textField textRangeFromPosition:endPosition toPosition:endPosition];

        // System's notification doesn't fire if we change text programtically, so here we fire UITextFieldTextDidChangeNotification by ourself.
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:textField];
        
        return NO;
    }
    
    return shouldReplace;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.delegate textFieldShouldClear:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.delegate textFieldShouldReturn:textField];
    }
    
    return YES;
}


- (void)textFieldTextDidChange:(NSNotification *)note
{
    UITextField* textfield = (UITextField *)note.object;
    id<KPTextFieldDelegate> delegate = (id<KPTextFieldDelegate>)self.delegate;
    
    if (delegate && [delegate respondsToSelector:@selector(textFieldTextDidChange:)]) {
        [delegate textFieldTextDidChange:textfield];
    }
}


@end


#pragma mark - Class KPTextField

@interface KPTextField()<UITextFieldDelegate>

@property (nonatomic, strong) KPTextFieldDelegate* delegatation;

@end


@implementation KPTextField


#pragma mark - UIResponder Override Methods

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (self.disableMenu)
    {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
        }];
    }
    
    return [super canPerformAction:action withSender:sender];
}

#pragma mark - Private Methods

- (KPTextFieldDelegate *)delegatation
{
    if (!_delegatation) {
        _delegatation = [[KPTextFieldDelegate alloc] init];
    }
    
    return _delegatation;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    self.delegatation.delegate = delegate;
    [super setDelegate:self.delegatation];
}


#pragma mark - UIKeyInput protocol

- (void)deleteBackward
{
    id<KPTextFieldDelegate> delegate = (id<KPTextFieldDelegate>)self.delegatation.delegate;

    if (delegate && [delegate respondsToSelector:@selector(textFieldWillDelete:)]) {
        [delegate textFieldWillDelete:self];
    }

    [super deleteBackward];
    
    if (delegate && [delegate respondsToSelector:@selector(textFieldDidDelete:)]) {
        [delegate textFieldDidDelete:self];
    }
}

// iOS 8 workaroud:
- (BOOL)keyboardInputShouldDelete:(UITextField *)textField
{
    BOOL shouldDelete = YES;
    
    if (![textField.text length] && [[[UIDevice currentDevice] systemVersion] intValue] >= 8) {
        [self deleteBackward];
    }

    if ([UITextField instancesRespondToSelector:_cmd]) {
        BOOL (*keyboardInputShouldDelete)(id, SEL, UITextField *) = (BOOL (*)(id, SEL, UITextField *))[UITextField instanceMethodForSelector:_cmd];
        
        if (keyboardInputShouldDelete) {
            shouldDelete = keyboardInputShouldDelete(self, _cmd, textField);
        }
    }
    
    
    return shouldDelete;
}

#pragma mark - Formatter


- (void)setFormatter:(KPTextFormatter *)formatter
{
    self.delegatation.formatter = formatter;
}

- (KPTextFormatter *)formatter
{
    return self.delegatation.formatter;
}


@end
