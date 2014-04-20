//
// Created by JP McGlone on 4/19/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+JPKitFrameAdditions.h"

@interface Tests_UIView_JPKitFrameAdditions : XCTestCase
@property(nonatomic, strong) UIView *view;
@end

@implementation Tests_UIView_JPKitFrameAdditions

- (void)setUp {
    [super setUp];
    self.view = [UIView new];
}

- (void)testSetters {
    self.view.x = 10;
    self.view.y = 20;
    self.view.width = 30;
    self.view.height = 40;

    XCTAssert(
    CGRectEqualToRect(
            self.view.frame,
            CGRectMake(
                    10,
                    20,
                    30,
                    40
            )
    )
    );
}

- (void)tearDown {
    [super tearDown];
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

@end