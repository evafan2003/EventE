//
//  CheckSearchViewController.h
//  moshTickets
//
//  Created by 魔时网 on 14-3-10.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CheckSearchViewController : BaseTableViewController
{
    UIButton *doneInKeyboardButton;
}

@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;
@property (strong, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UILabel *checkTicketNumberLabel;

@property (strong, nonatomic) NSString *eid;
@property (strong, nonatomic) Ticket *ticket;

@property (strong, nonatomic) NSMutableArray *ticketList;       //全部票
@property (strong, nonatomic) NSMutableArray *usedTicketList;       //已使用票
@property (strong, nonatomic) NSMutableArray *selectList;//选择的票种

- (void) viewResignFirstRespinder;

@end
