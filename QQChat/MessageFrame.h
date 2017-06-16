//
//  MessageFrame.h
//  QQChat
//
//  Created by jiangwei18 on 17/6/16.
//  Copyright © 2017年 jiangwei18. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Message.h"

@interface MessageFrame : NSObject

@property (nonatomic, strong)Message *message;

@property (nonatomic, assign, readonly)CGRect timeFrame;

@property (nonatomic, assign, readonly)CGRect iconFrame;

@property (nonatomic, assign, readonly)CGRect textFrame;

@property (nonatomic, assign, readonly)CGFloat rowHeight;

@property (nonatomic, assign)BOOL isTimeHidden;

@end
