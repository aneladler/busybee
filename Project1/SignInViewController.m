//
//  SignInViewController.m
//  Project1
//
//  Created by Student on 11/22/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "SignInViewController.h"
#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface SignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextField;

@end

@implementation SignInViewController
- (IBAction)signInTapped:(id)sender {
    NSString *username;
    NSString *pass;
    
    username = self.usernameTextField.text;
    pass = self.passTextField.text;
    
    
    if (![username isEqual: @""] && ![pass isEqual:@""]) {
    [PFUser logInWithUsernameInBackground:username password:pass
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [self performSegueWithIdentifier:@"toProfile" sender:self];

                                        } else {
                                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login failure" message:@"Invalid user name/password. Try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                            [alert show];
                                        }
  
                                    }];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Empty fields" message:@"One or more fields are empty." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (IBAction)goSignUp:(id)sender {
    [self performSegueWithIdentifier:@"toSignUp" sender:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    PFUser *user = [PFUser currentUser];
    if(user){
        [ self performSegueWithIdentifier:@"toProfile" sender:self];
    }
    self.usernameTextField.delegate = self;
    self.passTextField.delegate = self;
    // Do any additional setup after loading the view.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toProfile" ]){
        ProfileViewController *pvc = segue.destinationViewController;
        pvc.navigationItem.hidesBackButton = YES;
    }
}


@end
