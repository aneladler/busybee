//
//  InfoTableViewCell.m
//  BusyBee
//
//  Created by user on 31.03.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "InfoTableViewCell.h"


@implementation InfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.projectImageView setBackgroundColor:[UIColor clearColor]];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = CGPointMake(0.4, 0.1);
    gradient.endPoint = CGPointMake(0.5, 0.9);
    self.projectImageView.frame = CGRectMake(80, 5, 300, 180);
    gradient.frame = self.projectImageView.bounds;
    gradient.colors = @[(id)[[UIColor clearColor] CGColor],
                        (id)FlatWhite.CGColor];
    [self.projectImageView.layer insertSublayer:gradient atIndex:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
