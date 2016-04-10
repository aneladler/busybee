//
//  FieldsDetailViewController.m
//  Project1
//
//  Created by Student on 11/16/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "FieldsDetailViewController.h"
#import "LandingInfoTableViewCell.h"
#import "AddNewIdeaViewController.h"

@interface FieldsDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *arrayOfFields;
@end

@implementation FieldsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryFields];
    // Do any additional setup after loading the view.
}
-(void) queryFields {
    
    PFQuery *query = [PFQuery queryWithClassName:@"fields"];
    self.arrayOfFields = [NSMutableArray new];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    for(PFObject *fieldName in objects){
        [self.arrayOfFields addObject:fieldName];
    }
    [self.tableView reloadData];
    }];
}

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LandingInfoTableViewCell *cell = (LandingInfoTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.fieldLabel.adjustsFontSizeToFitWidth = YES;
    cell.fieldLabel.text = [[self.arrayOfFields objectAtIndex:indexPath.row] objectForKey:@"fieldName"];
    
    return cell;
}

-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayOfFields.count;
}

-(void)tableView: (UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    PFObject *chosen = [self.arrayOfFields objectAtIndex:indexPath.row];
    
    [self.delegate choose:chosen];
    [self.navigationController popViewControllerAnimated:YES];
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
