//
//  DashboardViewController.m
//  BusyBee
//
//  Created by user on 27.03.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "DashboardViewController.h"
#import "SWRevealViewController.h"

@interface DashboardViewController ()


@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoImageView.image = [UIImage imageNamed:self.photoFilename];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
