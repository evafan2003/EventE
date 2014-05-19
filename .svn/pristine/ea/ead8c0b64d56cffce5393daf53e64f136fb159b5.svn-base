//
//  ActivityCell.m
//  moshTickets
//
//  Created by 魔时网 on 13-11-18.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)checkStatisticalResult:(id)sender {
    [self.delegate checkStatisticalWithCell:self];
}

- (IBAction)checkTicket:(id)sender {
    [self.delegate checkTicketWithCell:self];
}

- (IBAction)memberInfo:(id)sender {
    [self.delegate memberInfoWithCell:self];
}
@end
