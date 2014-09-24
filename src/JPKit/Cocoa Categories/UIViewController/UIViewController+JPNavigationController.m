//
// Created by JP McGlone on 9/23/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "UIViewController+JPNavigationController.h"

@implementation UIViewController (JPNavigationController)

- (JPNavigationController *)jp_navigationController
{
    UIViewController *parentViewController = self.parentViewController;
    while (parentViewController != nil) {
        if ([parentViewController isKindOfClass:[JPNavigationController class]]) {
            return parentViewController;
        }
        parentViewController = parentViewController.parentViewController;
    }
    return nil;
}

@end