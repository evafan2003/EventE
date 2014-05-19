//
//  ActivityCell.h
//  moshTickets
//
//  Created by 魔时网 on 13-11-18.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityCellDelegate;


@interface ActivityCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;
@property (weak, nonatomic) IBOutlet UILabel *activityTitle;
@property (weak, nonatomic) IBOutlet UILabel *activityDate;
@property (weak, nonatomic) IBOutlet UILabel *activityAddress;
@property (nonatomic, assign) id<ActivityCellDelegate> delegate;
//查看统计
- (IBAction)checkStatisticalResult:(id)sender;

//验票
- (IBAction)checkTicket:(id)sender;

//报名信息
- (IBAction)memberInfo:(id)sender;

@end



@protocol ActivityCellDelegate <NSObject>

- (void) checkStatisticalWithCell:(ActivityCell *)cell;
- (void) checkTicketWithCell:(ActivityCell *)cell;
- (void) memberInfoWithCell:(ActivityCell *)cell;

@end