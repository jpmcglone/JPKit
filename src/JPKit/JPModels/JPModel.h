//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPModel : NSObject

#ifdef JPDEBUG
// a reference to the info that originally generated this model. Only available with the preprocessor flag JPDEBUG
@property (nonatomic, readonly) id info;
#endif

// TODO: Converts the model into JSON (NSDictionary / NSArray), includes 'other'
//@property (nonatomic, readonly) id JSON;

@property (nonatomic, readonly) NSUInteger iid;
@property (nonatomic, readonly) NSString *sid;
@property (nonatomic, readonly) id other;

// Overrides for things like property name, class, and if it's plural or not
// e.g.
// @{@"children":@{@"class":@"Person",@"isPlural":@(YES),@"name":@"theChildren"},
//   @"spouse":@{@"class":@"Person"}}
// -- defaults -- class:class in model, isPlural:NO, name:name in data
+ (NSDictionary *)specs;

- (id)initWithInfo:(id)info;

@end

