//
//  Message.h
//  QQChat
//
//  Created by jiangwei18 on 17/6/16.
//  Copyright © 2017年 jiangwei18. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MessageTypeMe = 0,
    MessageTypeOther = 1
} MessageType;

@interface Message : NSObject

@property (nonatomic, strong)NSString *text;

@property (nonatomic, strong)NSString *time;

@property (nonatomic, assign)MessageType type;

- (instancetype)initWithDict:(NSDictionary*)dict;

+ (instancetype)messageWithDict:(NSDictionary*)dict;

@end
