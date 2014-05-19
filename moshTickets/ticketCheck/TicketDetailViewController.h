//
//  TicketDetailViewController.h
//  MoshTicket
//
//  Created by evafan2003 on 12-7-4.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class TicketCheckViewController;
@class Ticket;

@interface TicketDetailViewController :BaseViewController
@property (retain, nonatomic) IBOutlet UITableView *myTableView;
@property (retain, nonatomic) Ticket *ticket;

@end
