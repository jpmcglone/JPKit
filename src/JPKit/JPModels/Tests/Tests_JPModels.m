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
@property(nonatomic, strong) NSString *JSONString;
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

- (void)tearDown
{
    [super tearDown];
    self.JSONString = nil;
}

@end