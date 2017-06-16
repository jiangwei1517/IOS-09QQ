//
//  QQCellTableViewCell.h
//  QQChat
//
//  Created by jiangwei18 on 17/6/16.
//  Copyright © 2017年 jiangwei18. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageFrame.h"

@interface QQCellTableViewCell : UITableViewCell

@property (nonatomic, strong)MessageFrame *messageFrame;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
