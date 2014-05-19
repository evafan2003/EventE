//
//  SingleResourceStaViewController.m
//  moshTickets
//
//  Created by 魔时网 on 13-11-26.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "SingleResourceStaViewController.h"
#import "GlobalConfig.h"    

static CGFloat  centerCircleRadius = 95.0f;
static NSInteger slicesNumber = 3;
static CGFloat  pieCharViewWight = 280.0f;

@interface SingleResourceStaViewController ()

@end

@implementation SingleResourceStaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil resourceStatistical:(ResourceStatistical *)res
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.resourceSta = res;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemNone title:NAVTITLE_TOP10];
    
    [self createPieView];
    [self reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createPieView
{
    self.pieView = [[PieChartView alloc] initWithFrame:CGRectMake((SCREENWIDTH - pieCharViewWight)/2, 0, pieCharViewWight, pieCharViewWight)];
    self.pieView.datasource = self;
    self.pieView.delegate = self;
    [self.infoView addSubview:self.pieView];
    
}

- (void) reloadData
{
    self.totalCount.text = self.resourceSta.totalCount;
    self.sucOrder.text = self.resourceSta.sucOrder;
    self.saleCount.text = self.resourceSta.saleCount;
    self.sucPercent.text = self.resourceSta.sucPercent;
    self.resourceName.text = [NSString stringWithFormat:@"来源：%@",self.resourceSta.name];
}


- (CGFloat)centerCircleRadius
{
    return centerCircleRadius;
}

- (void) drawRectFinishWithIndex:(NSInteger)index
{
    [self rotatingWithIndex:index];
}

//旋转中底部的index值
- (void) rotatingWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            self.bottomLabel.text = [NSString stringWithFormat:@"访问未买票 %@人 占%d%%",self.resourceSta.notBuy,[self percentBetweentotalCountWithOther:self.resourceSta.notBuy]];
            break;
            case 1:
            self.bottomLabel.text = [NSString stringWithFormat:@"下单未支付 %@人 占%d%%",self.resourceSta.notPay,[self percentBetweentotalCountWithOther:self.resourceSta.notPay]];
            break;
            case 2:
            self.bottomLabel.text = [NSString stringWithFormat:@"成功订单 %@单 转化率%@",self.resourceSta.sucOrder,self.resourceSta.sucPercent];
            break;
        default:
            break;
    }

}

- (NSInteger) percentBetweentotalCountWithOther:(NSString *)str
{
    return (NSInteger)([str floatValue]/[self.resourceSta.totalCount floatValue]*100);
}


- (int)numberOfSlicesInPieChartView:(PieChartView *)pieChartView
{
    return slicesNumber;
}
- (double)pieChartView:(PieChartView *)pieChartView valueForSliceAtIndex:(NSUInteger)index
{
    switch (index) {
        case 0:
            return [self.resourceSta.notBuy integerValue];
            break;
        case 1:
            return [self.resourceSta.notPay integerValue];
            break;
        case 2:
            return [self.resourceSta.sucOrder integerValue];
            break;
        default:
            return 0;
            break;
    }
}
- (UIColor *)pieChartView:(PieChartView *)pieChartView colorForSliceAtIndex:(NSUInteger)index
{
    switch (index) {
        case 0:
            return [UIColor colorWithRed:000/255.0f green:071/255.0f blue:157/255.0f alpha:1];
            break;
        case 1:
            return [UIColor colorWithRed:000/255.0f green:104/255.0f blue:183/255.0f alpha:1];
            break;
        case 2:
            return [UIColor colorWithRed:126/255.0f green:206/255.0f blue:244/255.0f alpha:1];
            break;
        default:
            return CLEARCOLOR;
            break;
    }

}


@end
