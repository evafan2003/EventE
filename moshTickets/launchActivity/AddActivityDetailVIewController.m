//
//  AddActivityDetailVIewController.m
//  moshTickets
//
//  Created by 魔时网 on 14-3-7.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "AddActivityDetailVIewController.h"

@interface AddActivityDetailVIewController ()

@end

@implementation AddActivityDetailVIewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.state = currentState_add;
    [self initWithTableView];
    
}

#pragma mark - privateAction -
- (void) initWithTableView
{
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (UITableViewCell *)sucCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

- (UITableViewCell *)addCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;}

- (UITableViewCell *)editCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}
- (CGFloat) cellHeightOfCellType:(cellType)type
{
    return 0;
}


#pragma  mark - tableViewDelegate -

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count + 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.dataArray.count) {
        return [self cellHeightOfCellType:cellType_suc];
    }
    else {
        switch (self.state) {
            case currentState_add:
                return [self cellHeightOfCellType:cellType_add];
                break;
            case currentState_edit:
                return [self cellHeightOfCellType:cellType_edit];
                break;
            case currentState_edit_ticket:
                return [self cellHeightOfCellType:cellType_edit];
                break;
            default:
                return 0;
                break;
        }
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if (indexPath.row < self.dataArray.count) {
        cell = [self sucCellWithTableView:tableView IndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        switch (self.state) {
            case currentState_add:
                cell = [self addCellWithTableView:tableView IndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            case currentState_edit:
                cell = [self editCellWithTableView:tableView IndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            case currentState_edit_ticket:
                cell = [self editCellWithTableView:tableView IndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            default:
                cell = [[UITableViewCell alloc] init];
                break;
        }
    }
    return cell;
}


#pragma  mark - cellDelegate -
- (void) addButtonPress:(UITableViewCell *)cell
{
    self.state = currentState_edit;
    [self animationWithReloadData];
    
    
     [self.baseTableView setContentOffset:CGPointMake(0,[self cellHeightOfCellType:cellType_suc] * self.dataArray.count) animated:YES];
}

- (void) editButtonPress:(UITableViewCell *)cell
{
    NSIndexPath *path = [self.baseTableView indexPathForCell:cell];
    [self.dataArray removeObjectAtIndex:path.row];
    self.state = currentState_edit;
    [self animationWithReloadData];
}

- (void) confirmButtonPress:(UITableViewCell *)cell
{
    self.state = currentState_add;
    [self animationWithReloadData];
    
}

- (void) cancleButtonPress:(UITableViewCell *)cell
{
    self.state = currentState_add;
    [self animationWithReloadData];
    
}

- (void) delButtonPress:(UITableViewCell *)cell
{
    NSIndexPath *path = [self.baseTableView indexPathForCell:cell];

    [self.dataArray removeObjectAtIndex:path.row];
    [self.baseTableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
    
   
}

- (void) animationWithReloadData
{
        [self.baseTableView reloadData];
//    [UIView animateWithDuration:0.3 animations:^{
//        self.view.alpha = 0;
//        
//    }completion:^(BOOL finish){
//        [UIView animateWithDuration:0.3 animations:^{
//            self.view.alpha = 1;
//        }];
//    }];
}


@end
