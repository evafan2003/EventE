//
//  AddActivityDetailVIewController.h
//  moshTickets
//
//  Created by 魔时网 on 14-3-7.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "BaseTableViewController.h"
#import "CommonCell.h"

typedef enum {
    currentState_add,//添加票种状态
    currentState_edit,//编辑无内容状态
    currentState_edit_ticket,//编辑有内容状态
    
} currentState;//当前状态

typedef enum {
    cellType_add,
    cellType_edit,
    cellType_suc,
} cellType;

@interface AddActivityDetailVIewController : BaseTableViewController

@property (nonatomic, assign) currentState      state;


- (void) animationWithReloadData;
/*
 override
 */
- (UITableViewCell *)sucCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)addCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;

- (UITableViewCell *)editCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath;

- (void) confirmButtonPress:(UITableViewCell *)cell;

- (CGFloat) cellHeightOfCellType:(cellType)type;
/*
 如无需要可以不重写
 */

- (void) addButtonPress:(UITableViewCell *)cell;

- (void) editButtonPress:(UITableViewCell *)cell;

- (void) cancleButtonPress:(UITableViewCell *)cell;

- (void) delButtonPress:(UITableViewCell *)cell;



@end
