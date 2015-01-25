//
//  JPTextView.h
//  JPKit
//
//  Created by JP McGlone on 1/24/15.
//  Copyright (c) 2015 JP McGlone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
