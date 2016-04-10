//
//  SignUpViewController.m
//  Project1
//
//  Created by Student on 11/12/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *pass;

@end

@implementation SignUpViewController

- (IBAction)signupTapped:(id)sender {
    NSString *username;
    NSString *pass;
    username = self.username.text;
    pass = self.pass.text;

    PFUser *user = [PFUser user];
    user.username = username;
    user.password = pass;
    
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self performSegueWithIdentifier:@"toProfile" sender:self];
            // Hooray! Let them use the app now.
        } else {   //NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
        }
    }];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
