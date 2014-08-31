//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (JPKitAdditions)

@property (nonatomic, readonly) NSDictionary *jp_JSON;

- (BOOL)jp_containsString:(NSString *)string;
- (CGSize)jp_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end