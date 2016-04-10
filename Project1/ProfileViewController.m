//
//  ProfileViewController.m
//  Project1
//
//  Created by Student on 11/24/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "LandingInfoTableViewCell.h"


@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userDegreeLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property UIRefreshControl *refreshControl;
@property NSString *name;
@property UIBarButtonItem *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *messagesButton;
@property (strong, nonatomic) IBOutlet UIButton *notificationsButton;

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *likedByButton;
@property (weak, nonatomic) IBOutlet UIButton *configProfileButton;
@end

@implementation ProfileViewController
- (IBAction)SignInTapped:(id)sender {
    [self performSegueWithIdentifier:@"toLogin" sender:self];
}
- (IBAction)SignOutTapped:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"toLogin" sender:self];
}
- (IBAction)notificationsTapped:(id)sender {
    [self performSegueWithIdentifier:@"toMyNotifications" sender:self];
}
- (IBAction)likedByTapped:(id)sender {
    [self performSegueWithIdentifier:@"toLikedBy" sender:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    PFUser *user = [PFUser currentUser];
    if(user){
        self.usernameLabel.text = user.username;
        self.loginButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(SignOutTapped:)];
        self.navigationItem.rightBarButtonItem = self.loginButton;
    }
    else{
        if (!UIAccessibilityIsReduceTransparencyEnabled()) {
            self.view.backgroundColor = [UIColor clearColor];
            
            UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            blurEffectView.frame = self.view.bounds;
            blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            
            [self.view addSubview:blurEffectView];
        }  
        else {
            self.view.backgroundColor = [UIColor blackColor];
        }
        self.usernameLabel.text = @"-";
        self.loginButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign In" style:UIBarButtonItemStylePlain target:self action:@selector(SignInTapped:)];
        self.navigationItem.rightBarButtonItem = self.loginButton;
    }
    
    
}


-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(indexPath.row == 0){
        cell.profileActivityLabel.text = @"My ideas";
    }
    if(indexPath.row == 1){
        cell.profileActivityLabel.text = @"My business";
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}
-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        [self performSegueWithIdentifier:@"toMyIdeas" sender:self];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
