//
// Created by JP McGlone on 9/17/14.
// Copyright (c) 2014 trifl. All rights reserved.
//

#import "JPNavigationController.h"
#import "UIView+JPKitAdditions.h"
#import "UIViewController+JPKitAdditions.h"

static CGFloat const kJPNavigationControllerAnimationDuration = 0.3141592;

@implementation JPNavigationController {
    UIView *_containerView;
    UIButton *_backButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _pushDirection = JPNavigationControllerDirectionLeft;
        _popDirection = JPNavigationControllerDirectionRight;
        _dismissesAutomatically = YES;
        [self createContainerView];
        [self createBackButton];
        // TODO: add (optional) title label
    }
    return self;
}

- (void)createBackButton
{
    // TODO: graphics, animations
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backButton setTitle:@"back" forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];

    [_backButton sizeToFit];
    _backButton.jp_origin = CGPointMake(20, 20);
    _backButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
}

- (void)createContainerView
{
    _containerView = [[UIView alloc] init];
    _containerView.backgroundColor = [UIColor clearColor];
    _containerView.clipsToBounds = NO;
    _containerView.frame = self.view.bounds;
    _containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_containerView];
}

- (UIViewController *)topViewController
{
    UIViewController *topViewController = nil;
    NSUInteger count = self.childViewControllers.count;
    if (count > 0) {
        topViewController = self.childViewControllers[count - 1];
    }
    return topViewController;
}

- (UIViewController *)rootViewController
{
    UIViewController *rootViewController = nil;
    if (self.childViewControllers.count > 0) {
        rootViewController = self.childViewControllers[0];
    }
    return rootViewController;
}

- (CGRect)offsetFrameForDirection:(JPNavigationControllerDirection)direction
{
    CGRect frame = _containerView.bounds;
    switch (direction) {
        case JPNavigationControllerDirectionLeft:
            frame.origin.x += _containerView.jp_width;
            break;
        case JPNavigationControllerDirectionRight:
            frame.origin.x -= _containerView.jp_width;
            break;
        case JPNavigationControllerDirectionUp:
            frame.origin.y += _containerView.jp_height;
            break;
        case JPNavigationControllerDirectionDown:
            frame.origin.y -= _containerView.jp_height;
            break;
        default:
            break;
    }
    return frame;
}

+ (JPNavigationControllerDirection)directionOppositeOfDirection:(JPNavigationControllerDirection)direction
{
    switch (direction) {
        case JPNavigationControllerDirectionNone:
            return JPNavigationControllerDirectionNone;
        case JPNavigationControllerDirectionRight:
            return JPNavigationControllerDirectionLeft;
        case JPNavigationControllerDirectionLeft:
            return JPNavigationControllerDirectionRight;
        case JPNavigationControllerDirectionUp:
            return JPNavigationControllerDirectionDown;
        case JPNavigationControllerDirectionDown:
            return JPNavigationControllerDirectionUp;
        case JPNavigationControllerDirectionDownTo:
            return JPNavigationControllerDirectionDownFro;
        case JPNavigationControllerDirectionDownFro:
            return JPNavigationControllerDirectionDownTo;
    }
}

- (void)transitionToViewController:(UIViewController *)viewController
                          animated:(BOOL)animated
                         direction:(JPNavigationControllerDirection)direction
                        completion:(void (^)(void))completion
{
    // TODO: disable view when transitioning?

    // forces the first responder to go away before the animations even begin
    [self.view endEditing:NO];

    viewController.view.frame = _containerView.bounds;
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_containerView addSubview:viewController.view];

    // New VC initial frame
    viewController.view.frame = [self offsetFrameForDirection:direction];
    viewController.view.alpha = _fadesWhenTransitioningIn ? 0 : 1;

    [UIView jp_animateWithDuration:kJPNavigationControllerAnimationDuration
                             delay:0
                           options:UIViewAnimationOptionBeginFromCurrentState
                        animations:^{
                            // Old VC final frame
                            if (_visibleViewController != nil) {
                                JPNavigationControllerDirection oppositeDirection = [[self class] directionOppositeOfDirection:direction];
                                _visibleViewController.view.frame = [self offsetFrameForDirection:oppositeDirection];
                                _visibleViewController.view.alpha = _fadesWhenTransitioningOut ? 0 : 1;
                            }

                            // New VC final frame
                            viewController.view.frame = _containerView.bounds;
                            viewController.view.alpha = 1;
                        }
                        completion:^
                        (BOOL finished) {
                            [_visibleViewController.view removeFromSuperview];
                            _visibleViewController = viewController;
                            if (completion) {
                                completion();
                            }
                        }];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion notifiesDelegate:(BOOL)notifiesDelegate
{
    if (notifiesDelegate && [_delegate respondsToSelector:@selector(navigationController:shouldPushViewController:)]) {
        BOOL shouldPush = [_delegate navigationController:self shouldPushViewController:viewController];
        if (!shouldPush) {
            return;
        }
    }

    if (viewController == nil) {
        NSAssert(viewController != nil, @"You cannot push a nil viewController");
        return;
    }

    UIViewController *previousViewController = _visibleViewController;

    if (notifiesDelegate && [_delegate respondsToSelector:@selector(navigationController:willPushViewController:)]) {
        [_delegate navigationController:self willPushViewController:viewController];
    }
    [self addChildViewController:viewController];
    [self transitionToViewController:viewController
                            animated:animated
                           direction:_pushDirection
                          completion:^{
                              [viewController didMoveToParentViewController:self];
                              if (notifiesDelegate && [_delegate respondsToSelector:@selector(navigationController:didPushFromViewController:)]) {
                                  [_delegate navigationController:self didPushFromViewController:previousViewController];
                              }
                              if (completion) {
                                  completion();
                              }
                          }];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    [self pushViewController:viewController animated:animated completion:completion notifiesDelegate:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self pushViewController:viewController animated:animated completion:nil];
}

