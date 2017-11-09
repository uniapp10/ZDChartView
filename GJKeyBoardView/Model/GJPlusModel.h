//
//  GJPlusModel.h
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/11.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJPlusModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;

+ (instancetype)modelWithDict: (NSDictionary *)dict;

@end
