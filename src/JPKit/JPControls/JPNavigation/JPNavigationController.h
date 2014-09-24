//
// Created by JP McGlone on 9/17/14.
// Copyright (c) 2014 trifl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JPNavigationControllerDirection) {
    JPNavigationControllerDirectionNone,
    JPNavigationControllerDirectionLeft,
    JPNavigationControllerDirectionUp,
    JPNavigationControllerDirectionRight,
    JPNavigationControllerDirectionDown,
    JPNavigationControllerDirectionDownTo,
    JPNavigationControllerDirectionDownFro
};

@class JPNavigationController;
@protocol JPNavigationControllerDelegate <NSObject>

@optional

- (BOOL)navigationController:(JPNavigationController *)controller shouldPopToViewController:(UIViewController *)viewController;
- (void)navigationController:(JPNavigationController *)controller willPopToViewController:(UIViewController *)viewController;
- (void)navigationController:(JPNavigationController *)controller didPopViewController:(UIViewController *)viewController;

- (BOOL)navigationController:(JPNavigationController *)controller shouldPushViewController:(UIViewController *)viewController;
- (void)navigationController:(JPNavigationController *)controller willPushViewController:(UIViewController *)viewController;
- (void)navigationController:(JPNavigationController *)controller didPushFromViewController:(UIViewController *)viewController;

@end

@interface JPNavigationController : UIViewController

@property (nonatomic, weak) id <JPNavigationControllerDelegate> delegate;

// will automatically be sized and get an autoresizingMask, you can change after you set it I suppose
@property (nonatomic, strong) UIView *backgroundView; // none by default, this view controller is clear

@property (nonatomic, readonly) UIViewController *topViewController;
@property (nonatomic, readonly) UIViewController *rootViewController;
@property (nonatomic, readonly) UIViewController *visibleViewController;

@property (nonatomic, assign) JPNavigationControllerDirection pushDirection; // defaults to left
@property (nonatomic, assign) JPNavigationControllerDirection popDirection;  // defaults to right

@property (nonatomic, assign) BOOL fadesWhenTransitioningIn; // defaults to NO
@property (nonatomic, assign) BOOL fadesWhenTransitioningOut; // defaults to NO

@property (nonatomic, assign) BOOL dismissesAutomatically; // defaults to YES, will dismiss after popping if there is nothing left

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)pushViewController:(UIViewController *)viewController;

- (void)popViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion;
- (void)popViewControllerAnimated:(BOOL)animated;
- (void)popViewController;

- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;
- (void)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;
- (void)popToViewController:(UIViewController *)viewController;

- (void)popToRootViewControllerAnimated:(BOOL)animated;
- (void)popToRootViewController;

@end