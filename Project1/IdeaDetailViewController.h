//
//  IdeaDetailViewController.h
//  Project1
//
//  Created by Student on 11/24/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface IdeaDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>@property PFObject *project;
@end
