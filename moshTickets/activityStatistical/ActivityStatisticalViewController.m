//
//  ActivityStatisticalViewController.m
//  moshTickets
//
//  Created by 魔时网 on 13-11-21.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "ActivityStatisticalViewController.h"
#import "ControllerFactory.h"

static CGFloat actTitleExtendHehght = 15;

@interface ActivityStatisticalViewController ()

@end

@implementation ActivityStatisticalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil activity:(Activity *)act
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.act = act;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemRefresh title:NAVTITLE_ACTIVITYSTA];
    self.baseScrollView.frame = self.view.frame;
    self.baseScrollView.contentSize = CGSizeMake(SCREENWIDTH, actTitleExtendHehght + self.actTitle.frame.size.height + self.infoView.frame.size.height);
    
    [self downloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) downloadData
{
    //加载
    [self showLoadingView];
    [[HTTPClient shareHTTPClient] statisticalResultWithEid:self.act.eid
                                                   success:^(ActivityStatistical *act) {
                                                       [self hideLoadingView];
                                                       self.actSta = act;
                                                       [self reloadData];
                                                   }];
}

- (void) reloadData
{
    if (self.actSta) {
        self.actTitle.text = self.actSta.actTitle;
        
        //随文字多少改变titleLabel的高度
        [self changeViewRectAccordingToTitleHeight];
        
        //赋值
        self.peppleCount.text = ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.actSta.peppleCount]?[NSString stringWithFormat:@"%@/人",self.actSta.peppleCount]:@"");
        self.sucOrder.text = ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.actSta.successOrder]?[NSString stringWithFormat:@"%@/单",self.actSta.successOrder]:@"");
        self.ticketCount.text = ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.actSta.ticketCount]?[NSString stringWithFormat:@"%@/张",self.actSta.ticketCount]:@"");
        self.totalSales.text = ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.actSta.totalSales]?[GlobalConfig priceConver:[NSString stringWithFormat:@"%@/%@",self.actSta.totalSales,[GlobalConfig currencyConver:self.act.currency]]]:@"");
        self.orderPer.text = ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.actSta.orderPer]?[NSString stringWithFormat:@"%@%%",self.actSta.orderPer]:@"");
        
        CGFloat totalMoney = [self.actSta.totalSales floatValue];
        CGFloat peopleCount = [self.actSta.peppleCount floatValue];
        NSInteger personMoney = totalMoney/peopleCount + 0.5;
        self.outPer.text = [NSString stringWithFormat:@"%d/%@",personMoney,[GlobalConfig currencyConver:self.act.currency]];
        
    }
}

- (void) changeViewRectAccordingToTitleHeight
{
    CGRect rect = self.actTitle.frame;
    CGSize size = [GlobalConfig getAdjustHeightOfContent:self.actSta.actTitle width:rect.size.width fontSize:[[self.actTitle font] pointSize]];
    self.actTitle.frame = CGRectMake(rect.origin.x,rect.origin.y , size.width, actTitleExtendHehght + size.height);
    
    self.infoView.frame = CGRectMake(self.infoView.frame.origin.x,actTitleExtendHehght + size.height,self.infoView.frame.size.width , self.infoView.frame.size.height);
    
    self.baseScrollView.contentSize = CGSizeMake(SCREENWIDTH, actTitleExtendHehght + size.height + self.infoView.frame.size.height);
}

- (IBAction)sourceStatistical:(id)sender {
    [self.navigationController pushViewController:[ControllerFactory resourceStatisticalWithData:self.actSta.resourceStatistical activity:self.act] animated:YES];
}

- (IBAction)ticketStatistical:(id)sender {
    [self.navigationController pushViewController:[ControllerFactory ticketStatisticalWithData:self.actSta.ticketStatistical activity:self.act] animated:YES];

}

- (IBAction)PartSaleTask:(id)sender {
    PartSaleTaskViewController *ctl = (PartSaleTaskViewController *)[ControllerFactory partSaleTaskViewController];
    ctl.dataArray = self.actSta.taskArray;
    [self.navigationController pushViewController:ctl animated:YES];
}

-(void) navRefreshClick
{
    [self downloadData];
}
@end
