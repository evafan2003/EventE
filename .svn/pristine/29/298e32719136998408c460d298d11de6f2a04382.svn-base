//
//  AddTicketTypeViewController.h
//  moshTickets
//
//  Created by 魔时网 on 14-3-7.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "AddActivityDetailVIewController.h"
#import "CommonCell.h"
#import "TicketType.h"

@interface AddTicketTypeViewController : AddActivityDetailVIewController<AddCellDelegate,editCellDelegate,sucCellDelegate>

@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic ,strong) TicketType *type;//当前编辑的票种 currentState_edit_ticket状态时使用
- (IBAction)addForm:(id)sender;
- (IBAction)launchActivity:(id)sender;
@end
