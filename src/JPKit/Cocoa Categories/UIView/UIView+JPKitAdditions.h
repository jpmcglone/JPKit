#import "UIView+JPKitAdditions_FrameShortcuts.h"
#import "UIView+JPKitAdditions_LayerShortcuts.h"

#import <UIKit/UIKit.h>

CG_INLINE CGRect
CGRectFromEdgeInsets(CGRect rect, UIEdgeInsets edgeInsets) {
    return CGRectMake(
            rect.origin.x + edgeInsets.left,
            rect.origin.y + edgeInsets.top,
            rect.size.width - edgeInsets.left - edgeInsets.right,
            rect.size.height - edgeInsets.top - edgeInsets.bottom
    );
}

@interface UIView (JPKitAdditions)

@property (nonatomic, readonly) UIView *jp_firstResponder;

// Next and previous first responder use the y value in the window, not the respective views. Much better results!
// TODO: caching, to speed things up
@property (nonatomic, readonly) UIView *jp_nextFirstResponder;
@property (nonatomic, readonly) UIView *jp_previousFirstResponder;

- (void)jp_goToNextFirstResponder;
- (void)jp_goToPreviousFirstResponder;

- (UIView *)jp_oldestAncestorOfClass:(Class)theClass;
- (UIView *)jp_youngestAncestorOfClass:(Class)theClass;

// If delay and duration is 0, it does it on the same run loop
+ (void)jp_animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (void)jp_animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (void)jp_animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations;
+ (void)jp_animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (void)jp_animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations;

@end