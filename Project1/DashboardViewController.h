//
//  DashboardViewController.h
//  BusyBee
//
//  Created by user on 27.03.16.
//  Copyright © 2016 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property NSString *photoFilename;
@end
