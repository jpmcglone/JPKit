//
// Created by JP McGlone on 4/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "JPModel.h"
#import <CoreGraphics/CGGeometry.h>

typedef struct CustomStruct{
    int r;
    int c;
}CustomStruct;

@interface Person : JPModel

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSNumber *age;
@property (nonatomic, readonly) NSNumber *personID;
@property (nonatomic, readonly) Person *firstBorn;
@property (nonatomic, readonly) NSArray *parents;

// Just for testing the different @encode() with autoDescribe
@property (nonatomic, readonly) int anInt;
@property (nonatomic, readonly) BOOL aBOOL;
@property (nonatomic, readonly) bool aBool;
@property (nonatomic, readonly) short aShort;
@property (nonatomic, readonly) long aLong;
@property (nonatomic, readonly) long long aLongLong;
@property (nonatomic, readonly) unsigned char anUnsignedChar;
@property (nonatomic, readonly) unsigned int anUnsignedInt;
@property (nonatomic, readonly) unsigned short anUnsignedShort;
@property (nonatomic, readonly) unsigned long anUnsignedLong;
@property (nonatomic, readonly) unsigned long long anUnsignedLongLong;
@property (nonatomic, readonly) float aFloat;
@property (nonatomic, readonly) double aDouble;
@property (nonatomic, readonly) id anID;
@property (nonatomic, readonly) Class aClassObject;
@property (nonatomic, readonly) NSArray *anArray;
@property (nonatomic, readonly) CGPoint aCGPoint;
@property (nonatomic, readonly) CGRect aCGRect;
@property (nonatomic, readonly) CustomStruct aCustomStruct;

@end