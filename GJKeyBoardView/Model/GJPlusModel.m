//
//  GJPlusModel.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/11.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "GJPlusModel.h"

@implementation GJPlusModel

- (instancetype)initWithDict: (NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (instancetype)modelWithDict: (NSDictionary *)dict {
   return  [[self alloc] initWithDict:dict];
}

@end
