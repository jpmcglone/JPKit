//
//  JPSoundManager.h
//  JPKit
//
//  Created by JP McGlone on 2/15/15.
//  Copyright (c) 2015 JP McGlone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface JPSoundManager : NSObject

// Default extension is .mp3
// sound file format: filename.ext

+ (JPSoundManager *)sharedManager;

- (SystemSoundID)cacheSound:(NSString *)soundFile;
- (void)playSound:(NSString *)soundFile;
- (void)removeSound:(NSString *)soundFile;

@end
