//
//  SingleResourceStaViewController.h
//  moshTickets
//
//  Created by 魔时网 on 13-11-26.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "BaseViewController.h"
#import "ResourceStatistical.h"
#import "PieChartView.h"

@interface SingleResourceStaViewController : BaseViewController<PieChartViewDataSource,PieChartViewDelegate>

@property (nonatomic, strong) ResourceStatistical *resourceSta;
@property (nonatomic, strong) PieChartView        *pieView;

@property (weak, nonatomic) IBOutlet UILabel *resourceName;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *totalCount;
@property (weak, nonatomic) IBOutlet UILabel *sucOrder;
@property (weak, nonatomic) IBOutlet UILabel *saleCount;
@property (weak, nonatomic) IBOutlet UILabel *sucPercent;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil resourceStatistical:(ResourceStatistical *)res;

@end
