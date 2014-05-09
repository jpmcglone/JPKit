//
// Created by JP McGlone on 5/8/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIColor.h>
#import "UIColor+JPKitAdditions.h"

@interface Tests_UIColor_JPKitAdditions : XCTestCase
@end

@implementation Tests_UIColor_JPKitAdditions

- (void)setUp
{
    [super setUp];
}

- (void)testColors
{
    CGFloat red = 10.0 / 255.0;
    CGFloat green = 20.0 / 255.0;
    CGFloat blue = 30.0 / 255.0;
    CGFloat alpha = 0.5;

    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    XCTAssertTrue(color.jp_red == red);
    XCTAssertTrue(color.jp_green == green);
    XCTAssertTrue(color.jp_blue == blue);
    XCTAssertTrue(color.jp_alpha == alpha);
}

- (void)tearDown
{
    [super tearDown];
}

@end