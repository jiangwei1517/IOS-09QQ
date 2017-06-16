//
//  ViewController.m
//  QQChat
//
//  Created by jiangwei18 on 17/6/16.
//  Copyright © 2017年 jiangwei18. All rights reserved.
//

#import "ViewController.h"
#import "Message.h"
#import "MessageFrame.h"
#import "QQCellTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UITextField *mTextField;

@property(nonatomic, strong)NSMutableArray *messages;

@end

@implementation ViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"qq_cell";
    QQCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[QQCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    // 给cell设置数据
    [cell setMessageFrame:self.messages[indexPath.row]];
    return cell;
}

// 数据的懒加载
- (NSMutableArray *)messages {
    if (_messages == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil];
        NSArray *arrayModels = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray new];
        for (NSDictionary* dict in arrayModels) {
            Message *msg = [[Message alloc]initWithDict:dict];
            MessageFrame *msgFrame = [MessageFrame new];
            if ([msg.time isEqualToString:((MessageFrame*)models.lastObject).message.time]) {
                msgFrame.isTimeHidden = YES;
            }else{
                msgFrame.isTimeHidden = NO;
            }
            msgFrame.message = msg;
            [models addObject:msgFrame];
        }
        _messages = models;
    }
    return _messages;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageFrame *msgF = self.messages[indexPath.row];
    return msgF.rowHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.mTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // 设置UITableView的背景色
    self.mTableView.backgroundColor = [UIColor colorWithRed:236 / 255.0 green:236 / 255.0 blue:236 / 255.0 alpha:1.0];
    self.mTableView.allowsSelection = NO;
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, 5, 1);
    
    self.mTextField.leftView = view;
    self.mTextField.leftViewMode = UITextFieldViewModeAlways;
    
    // object:nil 键盘的广播事件谁都可以监听
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShowWith:) name:UIKeyboardWillChangeFrameNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShowWith:) name:UIKeyboardWillChangeFrameNotification object:nil];
     NSIndexPath *path = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
     [self.mTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void) keyBoardShowWith:(NSNotification *)info {
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
    [self.mTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat y = [info.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue].origin.y;
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, y - screenHeight);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (temp.length == 0) {
        return YES;
    }
    Message *newMsg = [Message new];
    newMsg.type = 0;
    newMsg.text = textField.text;
    NSDate *date = [NSDate new];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"HH-mm";
    newMsg.time = [formatter stringFromDate:date];
    MessageFrame *msgF = [MessageFrame new];
    msgF.message = newMsg;
    MessageFrame *lastMessageFrame = self.messages.lastObject;
    NSString *lastTime = lastMessageFrame.message.time;
    if ([newMsg.time isEqualToString:lastTime]) {
        msgF.isTimeHidden = YES;
    }else{
        msgF.isTimeHidden = NO;
    }
    [self.messages addObject:msgF];
    [self.mTableView reloadData];
    
    Message *newMsgOther = [Message new];
    newMsgOther.type = 1;
    newMsgOther.text = @"fuck";
    NSDate *dateOther = [NSDate new];
    NSDateFormatter *formatterOther = [NSDateFormatter new];
    formatterOther.dateFormat = @"HH-mm";
    newMsgOther.time = [formatter stringFromDate:dateOther];
    MessageFrame *msgFOther = [MessageFrame new];
    msgFOther.message = newMsgOther;
    MessageFrame *lastMessageFrameOther = self.messages.lastObject;
    NSString *lastTimeOther = lastMessageFrameOther.message.time;
    if ([newMsgOther.time isEqualToString:lastTimeOther]) {
        msgFOther.isTimeHidden = YES;
    }else{
        msgFOther.isTimeHidden = NO;
    }
    [self.messages addObject:msgFOther];
    [self.mTableView reloadData];
//    [self.view endEditing:YES];
//    NSIndexPath *path = [NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0];
//    [self.mTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [self.mTableView setContentOffset:CGPointMake(0, self.mTableView.contentSize.height - self.mTableView.frame.size.height) animated:YES];
    
    self.mTextField.text = nil;
    return NO;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
