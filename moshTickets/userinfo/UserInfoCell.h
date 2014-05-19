//
//  UserInfoCell.h
//  moshTickets
//
//  Created by 魔时网 on 14-5-7.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end
