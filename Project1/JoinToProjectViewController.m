//
//  JoinToProjectViewController.m
//  Project1
//
//  Created by Student on 12/16/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "JoinToProjectViewController.h"
#import "LandingInfoTableViewCell.h"

@interface JoinToProjectViewController ()
@property (strong, nonatomic) IBOutlet UILabel *textLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSString *vacant;
@property PFUser *currentUser;
@end

@implementation JoinToProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [PFUser currentUser];

    if(self.currentUser){
    
    }
    self.textLabel.text = @"List of vacants:";
    // Do any additional setup after loading the view.
}
- (IBAction)sendRequestTapped:(id)sender {
    if(self.currentUser){
        [sender setTitle:@"Sent" forState:UIControlStateNormal];
    
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *tappedIP = [self.tableView indexPathForRowAtPoint:buttonPosition];
        LandingInfoTableViewCell *clickedCell = (LandingInfoTableViewCell *)[self.tableView cellForRowAtIndexPath:tappedIP];
    
        self.vacant = clickedCell.vacantMaster.text;
        [self sendRequestForVacant];
    }
}
-(void) sendRequestForVacant{
    
    
    
    PFObject *request = [PFObject objectWithClassName:@"Requests"];
    request[@"masterName"] = self.vacant;
    request[@"requestFrom"] = self.currentUser;
    request[@"requestTo"] = [self.project objectForKey:@"host"];
    request[@"parent"] = self.project;
    request[@"status"] = @"Pending";
    [request saveInBackground];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.vacantMaster.text = [[self.project objectForKey:@"members"] objectAtIndex:indexPath.row];

    [cell.sendRequestButton setTitle:@"Send Request" forState:UIControlStateNormal];
    
    if([self.currentUser isEqual:[self.project objectForKey:@"host"]]){
        [cell.sendRequestButton setEnabled:NO];
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                      target:self action:@selector(addButtonPressed:)];
        self.navigationItem.rightBarButtonItem = addButton;
     }
    
    
    return cell;
    
}
-(void) addButtonPressed:(UIButton *)button{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.project objectForKey:@"members"] count];
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
