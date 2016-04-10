//
//  HomePageViewController.m
//  BusyBee
//
//  Created by user on 27.03.16.
//  Copyright © 2016 user. All rights reserved.
//

#import "HomePageViewController.h"
#import "SWRevealViewController.h"
#import "InfoTableViewCell.h"
#import "CategoriesViewController.h"
#import "FavoritesViewController.h"

#import "helpers.h"

@interface HomePageViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *addNewIdeaButton;
@property PFObject *selectedProject;
@property NSMutableArray *projectsArray;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HomePageViewController{
    CarbonSwipeRefresh *refresh;
}
- (IBAction)favTapped:(id)sender {
}

- (IBAction)AddNewButton:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    if(currentUser){
        [self performSegueWithIdentifier:@"toAddNew" sender:self];
    }else{
        [self performSegueWithIdentifier:@"toSignIn" sender:self];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = FlatTealDark;
    [self queryProjects];
    refresh = [[CarbonSwipeRefresh alloc] initWithScrollView:self.tableView];
    [refresh setColors:@[
                         [UIColor blueColor],
                         [UIColor redColor],
                         [UIColor orangeColor],
                         [UIColor greenColor]]
     ];
    [self.view addSubview:refresh];
    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self.addNewIdeaButton.layer setBorderWidth:2.0f];
    [self.addNewIdeaButton.layer setBorderColor:[UIColor flatRedColor].CGColor];
    self.addNewIdeaButton.titleLabel.numberOfLines = 1;
    self.addNewIdeaButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.addNewIdeaButton.titleLabel.lineBreakMode = NSLineBreakByClipping;
    
    
    [self.view addSubview:self.buttonView];
    self.buttonView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    self.addNewIdeaButton.layer.cornerRadius = 10;
    self.addNewIdeaButton.clipsToBounds = YES;
    self.tableView.separatorColor = FlatTealDark;
}
- (void)refresh:(id)sender {
    [self queryProjects];
    [refresh endRefreshing];
    [self.tableView reloadData];
}
-(void) queryProjects {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Project"];
    self.projectsArray = [NSMutableArray new];
    [query includeKey:@"host"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for(PFObject *project in objects){
            
            [self.projectsArray addObject:project];
        }
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.projectsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.viewsLabel.adjustsFontSizeToFitWidth = YES;
    cell.likesLabel. adjustsFontSizeToFitWidth = YES;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    cell.projectLabel.backgroundColor = [UIColor clearColor];
    cell.projectLabel.text = [[self.projectsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.viewsLabel.text = [NSString stringWithFormat:@"%@",[[self.projectsArray objectAtIndex:indexPath.row] objectForKey:@"views"]];
    cell.likesLabel.text =[NSString stringWithFormat:@"%@",[[self.projectsArray objectAtIndex:indexPath.row] objectForKey:@"likes"]];
    if(indexPath.row == 0){
    cell.projectImageView.image = [UIImage imageNamed:@"image.jpg"];
    }
    if(indexPath.row == 1){
        cell.projectImageView.image = [UIImage imageNamed:@"image1.jpg"];
    }
    if(indexPath.row == 2){
        cell.projectImageView.image = [UIImage imageNamed:@"image2.jpg"];
    }
    if(indexPath.row == 3){
        cell.projectImageView.image = [UIImage imageNamed:@"image3.jpg"];
    }
    cell.teamImageView.image = [UIImage imageNamed:@"image1.jpg"];
    cell.teamImageView.layer.cornerRadius = 70;
    cell.teamImageView.clipsToBounds = YES;
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectedProject = [self.projectsArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"toProjectDetail" sender:self];
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
