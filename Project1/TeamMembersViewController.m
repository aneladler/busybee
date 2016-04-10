//
//  TeamMembersViewController.m
//  Project1
//
//  Created by Student on 11/19/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "TeamMembersViewController.h"
#import "LandingInfoTableViewCell.h"
#import "AddNewIdeaViewController.h"

@interface TeamMembersViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property NSMutableArray *mastersArray;
@property NSMutableArray *chosenMasters;
@end

@implementation TeamMembersViewController

- (IBAction)saveTapped:(id)sender {
    [self.delegate chooseMasters:self.chosenMasters];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryMasters];
    self.chosenMasters = [[NSMutableArray alloc] init];

    // Do any additional setup after loading the view.
}
-(void) queryMasters {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Masters"];
    self.mastersArray = [NSMutableArray new];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for(PFObject *master in objects){
            [self.mastersArray addObject:master];
        }
        [self.tableView reloadData];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"vacant"];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem = addButton;
    int totalRow = (int)self.mastersArray.count;
    
    
    if(indexPath.row < totalRow){
        cell.MemberLabel.text = [[self.mastersArray objectAtIndex:indexPath.row] objectForKey:@"masterName"];

        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.accessoryView = switchView;
        [switchView setOn:NO animated:NO];
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        //[switchView release];
    }
    
    if(indexPath.row == totalRow){
        UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(5.0, 460.0, 300.0, 80.0)];
        // add to a view
        [bottomView addSubview:self.saveButton];
        // add the button to bottomview
        [tableView addSubview:bottomView];
        
        self.saveButton.frame = CGRectMake(110, 0, 160, 22);
    }
    
    
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mastersArray.count+1;
}

-(void) addButtonPressed:(UIButton *)button {
    
}

- (void) switchChanged:(id)sender {
    UISwitch* switchControl = sender;
    NSLog( @"The switch is %@", switchControl.on ? @"ON" : @"OFF" );
    CGPoint center= switchControl.center;
    CGPoint rootViewPoint = [switchControl.superview convertPoint:center toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:rootViewPoint];
    
    LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    NSLog( @"The switch is %@", indexPath);
    NSString *master = cell.MemberLabel.text;
    [self.chosenMasters addObject:master];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