- (void)pushViewController:(UIViewController *)viewController
{
    [self pushViewController:viewController animated:YES];
}

- (void)popViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion notifiesDelegate:(BOOL)notifiesDelegate
{
    UIViewController *viewController = nil;
    NSUInteger count = self.childViewControllers.count;
    if (count > 1) {
        viewController = self.childViewControllers[count - 2];
    }
    [self popToViewController:viewController animated:animated completion:completion notifiesDelegate:notifiesDelegate];
}

- (void)popViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    [self popViewControllerAnimated:animated completion:completion notifiesDelegate:YES];
}

- (void)popViewControllerAnimated:(BOOL)animated
{
    [self popViewControllerAnimated:animated completion:nil];
}

- (void)popViewController
{
    [self popViewControllerAnimated:YES];
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion notifiesDelegate:(BOOL)notifiesDelegate
{
    if (notifiesDelegate && [_delegate respondsToSelector:@selector(navigationController:shouldPopToViewController:)]) {
        BOOL shouldPop = [_delegate navigationController:self shouldPopToViewController:viewController];
        if (!shouldPop) {
            return;
        }
    }

    if(self.topViewController == viewController) {
        NSLog(@"Attempted to pop to the view controller that is already on top");
        return;
    }

    if(viewController == nil || [self.childViewControllers containsObject:viewController]) {
        NSUInteger count = self.childViewControllers.count;
        // we can assume based on the previous logic that this will always resolve
        UIViewController *underTopViewController = count > 1 ? self.childViewControllers[count - 2] : nil;

        while (viewController != nil && underTopViewController != viewController) {
           [self.topViewController willMoveToParentViewController:nil];
           [self transitionToViewController:underTopViewController animated:NO direction:_popDirection completion:nil];
           [self.topViewController removeFromParentViewController];
           underTopViewController = self.childViewControllers[count - 1];
        }

        // underTopViewController is now the viewController
        if (notifiesDelegate && [_delegate respondsToSelector:@selector(navigationController:willPopToViewController:)]) {
            [_delegate navigationController:self willPopToViewController:underTopViewController];
        }
        UIViewController *previousViewController = self.topViewController;
        [previousViewController willMoveToParentViewController:nil];
        [self transitionToViewController:underTopViewController
                                animated:animated
                               direction:_popDirection
                              completion:^{
                                  [previousViewController removeFromParentViewController];
                                  if (notifiesDelegate && [_delegate respondsToSelector:@selector(navigationController:didPopViewController:)]) {
                                      [_delegate navigationController:self didPopViewController:self.visibleViewController];
                                  }
                                  if (viewController == nil && _dismissesAutomatically) {
                                      [self jp_dismissAnimated:animated];
                                  }
                                  if (completion) {
                                      completion();
                                  }
                              }];
    } else {
        NSLog(@"The view controller you wanted to pop to doesn't exist");
    }
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion
{
    [self popToViewController:viewController animated:animated completion:completion notifiesDelegate:YES];
}

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self popToViewController:viewController animated:animated completion:nil];
}

- (void)popToViewController:(UIViewController *)viewController
{
    [self popToViewController:viewController animated:YES];
}

- (void)popToRootViewControllerAnimated:(BOOL)animated
{
    [self popToViewController:self.rootViewController animated:animated];
}

- (void)popToRootViewController
{
    [self popToRootViewControllerAnimated:YES];
}

@end