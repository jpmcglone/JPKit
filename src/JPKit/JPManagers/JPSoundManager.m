//
//  JPSoundManager.m
//  JPKit
//
//  Created by JP McGlone on 2/15/15.
//  Copyright (c) 2015 JP McGlone. All rights reserved.
//

#import "JPSoundManager.h"

@implementation JPSoundManager {
    NSMutableDictionary *_sounds;
}

+ (JPSoundManager *)sharedManager
{
    static JPSoundManager *sharedManager = nil;
    if (!sharedManager) {
        sharedManager = [[JPSoundManager alloc] init];
    }
    return sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        _sounds = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (SystemSoundID)cacheSound:(NSString *)soundFile
{
    if (!soundFile) {
        return 0;
    }
    soundFile = [self fixedSoundFileName:soundFile];

    NSNumber *soundID = [self soundIDForSoundFile:soundFile];
    if (soundID) {
        return [soundID integerValue];
    }

    NSString *path  = [self pathForSoundFile:soundFile];
    NSURL *pathURL = [NSURL fileURLWithPath : path];
    SystemSoundID sid;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &sid);
    _sounds[soundFile] = @(sid);
    return sid;
}

- (void)playSound:(NSString *)soundFile
{
    if (!soundFile) {
        return;
    }
    soundFile = [self fixedSoundFileName:soundFile];

    if (_sounds[soundFile]) {
        NSNumber *soundID = [self soundIDForSoundFile:soundFile];
        SystemSoundID sid;
        if (!soundID) sid = [self cacheSound:soundFile];
        else sid = [soundID integerValue];
        AudioServicesPlaySystemSound(sid);
    }
}

- (void)removeSound:(NSString *)soundFile
{
    if (!soundFile) {
        return;
    }
    soundFile = [self fixedSoundFileName:soundFile];

    SystemSoundID sid = [self soundIDForSoundFile:soundFile];
    AudioServicesDisposeSystemSoundID(sid);
    [_sounds removeObjectForKey:soundFile];
}

- (NSArray *)componentsOfSoundFile:(NSString *)soundFile
{
    return [soundFile componentsSeparatedByString:@"."];
}

- (NSString *)fixedSoundFileName:(NSString *)soundFile
{
    soundFile = [soundFile stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSArray *soundFileComponents = [self componentsOfSoundFile:soundFile];

    if (soundFileComponents.count == 1) {
        // make it .mp3
        soundFile = [NSString stringWithFormat:@"%@.mp3", soundFileComponents[0]];
    } else if(soundFileComponents.count == 2) {
        // Keep the sound file as it is
    } else {
        // TODO: 0 or more than 2, error?
    }
    return soundFile;
}

- (NSNumber *)soundIDForSoundFile:(NSString *)soundFile
{
    return _sounds[soundFile];
}

- (NSString *)pathForSoundFile:(NSString *)soundFile
{
    NSArray *components = [self componentsOfSoundFile:soundFile];
    return [[NSBundle mainBundle] pathForResource:components[0] ofType:components[1]];
}

@end
