//
//  GJAudioRecorder.h
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/12.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJAudioRecorder : NSObject

+ (instancetype)shareRecorder;
- (void)startRecordWithVolumnChanged: (void(^)(CGFloat volumn))volumnChangeBlock complete: (void(^)(NSString *filePath, CGFloat time))completeBlock cancel: (void(^)(void))cancelBlock;
- (void)stopRecord;
- (void)cancelRecord;

@end
