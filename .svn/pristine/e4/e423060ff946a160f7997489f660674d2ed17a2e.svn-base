//
//  CheckSearchViewController.m
//  moshTickets
//
//  Created by 魔时网 on 14-3-10.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "CheckSearchViewController.h"
#import "MoshTicketDatabase.h"
#import "TicketDetailViewController.h"

@interface CheckSearchViewController ()

@end

@implementation CheckSearchViewController

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
    self.baseTableView.frame = CGRectMake(0, 115, SCREENWIDTH,SCREENHEIGHT - NAVHEIGHT - 38 - 115);
    MOSHLog(@"%f,%f",self.view.frame.size.height,self.view.frame.origin.y);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadTicket];
    self.view.backgroundColor = CLEARCOLOR;
    self.baseTableView.backgroundColor = CLEARCOLOR;
    
    [self.view addSubview:self.tableHeaderView];
    MOSHLog(@"%f,%f",self.view.frame.size.height,self.view.frame.origin.y);    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadTicket) name:Notification_checkTicket object:nil];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadTicket {
        
    NSString *ticketID = [self getDatabaseTicketID:self.selectList];
    
//    self.ticketList = [[MoshTicketDatabase sharedInstance] getAllTicketByEid:self.eid status:nil ticketID:ticketID];
      self.ticketList = [[MoshTicketDatabase sharedInstance] searchTicket:[GlobalConfig convertToString:self.mySearchBar.text] eid:self.eid ticketID:ticketID];
//    self.ticketList = [[MoshTicketDatabase sharedInstance] searchTicket:@"" eid:self.eid ticketID:ticketID];
    [self.baseTableView reloadData];
}

- (void) viewResignFirstRespinder
{
    [self.mySearchBar resignFirstResponder];
}


#pragma mark
#pragma UISearchBarDelegate

//
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    NSString *ticketID = [self getDatabaseTicketID:self.selectList];
    
    self.ticketList = [[MoshTicketDatabase sharedInstance] searchTicket:searchBar.text eid:self.eid ticketID:ticketID];
     [self.baseTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];

}

#pragma -mark
#pragma TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
        static NSString *theCell = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:theCell];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:theCell];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor grayColor];
            
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            
            cell.contentView.backgroundColor = CLEARCOLOR;
            cell.backgroundColor = CLEARCOLOR;
            
            
            UILabel *midLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 120, 35)];
            midLabel.font = [UIFont systemFontOfSize:14];
            midLabel.textColor = [UIColor grayColor];
            midLabel.backgroundColor = [UIColor clearColor];
            midLabel.tag = 27;
            [cell.contentView addSubview:midLabel];
        }
        
        Ticket *theTicket = [self.ticketList objectAtIndex:indexPath.row];
        UILabel *midLabel = (UILabel *)[cell.contentView viewWithTag:27];
        
        cell.textLabel.text = theTicket.t_password;
        
        if ([theTicket.use_date isEqualToString:@""] || [theTicket.use_date isEqualToString:@"0"]) {
            
            midLabel.text = nil;
        } else {
            midLabel.text = [NSString stringWithFormat:@"  %@",[GlobalConfig dateFormater:theTicket.use_date format:DATEFORMAT_05]];
            
        }
        
        int status = [theTicket.t_state intValue];
        if (status == 1) {
            //未使用
            cell.detailTextLabel.text = @"该票未使用";
            
        } else if (status == 2) {
            //已使用
            cell.detailTextLabel.text = @"该票已使用";
            
        } else {
            //过期
            cell.detailTextLabel.text = @"该票已过期";
        }
        
        return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
        return 35;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ticketList.count;
}

#pragma mark
#pragma UITableViewController Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

        
        TicketDetailViewController *viewController = [[TicketDetailViewController alloc] initWithNibName:@"TicketDetailViewController" bundle:nil];
        viewController.ticket = [self.ticketList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:viewController animated:YES];
    
}


#pragma mark 键盘
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (doneInKeyboardButton.superview)
    {
        [doneInKeyboardButton removeFromSuperview];
    }
}

- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    
    if ([self.mySearchBar isFirstResponder]) {
        if (doneInKeyboardButton == nil)
        {
            doneInKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            doneInKeyboardButton.frame = CGRectMake(0, SCREENHEIGHT - 53, 106, 53);
            
            doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
            //图片直接抠腾讯财付通里面的= =!
            //        [doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_up@2x.png"] forState:UIControlStateNormal];
            //        [doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_down@2x.png"] forState:UIControlStateHighlighted];
            [doneInKeyboardButton setTitle:@"完成" forState:UIControlStateNormal];
            [doneInKeyboardButton setTitle:@"完成" forState:UIControlStateHighlighted];
            [doneInKeyboardButton addTarget:self action:@selector(doneButton) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
        
        if (doneInKeyboardButton.superview == nil)
        {
            [tempWindow addSubview:doneInKeyboardButton];    // 注意这里直接加到window上
        }
    }
    
}

-(void) doneButton {
    
    [self.mySearchBar resignFirstResponder];
}


@end
