//
//  KPSeperatorView.h
//  kaopu
//
//  Created by zhilei on 12/26/14.
//  Copyright (c) 2014 baina. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KPSeperatorStyle) {
    KPSeperatorStyleVertical,
    KPSeperatorStyleHorizontal
};


/**
 *  用于在Nib中添加分割线,默认宽度为0.5
 */
@interface KPSeperatorView : UIView

// vertical or horizontal
@property (nonatomic, assign) IBInspectable KPSeperatorStyle style;

// 分割线厚度，默认为0.5
@property (nonatomic, assign) IBInspectable CGFloat thickness;

// 分割颜色，默认为#d3d4d7
@property (nonatomic, strong) IBInspectable UIColor* seperatorColor;

@end
