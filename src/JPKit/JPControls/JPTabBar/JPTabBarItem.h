//
// Created by JP McGlone on 8/30/14.
// Copyright (c) 2014 JP McGlone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPTabBarItem : UIControl

- (id)initWithReusableIdentifier:(NSString *)reusableIdentifier;

@property (nonatomic, readonly) NSString *reusableIdentifier;

@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UIImageView *imageView;

@end