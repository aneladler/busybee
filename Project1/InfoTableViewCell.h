//
//  InfoTableViewCell.h
//  BusyBee
//
//  Created by user on 31.03.16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "helpers.h"

@interface InfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *projectLabel;
@property (weak, nonatomic) IBOutlet UIImageView *projectImageView;
@property (weak, nonatomic) IBOutlet UIImageView *teamImageView;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teamImage;
@property (weak, nonatomic) IBOutlet UIImageView *investImage;
@property (weak, nonatomic) IBOutlet UIImageView *expertImage;


@end
