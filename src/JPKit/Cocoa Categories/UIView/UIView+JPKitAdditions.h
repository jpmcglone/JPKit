#import "UIView+JPKitAdditions_FrameShortcuts.h"
#import "UIView+JPKitAdditions_LayerShortcuts.h"

CG_INLINE CGRect
CGRectFromEdgeInsets(CGRect rect, UIEdgeInsets edgeInsets) {
    return CGRectMake(
            rect.origin.x + edgeInsets.left,
            rect.origin.y + edgeInsets.top,
            rect.size.width - edgeInsets.left - edgeInsets.right,
            rect.size.height - edgeInsets.top - edgeInsets.bottom
    );
}