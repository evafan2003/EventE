//
//  AddTicketTypeViewController.m
//  moshTickets
//
//  Created by 魔时网 on 14-3-7.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "AddTicketTypeViewController.h"
#import "TicketType.h"

static NSString *addCellID = @"addCell";
static NSString *editCellID = @"editCell";
static NSString *sucCellID = @"sucCell";

@interface AddTicketTypeViewController ()

@end

@implementation AddTicketTypeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemNone title:NAVTITLE_ADDTICKETTYPE];
    self.baseTableView.tableFooterView = self.footerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark override -

- (UITableViewCell *)sucCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    sucCell  * cell = [tableView dequeueReusableCellWithIdentifier:sucCellID];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CommonCell class]) owner:self options:nil] objectAtIndex:2];
        cell.delegate = self;
    }
    
    if (indexPath.row < self.dataArray.count) {
        TicketType *type = (TicketType *)self.dataArray[indexPath.row];
        cell.name.text = type.tTypeName;
        cell.price.text = [NSString stringWithFormat:@"票价：%@  可售票数：%@",type.price,type.number];
    }
    
    return cell;
}

- (UITableViewCell *)addCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    addCell * cell = [tableView dequeueReusableCellWithIdentifier:addCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CommonCell class]) owner:self options:nil] objectAtIndex:1];
        cell.delegate = self;
    }
    return cell;
}

- (UITableViewCell *)editCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath
{
    editCell * cell = [tableView dequeueReusableCellWithIdentifier:editCellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CommonCell class]) owner:self options:nil] objectAtIndex:0];
        cell.delegate = self;
    }
    if (self.state == currentState_edit_ticket) {
        cell.name.text = self.type.tTypeName;
        cell.price.text = self.type.price;
        cell.number.text = self.type.number;
    }
    return cell;
}

- (CGFloat) cellHeightOfCellType:(cellType)type
{
    switch (type) {
        case cellType_suc:
            return 98.0f;
            break;
        case cellType_edit:
            return 185.0f;
            break;
        case cellType_add:
            return 48.0f;
            break;
        default:
            break;
    }
}

- (void) confirmButtonPress:(UITableViewCell *)cell
{
    editCell *edit = (editCell *)cell;
    if (![GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:edit.name.text Alert:@"票种名称不能为空"])
    {
        return;
    }
    if (![GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:edit.price.text Alert:@"票种价格不能为空"])
    {
        return;
    }
    if (![GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:edit.number.text Alert:@"票种可售数量不能为空"])
    {
        return;
    }
    
    TicketType *type = [[TicketType alloc] init];
    type.tTypeName = edit.name.text;
    type.number = edit.number.text;
    type.price = edit.price.text;
    
    [self.dataArray addObject:type];
    
    [super confirmButtonPress:cell];
    
}

- (void) editButtonPress:(UITableViewCell *)cell
{
    NSIndexPath *path = [self.baseTableView indexPathForCell:cell];
    self.type = (TicketType *)[self.dataArray objectAtIndex:path.row];
    
    [self.dataArray removeObject:self.type];
    self.state = currentState_edit_ticket;
    [self animationWithReloadData];
    
     [self.baseTableView setContentOffset:CGPointMake(0,[self cellHeightOfCellType:cellType_suc] * self.dataArray.count) animated:YES];

}

- (void) cancleButtonPress:(UITableViewCell *)cell
{
    if (self.state == currentState_edit_ticket) {
        [self.dataArray addObject:self.type];
    }
    [super cancleButtonPress:cell];
}

#pragma  mark - tableViewdelegate -
- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
   
    UITableViewCell *cell = [self.baseTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count inSection:0]];
    if ([cell isKindOfClass:[editCell class]]) {
        editCell *edit = (editCell *)cell;
        [edit.name resignFirstResponder];
        [edit.price resignFirstResponder];
        [edit.number resignFirstResponder];
    }
}


- (IBAction)addForm:(id)sender {
}

- (IBAction)launchActivity:(id)sender {
}
@end
