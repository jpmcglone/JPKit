//
// Created by JP McGlone on 9/21/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import "UIViewController+JPKitAdditions.h"
#import "UIView+JPKitAdditions.h"

@implementation UIViewController (JPKitAdditions)

- (void)jp_presentInView:(UIView *)inView animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if (inView == nil) {
        // TODO: create a JPKit method for returning the main window in case this changes, or doesn't work with things like
        // keyboards, etc.
        inView = [UIApplication sharedApplication].windows[0];
    }

    self.view.alpha = 0;
    self.view.frame = inView.bounds;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [inView addSubview:self.view];

    [UIView jp_animateWithDuration:0.214 animations:^{
        self.view.alpha = 1;
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)jp_presentInView:(UIView *)view animated:(BOOL)animated
{
    [self jp_presentInView:view animated:animated completion:nil];
}

- (void)jp_presentInView:(UIView *)view
{
    [self jp_presentInView:view animated:YES];
}

- (void)jp_present
{
    [self jp_presentInView:nil];
}

- (void)jp_dismissAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{
    if (self.parentViewController) {
        [self.parentViewController jp_dismissAnimated:animated completion:completion];
    } else {
        [UIView jp_animateWithDuration:0.214 animations:^{
            self.view.alpha = 0;
        }                   completion:^(BOOL finished) {
            [self.view removeFromSuperview];
            if (completion) {
                completion(finished);
            }
        }];
    }
}

- (void)jp_dismissAnimated:(BOOL)animated
{
    [self jp_dismissAnimated:animated completion:nil];
}

- (void)jp_dismiss
{
    [self jp_dismissAnimated:YES];
}

@end
