//
//  TeamMembersViewController.h
//  Project1
//
//  Created by Student on 11/19/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol ChosenMastersDelegate <NSObject>
@optional
-(void)chooseMasters:(NSMutableArray *)chosenMasters;

@end
@interface TeamMembersViewController : UIViewController
@property (nonatomic, weak) id <ChosenMastersDelegate> delegate;
@end
