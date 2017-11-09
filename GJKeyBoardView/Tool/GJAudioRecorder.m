//
//  GJAudioRecorder.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/12.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "GJAudioRecorder.h"
#import <AVFoundation/AVFoundation.h>

@interface GJAudioRecorder ()<AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, copy) void (^volumnChangeBlock)(CGFloat volumn);
@property (nonatomic, copy) void (^completeBlock)(NSString *filePath, CGFloat time);
@property (nonatomic, copy) void (^cancelBlock)(void);
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *filePath;

@end
@implementation GJAudioRecorder
+ (instancetype)shareRecorder {
    static GJAudioRecorder *audioRecorder;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioRecorder = [[self alloc] init];
    });
    return audioRecorder;
}

#pragma mark - AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    if (flag) {
//        NSLog(@"成功");
    }else {
//        NSLog(@"失败");
    }
}

- (void)startRecordWithVolumnChanged: (void(^)(CGFloat volumn))volumnChangeBlock complete: (void(^)(NSString *filePath, CGFloat time))completeBlock cancel: (void(^)(void))cancelBlock {
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:self.filePath error:nil];
    }
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    if (!error) {
        [session setActive:true error:nil];
    }else{
        NSLog(@"session init error: %@", error.description);
    }
    
    self.volumnChangeBlock = volumnChangeBlock;
    self.completeBlock = completeBlock;
    self.cancelBlock = cancelBlock;
    [self.audioRecorder prepareToRecord];
    [self.audioRecorder record];
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updatePower) userInfo:nil repeats:true];
    
}

- (void)updatePower{
    [self.audioRecorder updateMeters];
     CGFloat peakPower = pow(10, 0.05 * ([self.audioRecorder peakPowerForChannel: 0]));
    self.volumnChangeBlock(peakPower);
}

- (void)stopRecord {
    
    [self.timer invalidate];
    self.timer = nil;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];  
    [session setActive:YES error:nil];
    CGFloat time = self.audioRecorder.currentTime;
    [self.audioRecorder stop];

    if (self.completeBlock) {
        self.completeBlock(self.filePath, time);
        self.completeBlock = nil;
    }
}

- (void)cancelRecord {
    [self.timer invalidate];
    self.timer = nil;
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.filePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:self.filePath error:nil];
    }
}
- (AVAudioRecorder *)audioRecorder {
    if (!_audioRecorder) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *error;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        if (!error) {
            [session setActive:true error:nil];
        }else{
            NSLog(@"session init error: %@", error.description);
        }
        NSMutableDictionary *settingDict = [NSMutableDictionary dictionary];
        settingDict[AVNumberOfChannelsKey] = @1;
        settingDict[AVSampleRateKey] = @44100;
        settingDict[AVLinearPCMBitDepthKey] = @16;
        settingDict[AVEncoderAudioQualityKey] = [NSNumber numberWithInt:AVAudioQualityHigh];
        _audioRecorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath: self.filePath] settings:settingDict error:nil];
        _audioRecorder.meteringEnabled = YES;
        _audioRecorder.delegate = self;
    }
    return _audioRecorder;
}

- (NSString *)filePath{
    if (!_filePath) {
        _filePath = [[NSFileManager cachesDirectory] stringByAppendingPathComponent:@"video.caf"];
    }
    return _filePath;
}
@end
