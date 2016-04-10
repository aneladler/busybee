//
//  ProjectDetailViewController.m
//  Project1
//
//  Created by Student on 11/24/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "SearchProjectDetailViewController.h"
#import <Parse/Parse.h>
#import "LandingInfoTableViewCell.h"
#import "IdeaDetailViewController.h"

@interface SearchProjectDetailViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *projectsInChosenField;
@property PFObject *selectedProject;

@end

@implementation SearchProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryProjects];
    // Do any additional setup after loading the view.
}
-(void) queryProjects{
    PFQuery *query = [PFQuery queryWithClassName:@"Project"];
    [query whereKey:@"fieldName" equalTo:self.field];
    self.projectsInChosenField = [NSMutableArray new];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for(PFObject *project in objects){
            [self.projectsInChosenField addObject:project];
        }
        [self.tableView reloadData];
    }];
}
-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.projectDetailLabel.text = [[self.projectsInChosenField objectAtIndex:indexPath.row] objectForKey:@"title"];

    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.projectsInChosenField.count;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedProject = [self.projectsInChosenField objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"toIdeaDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    IdeaDetailViewController *idvc = (IdeaDetailViewController *)[segue destinationViewController];
    idvc.project = self.selectedProject;
}



@end
