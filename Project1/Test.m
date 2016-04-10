//
//  Test.m
//  Project1
//
//  Created by Student on 10/29/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import "Test.h"
#import "Project.h"

@implementation Test

-(instancetype) init{
    if([super init]){
        self.projectInfo = [NSMutableArray new];
        
        
        /*Project *p1 = [Project new];
        p1.projectTitle = @"This is what makes us girls";
        p1.likes = 12;
        p1.views = 23;
        Project *p2 = [Project new];
        p2.projectTitle = @"This is what it feels like";
        p2.likes = 8;
        p2.views = 12;
        Project *p3 = [Project new];
        p3.projectTitle = @"Is this a real life? Is this just fantasy?";
        p3.likes = 120;
        p3.views = 230;
        
        [self.projectInfo addObject:p1];
        [self.projectInfo addObject:p2];
        [self.projectInfo addObject:p3];*/
    }
    return self;
}
@end
