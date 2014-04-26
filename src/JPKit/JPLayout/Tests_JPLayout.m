//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JPLayoutModel.h"

@interface Tests_JPLayout : XCTestCase
@property (nonatomic, strong) JPLayoutModel *layout;
@property (nonatomic, strong) UIView *view;
@end

@implementation Tests_JPLayout

- (void)setUp
{
    [super setUp];

    NSDictionary *info = @{
            @"x" : @(3),
            @"y" : @(4),
            @"width" : @(5),
            @"height" : @(6)
    };

    self.layout = [[JPLayoutModel alloc] initWithInfo:info];
    self.view = [[UIView alloc] init];
    self.layout.view = self.view;
}

- (void)testInfo
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