//
//  CommonCell.h
//  LaunchActivuty
//
//  Created by 魔时网 on 14-3-5.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddCellDelegate;
@protocol editCellDelegate;
@protocol sucCellDelegate;

@interface CommonCell : UITableViewCell

@end

@interface addCell : UITableViewCell

- (IBAction)addPress:(id)sender;

@property (nonatomic, assign) id<AddCellDelegate> delegate;

@end

@interface editCell : UITableViewCell<UITextFieldDelegate>

- (IBAction)confirmPress:(id)sender;
- (IBAction)canclePress:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (nonatomic, assign) id<editCellDelegate> delegate;
@end


@interface sucCell : UITableViewCell

- (IBAction)editPress:(id)sender;
- (IBAction)delPress:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (nonatomic, assign) id<sucCellDelegate> delegate;
@end



@protocol AddCellDelegate <NSObject>

- (void) addButtonPress:(UITableViewCell *)cell;

@end


@protocol editCellDelegate <NSObject>

- (void) cancleButtonPress:(UITableViewCell *)cell;

- (void) confirmButtonPress:(UITableViewCell *)cell;

@end

@protocol sucCellDelegate <NSObject>

- (void) editButtonPress:(UITableViewCell *)cell;

- (void) delButtonPress:(UITableViewCell *)cell;

@end