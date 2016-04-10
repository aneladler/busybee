//
//  SwipePagerViewController.m
//  BusyBee
//
//  Created by user on 01.04.16.
//  Copyright © 2016 user. All rights reserved.
//
#import "helpers.h"
#import "HomePageViewController.h"
#import "CategoriesViewController.h"
#import "FavoritesViewController.h"
#import "SwipePagerViewController.h"
#import "SWRevealViewController.h"
@interface SwipePagerViewController () <CarbonTabSwipeNavigationDelegate>
{
    NSArray *items;
    CarbonTabSwipeNavigation *carbonTabSwipeNavigation;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
@implementation SwipePagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"Title for TabBarItem";
    self.navigationItem.title = @"BusyBee";
    

    items = @[ @"Home", @"Categories",
              @"Favorites"];
    
    carbonTabSwipeNavigation = [[CarbonTabSwipeNavigation alloc] initWithItems:items delegate:self];
    [carbonTabSwipeNavigation insertIntoRootViewController:self];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self style];
}

- (void)style {
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = FlatTealDark;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    carbonTabSwipeNavigation.toolbar.translucent = NO;
    [carbonTabSwipeNavigation setIndicatorColor:FlatTealDark];
    [carbonTabSwipeNavigation setTabExtraWidth:30];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:180 forSegmentAtIndex:0];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:180 forSegmentAtIndex:1];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:180 forSegmentAtIndex:2];
    
    // Custimize segmented control
    [carbonTabSwipeNavigation setNormalColor:[FlatTealDark colorWithAlphaComponent:0.7]
                                        font:[UIFont boldSystemFontOfSize:14]];
    [carbonTabSwipeNavigation setSelectedColor:FlatBlueDark
                                          font:[UIFont boldSystemFontOfSize:14]];
}



# pragma mark - CarbonTabSwipeNavigation Delegate
// required
- (nonnull UIViewController *)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbontTabSwipeNavigation
                                 viewControllerAtIndex:(NSUInteger)index {

    if(index == 0){
        return [self.storyboard instantiateViewControllerWithIdentifier:@"HomePageViewController"];
    }
    if(index == 1){
        return [self.storyboard instantiateViewControllerWithIdentifier:@"CategoriesViewController"];
    }
    if(index == 2){
        return [self.storyboard instantiateViewControllerWithIdentifier:@"FavoritesViewController"];
    }
    return [UIViewController new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
