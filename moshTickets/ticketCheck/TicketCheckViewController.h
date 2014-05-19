//
//  TicketCheckViewController.h
//  MoshTicket
//
//  Created by evafan2003 on 12-6-15.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLSegmentView.h"
#import "BaseViewController.h"
#import "CheckBarCodeViewController.h"
#import "CHeckPasswordViewController.h"
#import "CheckSearchViewController.h"

@interface TicketCheckViewController : BaseViewController<PLSegmentViewDelegate>
{
    CHeckPasswordViewController *_checkPasswordCtl;
    CheckBarCodeViewController *_checkBarCodeCtl;
    CheckSearchViewController *_checkSearchCtl;
}

@property (strong, nonatomic) NSString *eid;
@property (strong, nonatomic) Ticket *ticket;

@property (strong, nonatomic) NSMutableArray *ticketList;       //全部票
@property (strong, nonatomic) NSMutableArray *usedTicketList;   //已使用票
@property (strong, nonatomic) NSMutableArray *selectList;//选择的票种

@end
