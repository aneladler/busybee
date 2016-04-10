//
//  SearchTableViewController.m
//  Project1
//
//  Created by Student on 11/23/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "SearchTableViewController.h"
#import <Parse/Parse.h>
#import "LandingInfoTableViewCell.h"
#import "SearchProjectDetailViewController.h"

@interface SearchTableViewController ()
@property NSMutableArray *arrayOfFields;
//@property NSString *fieldForProject;
@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryFields];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) queryFields {
    
    PFQuery *query = [PFQuery queryWithClassName:@"fields"];
    self.arrayOfFields = [NSMutableArray new];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for(PFObject *fieldName in objects){
            [self.arrayOfFields addObject:[fieldName objectForKey:@"fieldName"]];
        }
        [self.tableView reloadData];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfFields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.searchFieldLabel.text = [self.arrayOfFields objectAtIndex:indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    self.fieldForProject = cell.searchFieldLabel.text;
    [self performSegueWithIdentifier:@"toProjectDetail" sender:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toProjectDetail"]){
        SearchProjectDetailViewController *pdvc = (SearchProjectDetailViewController *)[segue destinationViewController];
        pdvc.field = self.fieldForProject;
    }
}


@end
