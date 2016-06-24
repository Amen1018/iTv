//
//  KPSeperatorView.m
//  kaopu
//
//  Created by zhilei on 12/26/14.
//  Copyright (c) 2014 baina. All rights reserved.
//

#import "KPSeperatorView.h"
#import "UIColor+SAMAdditions.h"
@implementation KPSeperatorView
{
    UIView* _line;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit
{
    
    self.backgroundColor = [UIColor clearColor];
    self.seperatorColor = [UIColor sam_colorWithHex:@"#d3d4d7"];
    self.thickness = 0.5;
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = self.seperatorColor;
    [self addSubview:_line];
    
    [self updateLayouts];
}

- (void)updateLayouts
{
    CGRect frame = self.bounds;
    if (self.style == KPSeperatorStyleVertical) {
        frame.size.width = self.thickness;
    }else{
        frame.size.height = self.thickness;
    }
    _line.frame = frame;
}

- (void)setStyle:(KPSeperatorStyle)style
{
    if (_style != style) {
        _style = style;

        [self updateLayouts];
    }
}

- (void)setSeperatorColor:(UIColor *)seperatorColor
{
    if (_seperatorColor != seperatorColor) {
        _seperatorColor = seperatorColor;
        
        _line.backgroundColor = seperatorColor;
    }
}


- (void)layoutSubviews
{
    [self updateLayouts];
}


@end
