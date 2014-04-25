//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPModel.h"

@interface Person : JPModel

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSNumber *age;
@property (nonatomic, readonly) NSNumber *personID;

@end