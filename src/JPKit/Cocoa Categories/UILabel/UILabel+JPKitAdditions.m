//
// Created by JP McGlone on 8/30/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "UILabel+JPKitAdditions.h"
#import "NSString+JPKitAdditions.h"

@implementation UILabel (JPKitAdditions)

- (CGSize)jp_sizeConstrainedToSize:(CGSize)size
{
    return [self.text jp_sizeWithFont:self.font constrainedToSize:size];
}

@end
