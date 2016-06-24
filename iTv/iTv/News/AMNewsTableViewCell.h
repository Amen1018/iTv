//
//  AMNewsTableViewCell.h
//  Anurse
//
//  Created by Amen on 6/18/15.
//  Copyright (c) 2015 Amen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMNewsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) IBOutlet UIImageView *newsImage;
@end
