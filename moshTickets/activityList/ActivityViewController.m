//
//  ActivityViewController.m
//  moshTickets
//
//  Created by 魔时网 on 13-11-18.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "ActivityViewController.h"
#import "ControllerFactory.h"
#import "TicketConfigViewController.h"
#import "NotificationDate.h"
#import "MOSHLocalNotification.h"
#import "Reachability.h"

static CGFloat activityHeight = 150;
static CGFloat headerHeight = 13;
static NSString *cellIdentifier = @"activityCell";
static NSString *act_end = @"actList_cellBg03";
static NSString *act_display = @"actList_cellBg01";
static NSString *act_notStart = @"actList_cellBg02";



@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化
    self.cellHeight = activityHeight;
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemNone title:NAVTITLE_ACTIVITYLIST];
    
    [self addHeaderView];
    [self downloadData];
    [self showLoadingView];
    
    [self addEGORefreshOnTableView:self.baseTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark self.action

- (void) addHeaderView
{
    self.baseTableView.tableHeaderView = [GlobalConfig createViewWithFrame:CGRectMake(POINT_X, POINT_Y, SCREENWIDTH, headerHeight)];
}


- (void) downloadData
{
    [[HTTPClient shareHTTPClient] activityListWithPage:self.page
                                               success:^(NSMutableArray *array){
                                                   
                                                   [self listFinishWithDataArray:array];
                                               }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ActivityCell class]) owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    
    //背景
    [self changeBackgroundColorForCell:cell indexPath:indexPath];
    
    //赋值
    [self addDataToCell:cell indexPath:indexPath];
    
    //加载更多
    [self downloadMore:indexPath textColor:BLACKCOLOR];
    
    //添加提醒
    Activity *act = self.dataArray[indexPath.row];
    [MOSHLocalNotification addNotification:[[NotificationDate alloc] initWithActivity:act]];
    
    return cell;
}

//更改cell背景色
- (void) changeBackgroundColorForCell:(ActivityCell *)cell indexPath:(NSIndexPath *)indexPath
{
    Activity *act = self.dataArray[indexPath.row];
    
    //当前时间大于开始时间
    if ([GlobalConfig dateCompareWithCurrentDate:act.startDate] == NSOrderedAscending) {
        //大于结束时间 已结束
        if ([GlobalConfig dateCompareWithCurrentDate:act.endDate] == NSOrderedAscending) {
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:act_end]];
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:act_end]];
        }
        else {//进行中
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:act_display]];
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:act_display]];
        }
    }
    else {//未开始
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:act_notStart]];
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:act_notStart]];
    }
}

//对cell内容赋值
- (void) addDataToCell:(ActivityCell *)cell indexPath:(NSIndexPath *)indexPath
{
    Activity *act = self.dataArray[indexPath.row];

    cell.activityTitle.text = act.title;
    cell.activityDate.text = [NSString stringWithFormat:@"%@ - %@",[GlobalConfig dateFormater:act.startDate format:DATEFORMAT_03],[GlobalConfig dateFormater:act.endDate format:DATEFORMAT_03]];
    cell.activityAddress.text = act.address;
//    [cell.activityImageView setImageWithURL:[NSURL URLWithString:[GlobalConfig thumbnailImageUrl:act.imageUrl width:cell.activityImageView.frame.size.width*2 height:cell.activityImageView.frame.size.height*2]] placeholderImage:PLACEHOLDERIMAGE_VERTICAL];
}

#pragma mark AcitivityCellDelegate
//数据统计
- (void) checkStatisticalWithCell:(ActivityCell *)cell
{
    NSIndexPath *indexPath = [self.baseTableView indexPathForCell:cell];
    Activity *act = self.dataArray[indexPath.row];
    //查看统计 act.eid
    [self.navigationController pushViewController:[ControllerFactory activityStatisticalWithActivity:act] animated:YES];
}

//活动验票
- (void) checkTicketWithCell:(ActivityCell *)cell
{
    NSIndexPath *indexPath = [self.baseTableView indexPathForCell:cell];
    Activity *act = self.dataArray[indexPath.row];
    //验票 act.eid
    [self.navigationController pushViewController:[ControllerFactory ticketConfigViewControllerWithActivity:act] animated:YES];
    
}

//报名信息
- (void) memberInfoWithCell:(ActivityCell *)cell
{
    NSIndexPath *indexPath = [self.baseTableView indexPathForCell:cell];
    Activity *act = self.dataArray[indexPath.row];
    
    // act.eid
    [self.navigationController pushViewController:[ControllerFactory memberStatisticViewControllerWithActivity:act] animated:YES];
}


@end
