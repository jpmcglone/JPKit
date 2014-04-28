//
// Created by JP McGlone on 4/27/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UIColorFromHex( hexValue, a ) \
        [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
                        green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
                         blue:((float)(hexValue & 0xFF))/255.0 \
                        alpha:a]

#define UIColorFromRGB( red, green, blue, alpha ) \
        [UIColor colorWithRed:((float)red)/255.0 \
                        green:((float)green)/255.0 \
                         blue:((float)blue)/255.0 \
                        alpha:alpha]

@interface UIColor (JPKitAdditions)

@end