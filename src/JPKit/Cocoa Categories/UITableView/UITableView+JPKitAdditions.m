//
//  UITableView+UITableView_JPKitAdditions.m
//  JPKit
//
//  Created by JP McGlone on 12/31/14.
//  Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "UITableView+JPKitAdditions.h"

@implementation UITableView (JPKitAdditions)

-(void)jp_scrollToTopAnimated:(BOOL)animated scrollFinished:(void (^)())scrollFinished
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:scrollFinished];

    [self beginUpdates];
    [self setContentOffset:CGPointZero animated:animated];
    [self endUpdates];

    [CATransaction commit];
}

-(void)jp_scrollToRowAtIndexPath:(NSIndexPath *)indexPath
             atScrollPosition:(UITableViewScrollPosition)scrollPosition
                     animated:(BOOL)animated
               scrollFinished:(void (^)())scrollFinished
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:scrollFinished];

    [self beginUpdates];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
    [self endUpdates];

    [CATransaction commit];
}

@end
