//
//  ActivityStatisticalViewController.h
//  moshTickets
//
//  Created by 魔时网 on 13-11-21.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

/*
 活动统计页面
 */

#import "BaseViewController.h"
#import "HTTPClient.h"
#import "Activity.h"

@interface ActivityStatisticalViewController : BaseViewController

//@property (nonatomic, strong) NSString *eid;
@property (nonatomic, strong) Activity  *act;
@property (nonatomic ,strong) ActivityStatistical *actSta;//当前统计数据

/*
 IBOUT
 */
@property (weak, nonatomic) IBOutlet UIScrollView *baseScrollView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *actTitle;//活动标题
@property (weak, nonatomic) IBOutlet UILabel *peppleCount;//总到访人数
@property (weak, nonatomic) IBOutlet UILabel *sucOrder;//成功订单
@property (weak, nonatomic) IBOutlet UILabel *totalSales;//总销售额
@property (weak, nonatomic) IBOutlet UILabel *ticketCount;//预售票
@property (weak, nonatomic) IBOutlet UILabel *orderPer;//订单转化率
@property (weak, nonatomic) IBOutlet UILabel *outPer;//每个访问者收益

//查看top10
- (IBAction)sourceStatistical:(id)sender;
//查看销售情况
- (IBAction)ticketStatistical:(id)sender;
//查看分销任务
- (IBAction)PartSaleTask:(id)sender;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil activity:(Activity *)act;

@end
