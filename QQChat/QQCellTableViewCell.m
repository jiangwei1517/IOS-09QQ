//
//  QQCellTableViewCell.m
//  QQChat
//
//  Created by jiangwei18 on 17/6/16.
//  Copyright © 2017年 jiangwei18. All rights reserved.
//

#import "QQCellTableViewCell.h"

@interface QQCellTableViewCell ()

@property (nonatomic, weak)UILabel *time;
@property (nonatomic, weak)UIImageView *icon;
@property (nonatomic, weak)UIButton *text;

@end

@implementation QQCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建时间
        UILabel *time = [[UILabel alloc]init];
        time.textAlignment = NSTextAlignmentCenter;
        time.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:time];
        self.time = time;
        
        // 创建icon
        UIImageView *icon = [[UIImageView alloc]init];
        [self.contentView addSubview:icon];
        self.icon = icon;
        
        // 创建正文
        UIButton *text = [UIButton new];
        text.titleLabel.font = [UIFont systemFontOfSize:14];
        text.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:text];
        [text setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.text = text;
        self.text.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
        
    }
    return self;
}

- (void)setMessageFrame:(MessageFrame *)messageFrame {
    
    _messageFrame = messageFrame;
    Message *msg = messageFrame.message;
    
    self.time.text = msg.time;
    self.time.frame = messageFrame.timeFrame;
    if (messageFrame.isTimeHidden) {
        self.time.hidden = YES;
    }else{
        self.time.hidden = NO;
    }
    
    self.icon.image = [UIImage imageNamed:msg.type == 0 ? @"me" : @"other"];
    self.icon.frame = messageFrame.iconFrame;
    
    [self.text setTitle:msg.text forState:UIControlStateNormal];
    self.text.frame = messageFrame.textFrame;
    UIImage *imgMeNor = [UIImage imageNamed:@"chat_send_nor"];
    imgMeNor = [imgMeNor stretchableImageWithLeftCapWidth:imgMeNor.size.width/2 topCapHeight:imgMeNor.size.height/2];
    UIImage *imgMePress = [UIImage imageNamed:@"chat_send_press_pic"];
    imgMePress = [imgMePress stretchableImageWithLeftCapWidth:imgMePress.size.width/2 topCapHeight:imgMePress.size.height/2];
    UIImage *imgOtherNor = [UIImage imageNamed:@"chat_recive_nor"];
    imgOtherNor = [imgOtherNor stretchableImageWithLeftCapWidth:imgOtherNor.size.width/2 topCapHeight:imgOtherNor.size.height/2];
    UIImage *imgOtherPress = [UIImage imageNamed:@"chat_recive_press_pic"];
    imgOtherPress = [imgOtherPress stretchableImageWithLeftCapWidth:imgOtherPress.size.width/2 topCapHeight:imgOtherPress.size.height/2];
    if (msg.type == 0) {
        [self.text setBackgroundImage:imgMeNor forState:UIControlStateNormal];
        [self.text setBackgroundImage:imgMePress forState:UIControlStateHighlighted];
    } else {
        [self.text setBackgroundImage:imgOtherNor forState:UIControlStateNormal];
        [self.text setBackgroundImage:imgOtherPress forState:UIControlStateHighlighted];
    }
    
}
























@end
