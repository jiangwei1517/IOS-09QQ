//
//  Message.m
//  QQChat
//
//  Created by jiangwei18 on 17/6/16.
//  Copyright © 2017年 jiangwei18. All rights reserved.
//

#import "Message.h"

@implementation Message

- (instancetype)initWithDict:(NSDictionary*)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)messageWithDict:(NSDictionary*)dict {
    return [[Message alloc]initWithDict:dict];
}
@end
