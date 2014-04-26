//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"
#import "NSObject+JPAdditions_AutoDescription.h"

@interface Tests_NSObject_JPAdditions_AutoDescription : XCTestCase
@property (nonatomic, strong) Person *person;
@end

@implementation Tests_NSObject_JPAdditions_AutoDescription

- (void)setUp
{
    [super setUp];
    NSDictionary *info = @{@"name" : @"JP", @"age" : @(25)};
    self.person = [[Person alloc] initWithInfo:info];
}

- (void)testAutoDescription
{
    // TODO: make real tests
    NSString *autoDescribe1 = [self.person jp_autoDescribe];
    NSString *autoDescribe2 = [self.person jp_autoDescribeWithAddresses:NO showsNulls:YES];

    XCTAssertTrue([autoDescribe1 length] < [autoDescribe2 length]);
}

- (void)tearDown
{
    [super tearDown];
}
@end