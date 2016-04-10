//
//  IdeaDetailViewController.m
//  Project1
//
//  Created by Student on 11/24/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "IdeaDetailViewController.h"
#import "LandingInfoTableViewCell.h"
#import "JoinToProjectViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ShowTeamViewController.h"

@interface IdeaDetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *fieldLabel;
@property (strong, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (strong, nonatomic) IBOutlet UILabel *launchedAtLabel;
@property (strong, nonatomic) IBOutlet UILabel *likesLabel;
@property (strong, nonatomic) IBOutlet UILabel *viewsLabel;
@property (strong, nonatomic) IBOutlet UILabel *hostLabel;
@property PFUser *currentUser;
@property (strong, nonatomic) IBOutlet UILabel *descLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *tagsLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property UIRefreshControl *refreshControl;

@end

@implementation IdeaDetailViewController
- (IBAction)likeTapped:(id)sender {
    if(![self.currentUser isEqual:[self.project objectForKey:@"host"]]){
        
        PFRelation *relation = [self.currentUser relationForKey:@"likes"];
        PFQuery *query = [relation query];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
            if(results){
            if(![results containsObject:self.project]){
                [relation addObject:self.project];
                [self.currentUser saveInBackground];
                [self.project incrementKey:@"likes" byAmount:@1];
                [self.project saveInBackground];
                self.likesLabel.text = [NSString stringWithFormat:@"%i",[[self.project objectForKey:@"likes"]intValue]];

            }else{
                //[self.project incrementKey:@"likes" byAmount:@-1];
                //[self.project saveInBackground];
            }}else{
                NSLog(@"%@",@"Error");
            }
        }];
        
    }
}

- (void)viewDidLoad {
    self.currentUser = [PFUser currentUser];
    [super viewDidLoad];
    
        [self updateViews];
        self.titleLabel.text = [self.project objectForKey:@"title"];
        self.fieldLabel.text = [self.project objectForKey:@"fieldName"];
        //self.createdAtLabel.text = [self.project objectForKey:@"createdAt"];
        self.hostLabel.text = [NSString stringWithFormat:@"%@ %@", @"Host:", [[self.project objectForKey:@"host"] username]];
        self.launchedAtLabel.text = @"Yet to come :)";
        self.likesLabel.text = [NSString stringWithFormat:@"%i",[[self.project objectForKey:@"likes"]intValue]] ;
        self.viewsLabel.text = [NSString stringWithFormat:@"%i",[[self.project objectForKey:@"views"]intValue]];
        self.descLabel.layer.borderColor = [UIColor redColor].CGColor;
        self.descLabel.layer.borderWidth = 1.0;
        self.descLabel.layer.cornerRadius = 8;
        self.descLabel.text = [self.project objectForKey:@"description"];


        self.tagsLabel.text = [[self.project objectForKey:@"tags"]  componentsJoinedByString:@" "];
        self.tagsLabel.layer.borderColor = [UIColor redColor].CGColor;
        self.tagsLabel.layer.borderWidth = 1.0;
        self.tagsLabel.layer.cornerRadius = 8;
    
        /* NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy:MM:dd"];
         NSDate *date = [self.project objectForKey:@"createdAt"];
         [self.createdAtLabel setText:[NSString stringWithFormat:@"%@", [formatter stringFromDate:[self.project objectForKey:@"createdAt"]]] ];
         */
        NSDate *createdAt = [self.project createdAt];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMM d yyyy"];
        self.createdAtLabel.text = [NSString stringWithFormat:@"Created at: %@", [dateFormat stringFromDate:createdAt]];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(testRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:refreshControl];
    
    [self.view addSubview:self.scrollView];
    
}
-(void) updateViews{
    if(![self.currentUser isEqual:[self.project objectForKey:@"host"]]){
        PFRelation *relation = [self.currentUser relationForKey:@"views"];
        PFQuery *query = [relation query];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
            if(results){
                if(![results containsObject:self.project]){
                    [relation addObject:self.project];
                    [self.currentUser saveInBackground];
                    [self.project incrementKey:@"views" byAmount:@1];
                    [self.project saveInBackground];
                }
            }
        }];
    }
}

- (void)testRefresh:(UIRefreshControl *)refreshControl
{
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [NSThread sleepForTimeInterval:3];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MMM d, h:mm a"];
            NSString *lastUpdate = [NSString stringWithFormat:@"Last updated on %@", [formatter stringFromDate:[NSDate date]]];
            
            refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdate];
            
            [refreshControl endRefreshing];
            
            NSLog(@"refresh end");
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(indexPath.row == 0){
        cell.teamLabel.text = @"Our team";
    }
    if(indexPath.row == 1){
        cell.teamLabel.text = @"Join us!";
        cell.teamLabel.textColor = [UIColor redColor];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        [self performSegueWithIdentifier:@"toShowTeam" sender:self];
    }
    else if(indexPath.row == 1){
        [self performSegueWithIdentifier:@"joinToProject" sender:self];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"joinToProject"]){
        JoinToProjectViewController *jtpvc = segue.destinationViewController;
        jtpvc.project = self.project;
    }
    if([segue.identifier isEqualToString:@"toShowTeam"]){
        ShowTeamViewController *stvc = segue.destinationViewController;
        stvc.project = self.project;
    }
}


@end
