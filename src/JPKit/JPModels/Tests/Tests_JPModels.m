//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+JPAdditions.h"
#import "Person.h"
#import "JPModelMapManager.h"
#import "JPModelManager.h"

@interface Tests_JPModels : XCTestCase
@property (nonatomic, strong) NSString *JSONString;
@end

@implementation Tests_JPModels

- (void)setUp
{
    [super setUp];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *filePath = [bundle pathForResource:@"people"
                                          ofType:@"json"];
    self.JSONString = [NSString stringWithContentsOfFile:filePath
                                                encoding:NSUTF8StringEncoding
                                                   error:nil];
}

- (void)testJSON
{
    NSDictionary *JSON = self.JSONString.JSON;
    XCTAssertTrue([JSON[@"people"] isKindOfClass:[NSArray class]]);
}

- (void)testModelCreation
{
    JPModelMapManager *mapManager = [JPModelMapManager sharedManager];

    NSArray *personModelMaps = [JPModelMap mapsWithSingularKey:@"person"
                                                     pluralKey:@"people"
                                                         class:[Person class]];

    [mapManager addModelMaps:personModelMaps];

    XCTAssertTrue(nil != [mapManager mapForKey:@"people"]);
    XCTAssertTrue(nil != [mapManager mapForKey:@"person"]);

    id info = [JPModelManager modelsFromJSON:self.JSONString.JSON];
    XCTAssertTrue([info[@"person"] isKindOfClass:[Person class]]);
    XCTAssertTrue([info[@"people"][1] isKindOfClass:[Person class]]);
    XCTAssertTrue([info[@"some_object"][@"some_number"] integerValue] == 1);
}

- (void)testInitWithInfo1
{
    NSDictionary *info = @{@"name" : @"JP", @"age" : @(25)};
    Person *person = [[Person alloc] initWithInfo:info];
    XCTAssertTrue([person.name isEqualToString:@"JP"]);
    XCTAssertTrue(person.age.integerValue == 25);
}

- (void)testInitWithInfo2
{
    NSDictionary *info = @{@"id" : @(123), @"name" : @"JP"};
    Person *person = [[Person alloc] initWithInfo:info];
    XCTAssertTrue([person.name isEqualToString:@"JP"]);
    XCTAssertTrue(person.age == nil);
    XCTAssertTrue(person.personID.integerValue == 123);
}

- (void)testModelOther
{
    NSDictionary *info = @{@"id" : @(123), @"name" : @"JP", @"something" : @"else"};
    Person *person = [[Person alloc] initWithInfo:info];
    XCTAssertTrue([person.other[@"something"] isEqualToString:@"else"]);
}

- (void)testNestedModels
{
    NSDictionary *info = @{@"id" : @(123),
                           @"name" : @"JP",
                           @"something" : @"else",
                           @"firstBorn" : @{@"name" : @"Topanga", @"age" : @(3)}
                           };
    
    Person *person = [[Person alloc] initWithInfo:info];
    XCTAssertTrue([person.other[@"something"] isEqualToString:@"else"]);
    XCTAssertTrue([person.firstBorn.name isEqualToString:@"Topanga"]);
}

- (void)tearDown
{
    [super tearDown];
    self.JSONString = nil;
}

@end