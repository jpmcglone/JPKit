//
// Created by JP McGlone on 4/25/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "NSObject+JPKitAdditions_AutoDescription.h"
#import <objc/runtime.h>
#import "NSObject+JPKitAdditions_Reflection.h"

@implementation NSObject (JPKitAdditions_AutoDescription)

- (NSString *)jp_autoDescribeForClassType:(Class)classType withAddresses:(BOOL)withAddresses showsNulls:(BOOL)showsNulls
{
    unsigned int count;
    objc_property_t *propList = class_copyPropertyList(classType, &count);
    NSMutableString *propPrint = [NSMutableString string];
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propList[i];
        
        const char *propName = property_getName(property);
        NSString *propNameString = [NSString stringWithCString:propName encoding:NSASCIIStringEncoding];
        
        if (propName) {
            id value;
            if ([self respondsToSelector:NSSelectorFromString(propNameString)]) {
                value = [self valueForKey:propNameString];
            }
            
            if (showsNulls || value) {
                if (withAddresses) {
                    [propPrint appendString:[NSString stringWithFormat:@"    <%@: %p>: %@ = %@;\n",
                                             [[self class] jp_typeNameForPropertyKey:propNameString],
                                             value,
                                             propNameString,
                                             value]
                     ];
                } else {
                    [propPrint appendString:[NSString stringWithFormat:@"    %@: %@ = %@;\n",
                                             [[self class] jp_typeNameForPropertyKey:propNameString],
                                             propNameString,
                                             value]
                    ];
                }
            }
        }
    }
    free(propList);
    
    
    // Now see if we need to map any superclasses as well.
    Class superClass = class_getSuperclass(classType);
    if (superClass != nil && ![superClass isEqual:[NSObject class]]) {
        NSString *superString = [self jp_autoDescribeForClassType:superClass
                                                    withAddresses:withAddresses
                                                       showsNulls:showsNulls];
        [propPrint appendString:superString];
    }
    
    NSString *headerString = [NSString stringWithFormat:@"\njp_autoDescribe:\n<%@ :%p>\n",
                              [self class],
                              self];
    return [headerString stringByAppendingString:propPrint];
    return propPrint;
}

- (NSString *)jp_autoDescribeWithAddresses:(BOOL)withAddresses showsNulls:(BOOL)showsNulls
{
    return [self jp_autoDescribeForClassType:[self class] withAddresses:withAddresses showsNulls:showsNulls];
}

- (NSString *)jp_autoDescribeWithAddresses:(BOOL)withAddresses
{
    return [self jp_autoDescribeWithAddresses:withAddresses showsNulls:NO];
}

- (NSString *)jp_autoDescribe
{
    return [self jp_autoDescribeWithAddresses:NO];
}


@end