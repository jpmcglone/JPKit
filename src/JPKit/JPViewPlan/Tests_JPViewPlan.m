//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JPViewPlan.h"

@interface Tests_JPViewPlan : XCTestCase
@property (nonatomic, strong) JPViewPlan *layout;
@property (nonatomic, strong) UIView *view;
@end

@implementation Tests_JPViewPlan

- (void)setUp
{
    [super setUp];

    self.layout = [[JPViewPlan alloc] init];
    self.layout.x = 3;
    self.layout.y = 4;
    self.layout.width = 5;
    self.layout.height = 6;
    
    self.view = [[UIView alloc] init];
    self.layout.view = self.view;
}

- (void)testLayoutModel
{
    XCTAssertTrue(self.layout.x == 3);
    XCTAssertTrue(self.layout.y == 4);
    XCTAssertTrue(self.layout.width == 5);
    XCTAssertTrue(self.layout.height == 6);
    
    [self.layout commit];
    XCTAssertTrue(self.view.frame.origin.x == 3);
    XCTAssertTrue(self.view.frame.origin.y == 4);
    XCTAssertTrue(self.view.frame.size.width == 5);
    XCTAssertTrue(self.view.frame.size.height == 6);
}

- (void)tearDown
{
    [super tearDown];
}

@end
