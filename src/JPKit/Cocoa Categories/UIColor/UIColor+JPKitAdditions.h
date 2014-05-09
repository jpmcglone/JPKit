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
@property (nonatomic, readonly) CGFloat jp_red;
@property (nonatomic, readonly) CGFloat jp_green;
@property (nonatomic, readonly) CGFloat jp_blue;
@property (nonatomic, readonly) CGFloat jp_alpha;

//TODO
//@property (nonatomic, readonly) NSUInteger jp_hexValue;

// Crayola colors as described at
// http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors

// Crayola 8 pack
+ (UIColor *)jp_blackColor;
+ (UIColor *)jp_blueColor;
+ (UIColor *)jp_brownColor;
+ (UIColor *)jp_greenColor;
+ (UIColor *)jp_orangeColor;
+ (UIColor *)jp_redColor;
+ (UIColor *)jp_violetColor;
+ (UIColor *)jp_yellowColor;

// Crayola 16 pack
+ (UIColor *)jp_blueGreenColor;
+ (UIColor *)jp_blueVioletColor;
+ (UIColor *)jp_carnationPinkColor;
+ (UIColor *)jp_redOrangeColor;
+ (UIColor *)jp_redVioletColor;
+ (UIColor *)jp_whiteColor;
+ (UIColor *)jp_yellowGreenColor;
+ (UIColor *)jp_yellowOrangeColor;

// TODO: Crayola 24, 48, 64, 72, 80, 96, 120, packs.
// http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors

@end