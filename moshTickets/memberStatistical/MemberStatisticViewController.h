//
//  MenberStatisticViewController.h
//  moshTickets
//
//  Created by 魔时网 on 14-2-20.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "StatisticalViewController.h"
#import "Activity.h"
#import "TicketType.h"

@interface MemberStatisticViewController : StatisticalViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) TicketType *type;
@property (nonatomic, strong) NSMutableArray *ticketTypeArray;//票种数组
@property (nonatomic, strong) NSMutableArray *memberArray;//全部购票者Array

@property (nonatomic, strong) UILabel *navLabel;
@property (nonatomic, strong) UIImageView *navImage;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *toolBar;

@end
