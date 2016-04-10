//
//  ProjectInfo.h
//  Project1
//
//  Created by Student on 10/29/15.
//  Copyright (c) 2015 Anel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Project : NSObject
@property NSString *projectTitle;
@property int likes;
@property int views;
@property NSString *fieldName;
@property NSString *desc;
@property NSString *tags;
@property PFObject *host;
@end
