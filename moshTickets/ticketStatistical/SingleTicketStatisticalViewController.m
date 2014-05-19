//
//  SingleTicketStatisticalViewController.m
//  moshTickets
//
//  Created by 魔时网 on 13-11-29.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "SingleTicketStatisticalViewController.h"

@interface SingleTicketStatisticalViewController ()

@end

@implementation SingleTicketStatisticalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithTicketStatistical:(TicketStatistical *)tic
{
    if (self = [super init]) {
        self.ticSta = tic;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = WHITECOLOR;
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemNone title:NAVTITLE_TICKETSTA];
    
    [self createQueryModelAndPieChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createQueryModelAndPieChart
{
    //统计表格
    QueryModel *qm = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([QueryModel class]) owner:self options:nil]lastObject];
    qm.frame = CGRectMake(POINT_X, POINT_Y, SCREENWIDTH, SCREENHEIGHT-NAVHEIGHT);
    
    qm.ticketName.text = self.ticSta.name;
    qm.total.text = self.ticSta.totalCount;
    qm.sold.text = self.ticSta.saleCount;
    qm.store.text = self.ticSta.remainCount;
    qm.used.text = self.ticSta.checkedCount;
    qm.unused.text = self.ticSta.uncheckedCount;
    [self.view addSubview:qm];
    
    //从数据库中读取验票信息
    NSArray *a = [[MoshTicketDatabase sharedInstance] getAllTicketByEid:self.ticSta.eid status:ticketState_isUsed ticketID:nil];
//    NSArray *a = [[MoshTicketDatabase sharedInstance] getAllTicketByEid:self.ticSta.eid status:ticketState_isUsed];
    int num = 0;
    for (Ticket *t in a) {
        if ([t.ticket_name isEqualToString:self.ticSta.name]) {
            num++;
        }
    }
    
    //如果本地的验票数大于网络的 证明本地有离线验票 故采用本地数据为准
    if ([self.ticSta.checkedCount integerValue] < num) {
        qm.used.text = [NSString stringWithFormat:@"%d",num];
        qm.unused.text = [NSString stringWithFormat:@"%d",([self.ticSta.totalCount intValue]-num)];
    }
    
    //画饼图
    
    PCPieChart *pie = [self makePieUsed:qm.sold.text Unused:qm.store.text];
    [qm addSubview:pie];


}

//画饼图
-(PCPieChart *) makePieUsed:(NSString *)used Unused:(NSString *)unused {
    
    int height = [self.view bounds].size.width/3*2.; // 220;
    int width = [self.view bounds].size.width; //320;
    PCPieChart *pieChart = [[PCPieChart alloc] initWithFrame:CGRectMake(([self.view bounds].size.width-width)/2,[self.view bounds].size.height/2-200,width,height)];
    [pieChart setShowArrow:NO];
    [pieChart setSameColorLabel:NO];
    [pieChart setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [pieChart setDiameter:width/2];
    
    NSMutableArray *components = [NSMutableArray array];
    
    
    PCPieComponent *component1 = [PCPieComponent pieComponentWithTitle:@"已售出" value:[used floatValue]];
    [components addObject:component1];
    [component1 setColour:PCColorGreen];
    
    PCPieComponent *component2 = [PCPieComponent pieComponentWithTitle:@"未售出" value:[unused floatValue]];
    [components addObject:component2];
    [component2 setColour:PCColorBlue];
    
    [pieChart setComponents:components];
    
    return pieChart;
}


@end
