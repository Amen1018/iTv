//
//  AMNewsTableViewCell.m
//  Anurse
//
//  Created by Amen on 6/18/15.
//  Copyright (c) 2015 Amen. All rights reserved.
//

#import "AMNewsTableViewCell.h"

@implementation AMNewsTableViewCell
@synthesize titleLabel = _titleLabel, artistLabel = _artistLabel ,newsImage = _newsImage;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [_newsImage setContentMode:UIViewContentModeScaleToFill];
}

@end
