//
//  CheckBarCodeViewController.h
//  moshTickets
//
//  Created by 魔时网 on 14-3-10.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "BaseTableViewController.h"
#import "Ticket.h"
#import "BarCodeScannerViewController.h"

@interface CheckBarCodeViewController : BaseTableViewController<BarCodeScannerDelegate>
{
    BarCodeScannerViewController *_scannerController;
}

@property (strong, nonatomic) NSString *eid;
@property (strong, nonatomic) Ticket *ticket;
@property (assign, nonatomic) BOOL isChecking;//是否正在显示票信息

@property (strong, nonatomic) UITableView *barCodeTableView;

@property (strong, nonatomic) NSMutableArray *selectList;//选择的票种

@end
