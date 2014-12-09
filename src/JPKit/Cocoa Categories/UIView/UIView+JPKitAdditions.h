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

@property (nonatomic, readonly) id jp_firstResponder;

// If delay and duration is 0, it does it on the same run loop
+ (void)jp_animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (void)jp_animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (void)jp_animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations;
+ (void)jp_animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (void)jp_animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations;

@end