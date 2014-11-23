//
// Created by JP McGlone on 11/22/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITextField (JPKitAdditions)

// sets / returns nil if text is empty
@property (nonatomic, strong) NSString *jp_safeText;

@end