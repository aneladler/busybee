//
//  FieldsDetailViewController.h
//  Project1
//
//  Created by Student on 11/16/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol ChosenFieldDelegate <NSObject>
@optional
-(void)choose:(PFObject *)field;

@end
@interface FieldsDetailViewController : UIViewController
@property (nonatomic, weak) id <ChosenFieldDelegate> delegate;
@end
