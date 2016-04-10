//
//  MyIdeasViewController.m
//  Project1
//
//  Created by Student on 11/24/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "MyIdeasViewController.h"
#import "LandingInfoTableViewCell.h"
#import <Parse/Parse.h>
#import "IdeaDetailViewController.h"

@interface MyIdeasViewController ()
@property NSMutableArray *arrayOfIdeas;
@property PFObject *selectedProject;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MyIdeasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryIdeas];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) queryIdeas {
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"Project"];
    [query whereKey:@"host" equalTo:user];
    [query whereKey:@"status" equalTo:@"idea"];
    NSLog(@"%@", user);
    self.arrayOfIdeas = [NSMutableArray new];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for(PFObject *idea in objects){
            [self.arrayOfIdeas addObject:idea];
        }
        [self.tableView reloadData];
    }];
}
-(void) addButtonPressed:(UIButton *)button {
    [self performSegueWithIdentifier:@"toAddNew" sender:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfIdeas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSLog(@"%@",[[self.arrayOfIdeas objectAtIndex:indexPath.row] objectForKey:@"title"]);
    cell.myIdeaLabel.text = [[self.arrayOfIdeas objectAtIndex:indexPath.row] objectForKey:@"title"];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedProject = [self.arrayOfIdeas objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"toIdeaDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    IdeaDetailViewController *idvc = (IdeaDetailViewController *)[segue destinationViewController];
    idvc.project = self.selectedProject;
}


@end
