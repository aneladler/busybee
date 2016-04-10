//
//  LikedByViewController.m
//  Project1
//
//  Created by user on 29.02.16.
//  Copyright © 2016 Anel. All rights reserved.
//

#import "LikedByViewController.h"
#import "LandingInfoTableViewCell.h"
#import "IdeaDetailViewController.h"

@interface LikedByViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property PFUser *currentUser;
@property NSMutableArray *projectsArray;
@property PFObject *selectedProject;
@end

@implementation LikedByViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [PFUser currentUser];
    [self queryLikedProjects];

}
-(void)queryLikedProjects{
    
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    self.projectsArray = [NSMutableArray new];
    //[query whereKey:@"objectId" equalTo:self.currentUser];
    [query includeKey:@"likes"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for(PFObject *project in objects){
            [self.projectsArray addObject:[project objectForKey:@"likes"]];
        }
        [self.tableView reloadData];
    }];
}
-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.likedProjectTitle.text = [[self.projectsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.projectsArray.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedProject = [self.projectsArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"toIdeaDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    IdeaDetailViewController *idvc = (IdeaDetailViewController *)[segue destinationViewController];
    idvc.project = self.selectedProject;
}



@end
