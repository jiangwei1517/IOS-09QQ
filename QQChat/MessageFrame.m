//
//  MessageFrame.m
//  QQChat
//
//  Created by jiangwei18 on 17/6/16.
//  Copyright © 2017年 jiangwei18. All rights reserved.
//

#import "MessageFrame.h"

@implementation MessageFrame

- (void)setMessage:(Message *)message {
    _message = message;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin = 10;
    
    // 计算time的frame
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeW = screenWidth;
    CGFloat timeH = 15;
    
    // readOnly
    _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    
    // 计算icon的frame
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    CGFloat iconX = message.type == MessageTypeMe ? screenWidth - iconW - margin:margin;
    CGFloat iconY = CGRectGetMaxY(_timeFrame)+margin;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconY);
    
    
    // 计算text的frame
    CGFloat textW = [self getTextSizeWith:message.text and:CGSizeMake(200, MAXFLOAT) and:[UIFont systemFontOfSize:14]].width + 40;
    CGFloat textH = [self getTextSizeWith:message.text and:CGSizeMake(200, MAXFLOAT) and:[UIFont systemFontOfSize:14]].height + 30;
    CGFloat textY = iconY;
    CGFloat textX = message.type == MessageTypeMe ? screenWidth - 2*margin - iconW - textW : CGRectGetMaxX(_iconFrame)+margin;
    _textFrame = CGRectMake(textX, textY, textW, textH);
    
    // 计算rowHeight
    CGFloat height = MAX(CGRectGetMaxY(_textFrame), CGRectGetMaxY(_iconFrame)) + margin ;
    _rowHeight = height;
}

- (CGSize)getTextSizeWith:(NSString*)text and:(CGSize)size and:(UIFont*)font {
    return [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

@end
