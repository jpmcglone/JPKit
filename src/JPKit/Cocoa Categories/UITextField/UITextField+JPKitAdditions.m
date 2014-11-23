//
// Created by JP McGlone on 11/22/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "UITextField+JPKitAdditions.h"

@implementation UITextField (JPKitAdditions)

- (NSString *)jp_safeText
{
    return self.text.length > 0 ? self.text : nil;
}

- (void)setJp_safeText:(NSString *)jp_safeText
{
    self.text = jp_safeText.length > 0 ? jp_safeText : nil;
}

@end