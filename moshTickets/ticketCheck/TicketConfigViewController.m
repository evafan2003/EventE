//
//  TicketConfigViewController.m
//  MoshTicket
//
//  Created by evafan2003 on 12-6-14.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import "TicketConfigViewController.h"
#import "TicketCheckViewController.h"
#import "Ticket.h"
#import "GlobalConfig.h"
#import "MoshTicketDatabase.h"
#import "HTTPClient.h"
#import "CJSONSerializer.h"
#import "ServerManger.h"
#import "TicketType.h"
#import "HTTPClient+TIckets.h"

static CGFloat headerHeight = 110.0f;
static CGFloat baseTableViewWidth = 280.0f;

@interface TicketConfigViewController ()

@end

@implementation TicketConfigViewController
@synthesize ticketCount;
@synthesize titleLabel;
@synthesize resultList;
@synthesize roundList;
@synthesize selectList;

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
    
    [self initScrollView];
    
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemDelete title:NAVTITLE_CONFIG];
    
    //更新票数据
    [self downloadData];
    //更新总票数
    [self changeTicketLabel];
    //提交已验票数据
    [self updateWithServer];
    //5分钟后定时检查新票
    [[ServerManger shareServerManger] performSelector:@selector(startDownloadNewsTicket:) withObject:self.act afterDelay:60];
    
    //当有新票时更新总票数信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTicketLabel) name:Notification_checkTicket object:nil];
    //添加消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ticketDownloadSuccess:) name:Notification_TicketSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ticketDownLoadFail) name:Notification_TicketFail object:nil];
    
}

- (void) initScrollView
{
    self.roundList = self.act.tickedTypeArray;
    self.selectList = [NSMutableArray array];
    self.titleLabel.text = self.act.title;

    self.baseTableView.frame = CGRectMake((SCREENWIDTH - baseTableViewWidth)/2, headerHeight, baseTableViewWidth, SCREENHEIGHT - NAVHEIGHT - headerHeight - STATEHEIGHT);
    self.baseTableView.showsVerticalScrollIndicator = NO;
    self.baseTableView.tableFooterView = self.footView;

    

}


- (void) navBackClick
{
    [[ServerManger shareServerManger] endDownloadNewsTicket];
    [super navBackClick];
}

//更新票总数label
-(void) changeTicketLabel {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *ticketID = [self getDatabaseTicketID:self.selectList];
        
        int usedCount = [[MoshTicketDatabase sharedInstance] getAllTicketCountByEid:self.act.eid status:ticketState_isUsed ticketID:ticketID];
        int totalCount = [[MoshTicketDatabase sharedInstance] getAllTicketCountByEid:self.act.eid status:nil ticketID:ticketID];
            
            self.ticketCount.text = [NSString stringWithFormat:@"已验票%i张/总票数%i张", usedCount,totalCount];
        
    });
    
}

//删除所有票
-(void) navDeleteClick {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:CONFIG_DEL_CONFIRM delegate:self cancelButtonTitle:BUTTON_CANCEL otherButtonTitles:BUTTON_OK, nil];
    [alert show];
}

#pragma mark
#pragma UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
         [[MoshTicketDatabase sharedInstance] deleteAllTicketWitheid:self.act.eid];
            
            //删除记录的最后一次请求时间，下次重新下载全部票
            NSString *dateKey = [NSString stringWithFormat:@"ListDate%@",self.act.eid];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:dateKey];
            
            [self.navigationController popViewControllerAnimated:YES];
                [[ServerManger shareServerManger] endDownloadNewsTicket];
            
            [GlobalConfig alert:CONFIG_DEL_SUC];
    }
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"已选择票种:";
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.selectList.count < 1) {
        return 0;
    }
    else {
        return 20;
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.selectList.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ticketCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.textLabel setFont:[UIFont systemFontOfSize:13.0f]];
    
    }
    TicketType *type = self.selectList[indexPath.row];
    
    cell.textLabel.text = type.tTypeName;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}

