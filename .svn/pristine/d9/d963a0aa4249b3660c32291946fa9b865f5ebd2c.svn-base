//
//  TicketDetailViewController.m
//  MoshTicket
//
//  Created by evafan2003 on 12-7-4.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import "TicketDetailViewController.h"
#import "Ticket.h"
#import "MoshTicketDatabase.h"
#import "CheckTickets.h"

#define BUTTON_TAG 200

@interface TicketDetailViewController ()

@end

@implementation TicketDetailViewController
@synthesize myTableView;
@synthesize ticket;

//格式化时间
-(NSString *)timeFormater:(NSString *)time {
    //不足一天的 按小时显示
    if (time.length >1) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[time intValue]];
        
        NSDateFormatter *fromatter = [[NSDateFormatter alloc] init];
        
        [fromatter setDateFormat:@"M月dd日 hh:mm"];
        
        NSString *timeString = [fromatter stringFromDate:date];
        
        return timeString;
        
    } else {
        
        return @"暂无";
        
    }
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        self.title = @"票详情";
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemNone title:NAVTITLE_CONFIG];
    
    //init footerView
    if ([self.ticket.t_state isEqualToString:ticketState_unUse]) {
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(107, 5, 106, 38);
        [button setBackgroundImage:[UIImage imageNamed:@"blue"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"bluePressed"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(statusChanged) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"检票" forState:UIControlStateNormal];
        button.tag = BUTTON_TAG;
        [footerView addSubview:button];
        self.myTableView.tableFooterView = footerView;
    }

}

//更改票状态
-(void)statusChanged {
    
    //弹出提示
    
    NSString *alertString;
    
    
    if ([self.ticket.t_state isEqualToString:ticketState_unUse]) {
        //未使用
        alertString = @"确定要将该票设置为“已使用”吗?";
        
    }else {
        [GlobalConfig alert:@"该票已使用"];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:alertString delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
    
}

#pragma UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        UIButton *button = (UIButton *)[self.myTableView.tableFooterView viewWithTag:BUTTON_TAG];
        if ([self.ticket.t_state isEqualToString:ticketState_unUse]) {
            [CheckTickets checkTicket:self.ticket];
            [GlobalConfig alert:@"完成验票"];
        }
        button.hidden = YES;
    }
    
}


- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark
#pragma UITableViewController DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = NO;
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 90, 35)];
        titleLabel.tag = 30;
        titleLabel.textAlignment = UITextAlignmentRight;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 210, 35)];        
        detailLabel.tag = 31;        
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.numberOfLines = 0;
        [cell.contentView addSubview:detailLabel];
    }
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:30];
    UILabel *detailLabel = (UILabel *)[cell viewWithTag:31];
    
    if (indexPath.row == 0) {
        
        titleLabel.text = @"验票密码：";
        detailLabel.text = self.ticket.t_password;
        
    } else if (indexPath.row == 1) {
        titleLabel.text = @"票编号：";
        detailLabel.text = self.ticket.t_id;
        
    } else if (indexPath.row == 2) {
        titleLabel.text = @"状态：";
        
        if ([self.ticket.t_state isEqualToString:ticketState_unUse]) {
            
            //未使用
            detailLabel.text = @"该票未使用";
            
        } else if ([self.ticket.t_state isEqualToString:ticketState_isUsed]) {
            //已使用
            detailLabel.text = @"该票已使用";            
            
        } else {
            //待上传
            detailLabel.text = @"该票已过期";            
        }
        
    } else if (indexPath.row == 3) {
        titleLabel.text = @"验票时间：";
        
        if ([self.ticket.use_date isEqualToString:@""]) {
            
            detailLabel.text = @"尚未使用";
            
        } else {
            
            detailLabel.text = [self timeFormater:self.ticket.use_date];            
            
        }
        
    } else if (indexPath.row == 4) {
        titleLabel.text = @"名称：";
        detailLabel.text = self.ticket.ticket_name;
        CGSize size = [self getAdjustSide:self.ticket.ticket_name];
        detailLabel.frame = CGRectMake(100, 0, 210, size.height);
        
    } else if (indexPath.row == 5) {
        titleLabel.text = @"身份证号：";
        detailLabel.text = ([self.ticket.idCard isEqualToString:@""]) ? @"暂无" : self.ticket.idCard;
        
    } else if (indexPath.row == 6) {
        titleLabel.text = @"价格：";
        detailLabel.text = self.ticket.t_price;
        
    } else if (indexPath.row == 7) {
        titleLabel.text = @"手机：";
        detailLabel.text = self.ticket.tel;
        
    } else if (indexPath.row == 8) {
        titleLabel.text = @"邮箱：";
        detailLabel.text = self.ticket.email;
        CGSize size = [self getAdjustSide:self.ticket.email];
        detailLabel.frame = CGRectMake(100, 0, 210, size.height);
        
    } else if (indexPath.row == 9) {
        
        titleLabel.text = @"姓名：";
        detailLabel.text = self.ticket.name;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {

        CGSize size = [self getAdjustSide:self.ticket.ticket_name];
        return size.height;
    } else if (indexPath.row == 8) {
        CGSize size = [self getAdjustSide:self.ticket.email];
        return size.height;
    }
    return 35;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.

    return 10;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (CGSize) getAdjustSide:(NSString *)str
{
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(210, 20000) lineBreakMode:NSLineBreakByCharWrapping];
    size.height = size.height + 20;
    return size;
}
@end
