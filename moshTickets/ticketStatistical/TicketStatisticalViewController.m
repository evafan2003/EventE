//
//  TicketStatisticalViewController.m
//  moshTickets
//
//  Created by 魔时网 on 13-11-25.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "TicketStatisticalViewController.h"
#import "TicketStatistical.h"
#import "ControllerFactory.h"
#import "ControllerFactory.h"

@interface TicketStatisticalViewController ()

@end

@implementation TicketStatisticalViewController

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
    
//    self.title = NAVTITLE_TICKETSTA;
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemCheck title:NAVTITLE_TICKETSTA];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) listLabelName:(NSInteger)index
{
    switch (index) {
        case 0:
            return @"名称";
        case 1:
            return @"总数";
        case 2:
            return @"剩余数";
        case 3:
            return @"已售数";
        default:
            return @"";
            break;
    }
}

- (NSString *) contentOfCellInIndexPath:(NSIndexPath *)indexPath labelIndex:(NSInteger)index
{
    TicketStatistical *resource = (TicketStatistical *)self.dataArray[indexPath.row];
    switch (index) {
        case 0:
            return resource.name;
            break;
        case 1:
            return resource.totalCount;
            break;
        case 2:
            return resource.remainCount;
            break;
        case 3:
            return resource.saleCount;
            break;
        default:
            return @"";
            break;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TicketStatistical *ticket = (TicketStatistical *)self.dataArray[indexPath.row];
    [self.navigationController pushViewController:[ControllerFactory singleTicketStaViewControllerWithTicketStatistical:ticket] animated:YES];
}


- (void) navCheckClick
{
//    TicketStatistical *ticket = (TicketStatistical *)self.dataArray[0];
    //验票 act.eid
    [self.navigationController pushViewController:[ControllerFactory ticketConfigViewControllerWithActivity:_act] animated:YES];
    
}

@end
