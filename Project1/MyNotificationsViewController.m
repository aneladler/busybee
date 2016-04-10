//
//  MyNotificationsViewController.m
//  Project1
//
//  Created by Student on 12/16/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "MyNotificationsViewController.h"
#import <Parse/Parse.h>
#import "LandingInfoTableViewCell.h"

@interface MyNotificationsViewController ()
@property PFUser *currentUser;
@property NSMutableArray *arrayOfRequests;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property PFObject *project;
@property PFUser *requestFrom;
@property NSString *acceptedPlace;
@property NSString *acceptedToProject;
@property NSMutableArray *projects;
@property NSMutableArray *requests;
@property UIRefreshControl *refreshControl;
@end

@implementation MyNotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [PFUser currentUser];
    [self queryRequests];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@""];
    
    }
- (void)refreshTable {
    [self queryRequests];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (IBAction)AcceptTapped:(id)sender {
    if(self.currentUser){
        [sender setTitle:@"Accepted" forState:UIControlStateNormal];
        
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *tappedIP = [self.tableView indexPathForRowAtPoint:buttonPosition];
        LandingInfoTableViewCell *clickedCell = (LandingInfoTableViewCell *)[self.tableView cellForRowAtIndexPath:tappedIP];

        self.acceptedPlace = clickedCell.vacantPlaceLabel.text;
        self.acceptedToProject = clickedCell.projectLabel.text;
        [self updateTeam:tappedIP];
    }
}

-(void) updateTeam:(NSIndexPath *)tappedIP{
    PFQuery *query = [PFQuery queryWithClassName:@"Requests"];
    [query whereKey:@"masterName" equalTo:self.acceptedPlace];
    [query whereKey:@"parent" equalTo:[self.projects objectAtIndex:tappedIP.row]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for(PFObject *project in objects){
            project[@"status"] = @"Accepted";
            [project saveInBackground];
        }
        [self.tableView reloadData];
    }];
    
    PFObject *team = [PFObject objectWithClassName:@"Team"];
    NSLog(@"%@",[self.projects objectAtIndex:tappedIP.row]);
    team[@"project"] = [self.projects objectAtIndex:tappedIP.row] ;
    team[@"position"] = self.acceptedPlace;
    team[@"teamMember"] = [self.requests objectAtIndex:tappedIP.row];
    [team saveInBackground];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) queryRequests {
    PFQuery *query = [PFQuery queryWithClassName:@"Requests"];
    self.arrayOfRequests = [NSMutableArray new];
    self.projects = [NSMutableArray new];
    self.requests = [NSMutableArray new];
    [self.currentUser fetchIfNeeded];
    [query whereKey:@"requestTo" equalTo:self.currentUser];
    [query includeKey:@"requestFrom"];
    [query includeKey:@"requestTo"];
    [query whereKey:@"status" equalTo:@"Pending"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for(PFObject *request in objects){
            [self.arrayOfRequests addObject:request];
            self.project = [request objectForKey:@"parent"];
            [self.projects addObject:self.project];
            NSLog(@"%@",[request objectForKey:@"requestTo"] );
            self.requestFrom = [request objectForKey:@"requestFrom"];
            [self.requests addObject:self.requestFrom];
        }
        [self.tableView reloadData];
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if(self.segmentedControl.selectedSegmentIndex == 0)
    {
        if(self.arrayOfRequests.count > 0){
            return self.arrayOfRequests.count;
        }
        return 1;
    }
    else
        if (self.segmentedControl.selectedSegmentIndex==1) {
            return 1;
        }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(self.segmentedControl.selectedSegmentIndex==0 && self.arrayOfRequests.count > 0)
    {
        [cell.applicantNameLabel setHidden:NO];
        [cell.projectLabel setHidden:NO];
        [cell.acceptButton setHidden:NO];
        cell.vacantPlaceLabel.text=[[self.arrayOfRequests objectAtIndex:indexPath.row] objectForKey:@"masterName"];
        cell.projectLabel.text = [[self.projects objectAtIndex:indexPath.row] objectForKey:@"title"];
        [cell.applicantNameLabel setTitle:[[self.requests objectAtIndex:indexPath.row] username] forState:UIControlStateNormal];
        
    }
    else if(self.segmentedControl.selectedSegmentIndex==1) {
        [cell.applicantNameLabel setHidden:YES];
        [cell.projectLabel setHidden:YES];
        [cell.acceptButton setHidden:YES];
        cell.vacantPlaceLabel.text = @"No feedback yet.";
    }
    
    else{
        [cell.applicantNameLabel setHidden:YES];
        [cell.projectLabel setHidden:YES];
        [cell.acceptButton setHidden:YES];
        cell.vacantPlaceLabel.text = @"No requests yet.";
    }
    return cell;
}




-(IBAction) segmentedControlIndexChanged
{
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            [self.tableView reloadData];
            break;
        case 1:
            [self.tableView reloadData];
            break;
        default:
            break;
    }
    
    
    
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
