//
//  CommonCell.m
//  LaunchActivuty
//
//  Created by 魔时网 on 14-3-5.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "CommonCell.h"
#import "GlobalConfig.h"

@implementation CommonCell

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

@end


@implementation editCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)confirmPress:(id)sender {
    [self.delegate confirmButtonPress:self];
}

- (IBAction)canclePress:(id)sender {
    [self.delegate cancleButtonPress:self];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSArray *array = @[_name,_price,_number];
    [GlobalConfig textFieldReturnKeyWithArray:array fistResponder:textField andAnimationBlock:^{
    }];
    return YES;
}
@end

@implementation addCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)addPress:(id)sender {
    [self.delegate addButtonPress:self];
}
@end

@implementation sucCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)editPress:(id)sender {
    [self.delegate editButtonPress:self];
}

- (IBAction)delPress:(id)sender {
    [self.delegate delButtonPress:self];
}
@end
