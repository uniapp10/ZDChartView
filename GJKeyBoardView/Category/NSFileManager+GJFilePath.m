//
//  NSFileManager+GJFilePath.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/12.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "NSFileManager+GJFilePath.h"

@implementation NSFileManager (GJFilePath)
+ (NSString *)cachesDirectory {
    return [[self defaultManager] directoryFor:NSCachesDirectory];
}

- (NSString *)directoryFor: (NSSearchPathDirectory) directory {
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, true).firstObject;
}
@end
