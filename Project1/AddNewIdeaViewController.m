//
//  AddNewIdeaViewController.m
//  Project1
//
//  Created by Student on 11/3/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "AddNewIdeaViewController.h"
#import "LandingInfoTableViewCell.h"
#import <Parse/Parse.h>
#import "Test.h"
#import "Project.h"
#import "AppDelegate.h"

@interface AddNewIdeaViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property Test *test;
@property Project *project;
@property (weak, nonatomic) IBOutlet UIButton *AddToDashboardButton;
@property NSMutableArray *mastersToSave;
@property UITextField *titleTextField;
@property UITextField *descTextField;
@property UITextField *tagsTextField;
@property NSString *chosenField;
@property NSString *string;
@property NSArray *tags;
@end

@implementation AddNewIdeaViewController
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.string  = textField.text;
    self.tags = [NSMutableArray array];
    self.tags = [self.string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    self.tags = [self.tags filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];

    
}
- (IBAction)addTapped:(id)sender {
    
    PFUser *user = [PFUser currentUser];
    PFObject *project = [PFObject objectWithClassName:@"Project"];
    project[@"title"] = self.titleTextField.text;
    project[@"fieldName"] = self.chosenField;
    project[@"description"] = self.descTextField.text;
    
    
    [self textFieldDidEndEditing:self.tagsTextField];
    
    project[@"tags"] = self.tags;
    project[@"host"] = user;
    project[@"members"] = self.mastersToSave;
    project[@"likes"] = @0;
    project[@"views"] = @0;
    project[@"status"] = @"idea";

    [project saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            NSLog(@"%@", @"Error");
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.project = [Project new];
    UILabel *chosenFieldLabel = [[UILabel alloc] init];
    [chosenFieldLabel setHidden:YES];

}


-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"fill"];
    
    
    if(indexPath.row == 0){
        cell.textLabel.text=@"Title";
        self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        self.titleTextField.clearsOnBeginEditing = NO;
        self.titleTextField.delegate = self;
        [cell.contentView addSubview:self.titleTextField];
    }
    if(indexPath.row == 1){
        [cell.chosenFieldLabel setHidden:NO];
        cell.textLabel.text = @"Field";
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    if(indexPath.row == 2){
        cell.textLabel.text = @"Description";
        self.descTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        self.descTextField.clearsOnBeginEditing = NO;
        self.descTextField.delegate = self;
        [cell.contentView addSubview:self.descTextField];
    }
    if(indexPath.row == 3){
        cell.textLabel.text = @"Team members";
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    if(indexPath.row == 4){
        cell.textLabel.text = @"Tags";
        self.tagsTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, 10, 185, 30)];
        self.tagsTextField.clearsOnBeginEditing = NO;
        self.tagsTextField.delegate = self;
        [cell.contentView addSubview:self.tagsTextField];
    }
    if(indexPath.row == 5){
        UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(5.0, 460.0, 300.0, 80.0)];
        // add to a view
        [bottomView addSubview:self.AddToDashboardButton];
        // add the button to bottomview
        [self.tableView addSubview:bottomView];

        self.AddToDashboardButton.frame = CGRectMake(110, 10, 160, 44);
    }
    
    return cell;
}

-(void) choose:(PFObject *)field{
    self.chosenField = [field objectForKey:@"fieldName"];
    NSIndexPath *i = [NSIndexPath indexPathForRow:1 inSection:0];
    [self.tableView cellForRowAtIndexPath:i].textLabel.text = self.chosenField;
    
}

-(void)chooseMasters:(NSMutableArray *)chosenMasters{
    self.mastersToSave = chosenMasters;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 1){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self performSegueWithIdentifier:@"toChooseField" sender:self];
    }
    if(indexPath.row == 3){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self performSegueWithIdentifier:@"toChooseTeamMembers" sender:self];
    }

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toChooseField"]){
        FieldsDetailViewController *fvc = (FieldsDetailViewController *)[segue destinationViewController];
        fvc.delegate = self;
    }
    if([segue.identifier isEqualToString:@"toChooseTeamMembers"]){
        TeamMembersViewController *tmvc = (TeamMembersViewController *)[segue destinationViewController];
        tmvc.delegate = self;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
