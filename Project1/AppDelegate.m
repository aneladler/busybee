//
//  AppDelegate.m
//  Project1
//
//  Created by Student on 10/20/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import <ChameleonFramework/Chameleon.h>
#import <Onboard/OnboardingContentViewController.h>
#import <Onboard/OnboardingViewController.h>
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
        
    
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"87pJcfbnBkTqK1LIK0RAZ5f6gUMG2doQQ8KjQVof"
                  clientKey:@"x8mdkNuUqPTQFnRhKN2j7Zsl7o1nRsejkFBNxRg3"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [[UITabBar appearance] setBarTintColor:FlatTealDark];
    [UITabBarItem.appearance setTitleTextAttributes:
     @{NSForegroundColorAttributeName : FlatWhite}
                                           forState:UIControlStateNormal];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
    //[Chameleon setGlobalThemeUsingPrimaryColor:FlatTealDark withContentStyle:UIContentStyleLight];
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"firstRunCompleted"])
    {
        OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"Page Title" body:@"Page body goes here." image:[UIImage imageNamed:@"icon"] buttonText:@"Text For Button" action:^{
        }];
        OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"Page Title" body:@"Page body goes here." image:[UIImage imageNamed:@"icon"] buttonText:@"Text For Button" action:^{
        }];
        OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"Page Title" body:@"Page body goes here." image:[UIImage imageNamed:@"icon"] buttonText:@"Start!" action:^{
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"UITabBarController"];
            [[[[UIApplication sharedApplication] delegate] window] setRootViewController:vc];
            }];
        
        OnboardingViewController *onboardingVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@"background.jpg"] contents:@[firstPage, secondPage, thirdPage]];
        onboardingVC.allowSkipping = YES;
         onboardingVC.skipHandler = ^{
             //[self handleOnboardingCompletion];
         };
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:onboardingVC animated:YES completion:nil];
        
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstRunCompleted"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
