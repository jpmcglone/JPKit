//
//  UITableView+UITableView_JPKitAdditions.h
//  JPKit
//
//  Created by JP McGlone on 12/31/14.
//  Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (JPKitAdditions)

-(void)jp_scrollToRowAtIndexPath:(NSIndexPath *)indexPath
                atScrollPosition:(UITableViewScrollPosition)scrollPosition
                        animated:(BOOL)animated
                  scrollFinished:(void (^)())scrollFinished;
-(void)jp_scrollToTopAnimated:(BOOL)animated scrollFinished:(void (^)())scrollFinished;

@end
