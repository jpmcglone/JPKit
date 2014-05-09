//
// Created by JP McGlone on 4/27/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "UIColor+JPKitAdditions.h"

@implementation UIColor (JPKitAdditions)

- (CGFloat const *)components
{
    CGColorRef color = self.CGColor;
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color)) != kCGColorSpaceModelRGB) {
        return NULL;
    }
    return CGColorGetComponents(color);
}

#pragma mark - red
- (CGFloat)jp_red
{
    CGFloat const *components = [self components];
    return components ? components[0] : -1;
}

#pragma mark - green
- (CGFloat)jp_green
{
    CGFloat const *components = [self components];
    return components ? components[1] : -1;
}

#pragma mark - blue
- (CGFloat)jp_blue
{
    CGFloat const *components = [self components];
    return components ? components[2] : -1;
}

#pragma mark - alpha
- (CGFloat)jp_alpha
{
    return CGColorGetAlpha(self.CGColor);
}

#pragma mark - hexValue
- (NSUInteger)jp_hexValue
{
    // TODO
    return 0;
}

#pragma mark - Crayola Colors
#pragma mark - 8 pack
+ (UIColor *)jp_blackColor
{
    return UIColorFromHex(0x000000, 1.0);
}

+ (UIColor *)jp_blueColor
{
    return UIColorFromHex(0x1F75FE, 1.0);
}

+ (UIColor *)jp_brownColor
{
    return UIColorFromHex(0xB4674D, 1.0);
}

+ (UIColor *)jp_greenColor
{
    return UIColorFromHex(0x1CAC78, 1.0);
}

+ (UIColor *)jp_orangeColor
{
    return UIColorFromHex(0xFF7538, 1.0);
}

+ (UIColor *)jp_redColor
{
    return UIColorFromHex(0xEE204D, 1.0);
}

+ (UIColor *)jp_violetColor
{
    return UIColorFromHex(0x926EAE, 1.0);
}

+ (UIColor *)jp_yellowColor
{
    return UIColorFromHex(0xFCE883, 1.0);
}

#pragma mark - 16 pack
+ (UIColor *)jp_blueGreenColor
{
    return UIColorFromHex(0x0D98BA, 1.0);
}

+ (UIColor *)jp_blueVioletColor
{
    return UIColorFromHex(0x7366BD, 1.0);
}

+ (UIColor *)jp_carnationPinkColor
{
    return UIColorFromHex(0xFFAACC, 1.0);
}

+ (UIColor *)jp_redOrangeColor
{
    return UIColorFromHex(0xFF5349, 1.0);
}

+ (UIColor *)jp_redVioletColor
{
    return UIColorFromHex(0xC0448F, 1.0);
}

+ (UIColor *)jp_whiteColor
{
    return UIColorFromHex(0xFFFFFF, 1.0);
}

+ (UIColor *)jp_yellowGreenColor
{
    return UIColorFromHex(0xC5E384, 1.0);
}

+ (UIColor *)jp_yellowOrangeColor
{
    return UIColorFromHex(0xFFAE42, 1.0);
}

@end