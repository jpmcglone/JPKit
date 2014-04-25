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

@property (nonatomic, readonly) id other;

+ (NSDictionary *)template;

- (id)initWithInfo:(id)info;

@end

