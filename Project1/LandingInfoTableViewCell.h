//
//  LandingInfoTableViewCell.h
//  Project1
//
//  Created by Student on 10/27/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandingInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIButton *viewsButton;
@property (weak, nonatomic) IBOutlet UIButton *likesButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;
@property (strong, readwrite) IBOutlet UILabel *chosenFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *searchFieldLabel;

@property (strong, readwrite) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *fieldLabel;
@property (strong, readwrite) IBOutlet UILabel *projectDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *profileActivityLabel;
@property (strong, nonatomic) IBOutlet UILabel *myIdeaLabel;
@property (strong, nonatomic) IBOutlet UILabel *teamLabel;

@property (weak, nonatomic) IBOutlet UILabel *MemberLabel;

@property (strong, nonatomic) IBOutlet UILabel *vacantMaster;
@property (strong, nonatomic) IBOutlet UIButton *sendRequestButton;

@property (strong, nonatomic) IBOutlet UIButton *applicantNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *acceptButton;
@property (strong, nonatomic) IBOutlet UILabel *vacantPlaceLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectLabel;

@property (strong, nonatomic) IBOutlet UILabel *teamMemberName;
@property (strong, nonatomic) IBOutlet UILabel *teamPosition;
@property (strong, nonatomic) IBOutlet UIImageView *teamImage;
@property (weak, nonatomic) IBOutlet UILabel *likedProjectTitle;

@end
