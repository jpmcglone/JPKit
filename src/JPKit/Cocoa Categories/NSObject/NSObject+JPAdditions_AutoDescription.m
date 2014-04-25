//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "NSObject+JPAdditions_AutoDescription.h"
#import <objc/runtime.h>
#import "NSObject+JPAdditions_Reflection.h"

@implementation NSObject (JPAdditions_AutoDescription)

- (NSString *)autoDescriptionForClassType:(Class)classType showNulls:(BOOL)showNulls
{
    NSUInteger count;
    objc_property_t *propList = class_copyPropertyList(classType, &count);
    NSMutableString *propPrint = [NSMutableString string];

    for (int i = 0; i < count; i++) {
        objc_property_t property = propList[i];

        const char *propName = property_getName(property);
        NSString *propNameString = [NSString stringWithCString:propName encoding:NSASCIIStringEncoding];

        if (propName) {
            id value = [self valueForKey:propNameString];
            if (showNulls || value) {
                [propPrint appendString:[NSString stringWithFormat:@"  %@: %@ = %@;\n",
                                                                   [[self class] jp_typeNameForPropertyKey:propNameString],
                                                                   propNameString,
                                                                   value]
                ];
            }
        }
    }
    free(propList);


    // Now see if we need to map any superclasses as well.
    Class superClass = class_getSuperclass(classType);
    if (superClass != nil && ![superClass isEqual:[NSObject class]]) {
        NSString *superString = [self autoDescriptionForClassType:superClass
                                                        showNulls:showNulls];
        [propPrint appendString:superString];
    }

    return propPrint;
}

- (NSString *)autoDescribeShowNulls:(BOOL)showNulls
{
    NSString *headerString = [NSString stringWithFormat:@"\njp_autoDescribe:\n<%@ :%p>\n",
                                                        [self class],
                                                        self];
    NSString *autoDescription = [self autoDescriptionForClassType:[self class]
                                                        showNulls:showNulls];
    return [headerString stringByAppendingString:autoDescription];
}

- (NSString *)jp_autoDescribe
{
    return [self autoDescribeShowNulls:NO];
}

- (NSString *)jp_autoDescribeWithNulls
{
    return [self autoDescribeShowNulls:YES];
}


@end