//
// Created by JP McGlone on 4/19/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+JPKitAdditions_FrameShortcuts.h"

@interface Tests_UIView_JPKitFrameAdditions : XCTestCase
@property (nonatomic, strong) UIView *view;
@end

@implementation Tests_UIView_JPKitFrameAdditions

- (void)setUp
{
    [super setUp];
    self.view = [UIView new];
}

- (void)testSetters
{
    self.view.jp_x = 10;
    XCTAssert(CGRectEqualToRect(self.view.frame, CGRectMake(10, 0, 0, 0)));

    self.view.jp_y = 20;
    XCTAssert(CGRectEqualToRect(self.view.frame, CGRectMake(10, 20, 0, 0)));

    self.view.jp_width = 30;
    XCTAssert(CGRectEqualToRect(self.view.frame, CGRectMake(10, 20, 30, 0)));

    self.view.jp_height = 40;
    XCTAssert(CGRectEqualToRect(self.view.frame, CGRectMake(10, 20, 30, 40)));

    self.view.jp_origin = CGPointMake(20, 10);
    XCTAssert(CGRectEqualToRect(self.view.frame, CGRectMake(20, 10, 30, 40)));

    self.view.jp_size = CGSizeMake(40, 30);
    XCTAssert(CGRectEqualToRect(self.view.frame, CGRectMake(20, 10, 40, 30)));

    //TODO: top, jp_bottom, jp_left, jp_right
}

- (void)testBeginEndUpdates
{
    [self.view jp_beginFrameUpdates];
    self.view.jp_x = 10;
    XCTAssertFalse(CGRectEqualToRect(self.view.frame, CGRectMake(10, 0, 0, 0)));
    self.view.jp_y = 10;
    [self.view jp_endFrameUpdates];
    XCTAssertTrue(CGRectEqualToRect(self.view.frame, CGRectMake(10, 10, 0, 0)));
}

- (void)tearDown
{
    [super tearDown];
    self.view = nil;
}

@end