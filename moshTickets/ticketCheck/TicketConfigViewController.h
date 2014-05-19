//
//  TicketConfigViewController.h
//  MoshTicket
//
//  Created by evafan2003 on 12-6-14.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundViewController.h"
#import "BaseTableViewController.h"
#import "Activity.h"

@interface TicketConfigViewController :BaseTableViewController <RoundDelegate>

@property (strong, nonatomic) Activity  *act;//活动信息
@property (strong, nonatomic) NSMutableArray *roundList;//票种列表
@property (strong, nonatomic) NSMutableArray *selectList;//票种选中列表
@property (strong, nonatomic) NSMutableArray *resultList;//请求结果

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *ticketCount;
@property (strong, nonatomic) IBOutlet UIView *footView;
@property (strong, nonatomic) IBOutlet UIButton *roundButton;//选择票种按钮

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil activity:(Activity *)act;

//选择票种
- (IBAction)roundButtonPressed:(id)sender;
//开始验票
- (IBAction)startPressed:(id)sender;

#pragma mark - progress -
@property (weak, nonatomic) IBOutlet UIView *proView;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (assign, nonatomic) double proValue;
@property (strong, nonatomic) NSTimer *timer;

@end
