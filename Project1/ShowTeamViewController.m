//
//  ShowTeamViewController.m
//  Project1
//
//  Created by Student on 12/17/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "ShowTeamViewController.h"
#import "LandingInfoTableViewCell.h"

@interface ShowTeamViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *teamMembers;

@end

@implementation ShowTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryTeam];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) queryTeam{
    PFQuery *query = [PFQuery queryWithClassName:@"Team"];
    [query whereKey:@"project" equalTo:self.project];
    [query includeKey:@"teamMember"];
    self.teamMembers = [NSMutableArray new];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for(PFObject *member in objects){
            [self.teamMembers addObject:member];
        }
        [self.tableView reloadData];
    }];
}
-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.teamMemberName.text = [[[self.teamMembers objectAtIndex:indexPath.row] objectForKey:@"teamMember"] objectForKey:@"username"];
    cell.teamPosition.text = [[self.teamMembers objectAtIndex:indexPath.row] objectForKey:@"position"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teamMembers.count;
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