#pragma --mark
#pragma RoundTableViewDelegate
-(void) returnRound:(NSMutableArray *)array {
    
    self.selectList = array;
    [self.baseTableView reloadData];
    [self changeTicketLabel];
}


//选择检票场次
- (IBAction)roundButtonPressed:(id)sender {
    
    if (self.roundList.count < 1) {
        
        [GlobalConfig alert:CONFIG_SINGLE];
        
    } else {
        //弹出一个UITableviewController
        RoundViewController *viewController = [[RoundViewController alloc] initWithStyle:UITableViewStylePlain];
        viewController.rdeleage = self;
        viewController.roundList = self.roundList;
        viewController.selectList = self.selectList;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        nav.navigationBar.tintColor = NORMAL_COLOR;
        [self presentModalViewController:nav animated:YES];
        
    }

}

- (IBAction)startPressed:(id)sender {
    
    if (self.selectList.count < 1) {

        [GlobalConfig alert:self.roundList.count == 0?CONFIG_NO_TICKET:CONFIG_LOSE_TICKET];
        
    } else {
    
        TicketCheckViewController *viewController = [[TicketCheckViewController alloc] init];
        viewController.title = self.titleLabel.text;
        viewController.eid = self.act.eid;
        viewController.selectList = self.selectList;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

//提交已验票数据
- (void) updateWithServer
{
    NSArray *array = [[MoshTicketDatabase sharedInstance] getAllUnpostTicketsByEid:self.act.eid];
    if ([GlobalConfig isKindOfNSArrayClassAndCountGreaterThanZero:array]) {
        [[ServerManger shareServerManger] updateTickets:array];
    }
}


#pragma update

////更新票数据 使用批次插入方式，插入时间短
//-(void) updateTicket {
//    
//    [self showLoadingView];
//    
//    [[HTTPClient shareHTTPClient] getAllTicketWitheid:self.act.eid success:^(NSMutableArray *tickets){
//        
//        self.resultList = tickets;
//        
//        //成功之后开始搞(存库之类)
//        if (self.resultList.count > 0) {
//            //有新结果
//                [[MoshTicketDatabase sharedInstance] insertTickets:self.resultList];
//                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_checkTicket object:nil];
//        }
//        
//        [self hideLoadingView];
//    }
//                                                 fail:^{
//                                                     [self hideLoadingView];
//                                                     [GlobalConfig showAlertViewWithMessage:DOWN_DELFAILED superView:nil];
//                                                     
//                                                 }];
//    
//}

#pragma mark -download -
- (void) ticketDownloadSuccess:(NSNotification *)noti
{
    NSNumber *progress = [noti object];
    if ([progress isKindOfClass:[NSNumber class]]) {
        if ([progress floatValue]  >= 1.0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.loadingView.progress = [progress floatValue];
                [self hideLoadingView];
                self.loadingView.mode = MBProgressHUDModeIndeterminate;
                [self downloadDataFromDatabase];
            });
        }
    }
}

- (void) ticketDownLoadFail
{
    [self hideLoadingView];
    self.loadingView.mode = MBProgressHUDModeIndeterminate;
    [GlobalConfig showAlertViewWithMessage:ERROR_LOADINGFAIL superView:self.view];
    [self downloadDataFromDatabase];
}

- (void) downloadDataFromDatabase
{
    self.searchBar.text = nil;
    self.searchBar.showsCancelButton = NO;
    
   [[NSNotificationCenter defaultCenter] postNotificationName:Notification_checkTicket object:nil];
}

- (void) downloadData
{
    //加载
    [self showLoadingView];
    self.loadingView.mode = MBProgressHUDModeAnnularDeterminate;
    
    [[HTTPClient shareHTTPClient] ticketsInfoWithActivity:self.act isall:NO backgroud:NO];
    
    //虚假动画
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        while (self.loadingView.progress < 0.95) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.loadingView.progress += 0.01;
            });
            
            usleep(500000);
        }
    });
}

#pragma mark - progressView -

@end