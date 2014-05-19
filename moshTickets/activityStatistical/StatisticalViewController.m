//
//  StatisticalViewController.m
//  moshTickets
//
//  Created by 魔时网 on 13-11-25.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "StatisticalViewController.h"
#import "ControllerFactory.h"

static CGFloat titleLabelWight = 300;//活动标题宽度
static CGFloat titleFontSize = 17;//活动标题字体大小
static CGFloat actTitleExtendHeight = 15;//活动标题高度补偿值

static CGFloat listTitleLabelHeight = 28;//列表头高度
static CGFloat listTitleFontSize = 13;//列表头字体大小

static CGFloat rowFontSize = 13;//列表字体大小
static CGFloat rowExtendHeight = 10;//列表行高度补偿值

static CGFloat firstLabelOffset = 5;
static CGFloat firstLabelWight = 105;
static CGFloat otherLabelWight = 70;

@interface StatisticalViewController ()

@end

@implementation StatisticalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithActivity:(Activity *)act dataArray:(NSMutableArray *)array
{
    if (self = [super init]) {
        _act = act;
        self.dataArray = array;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    labelNumber = 4;
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemNone title:@""];
    
    [self createTitleLabel];
    [self createInfoView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) createTitleLabel
{
    CGSize size = [GlobalConfig getAdjustHeightOfContent:_act.title width:titleLabelWight fontSize:titleFontSize];
    _titleLabel = [GlobalConfig createLabelWithFrame:CGRectMake(POINT_X + 10, POINT_Y, size.width,actTitleExtendHeight + size.height) Text:_act.title FontSize:titleFontSize textColor:BLACKCOLOR];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = UITextAlignmentLeft;
    [self.view addSubview:_titleLabel];
}

- (void) createInfoView
{
    UIView *labelView = [GlobalConfig createViewWithFrame:CGRectMake(POINT_X, _titleLabel.frame.size.height, SCREENWIDTH, listTitleLabelHeight)];
    labelView.backgroundColor = [UIColor colorWithRed:0 green:180/255.0f blue:237/255.0f alpha:1];
    for (NSInteger i = 0;i < labelNumber;i++) {
        UILabel *label = [GlobalConfig createLabelWithFrame:[self rectOfLabel:i height:listTitleLabelHeight] Text:[self listLabelName:i] FontSize:listTitleFontSize textColor:WHITECOLOR];
        [labelView addSubview:label];
    }
    [self.view addSubview:labelView];
    
    CGFloat tableOffSetHeight = _titleLabel.frame.size.height + listTitleLabelHeight;
    self.baseTableView.frame = CGRectMake(POINT_X,tableOffSetHeight , SCREENWIDTH, self.baseTableView.frame.size.height - tableOffSetHeight);
    
    //最底下灰色细线
    UIView *view = [GlobalConfig createViewWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1)];
    view.backgroundColor = rowGrayColor;
    self.baseTableView.tableFooterView = view;
}

- (NSString *) listLabelName:(NSInteger)index
{
    return @"";
}

- (NSString *) contentOfCellInIndexPath:(NSIndexPath *)indexPath labelIndex:(NSInteger)index
{
    return @"";
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [GlobalConfig getAdjustHeightOfContent:[self contentOfCellInIndexPath:indexPath labelIndex:0] width:[self rectOfLabel:0 height:0].size.width fontSize:rowFontSize];

    return size.height + rowExtendHeight;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            for (int i = 0;i < labelNumber;i++) {
            
            UILabel *label = [GlobalConfig createLabelWithFrame:[self rectOfLabel:i height:cell.frame.size.height] Text:@"" FontSize:rowFontSize textColor:BLACKCOLOR];
            
            label.tag = 100 + i;
            label.numberOfLines = 0;
            [cell addSubview:label];
        }
    }
    //改变label的高度
    [self changeLabelHeightWithCell:cell indexPath:(indexPath)];
    //更换背景
    [self changeBackgroundColorWithCell:cell indexPath:indexPath];
    
    //赋值
    [self reloadDataWithCell:cell indexPath:indexPath];
    
    return cell;
}

- (CGRect) rectOfLabel:(NSInteger)integer height:(CGFloat)height
{
    switch (integer) {
        case 0:
            return CGRectMake(firstLabelOffset, 0, firstLabelWight, height);
            break;
        case 1:
            return CGRectMake(firstLabelOffset + firstLabelWight, 0, otherLabelWight, height);
            break;
        case 2:
            return CGRectMake(firstLabelOffset + firstLabelWight + otherLabelWight,0 ,otherLabelWight, height);
            break;
        case 3:
            return CGRectMake(firstLabelOffset + firstLabelWight + otherLabelWight * 2, 0, otherLabelWight, height);
        default:
            return CGRectNull;
            break;
    }
}

- (void) changeLabelHeightWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    CGSize size = [GlobalConfig getAdjustHeightOfContent:[self contentOfCellInIndexPath:indexPath labelIndex:0] width:[self rectOfLabel:0 height:0].size.width fontSize:rowFontSize];
    
    CGFloat rowHeight = size.height + rowExtendHeight;
    
    for (int i = 0;i < labelNumber;i++) {
        UILabel *label = (UILabel *)[cell viewWithTag: 100 + i];
        CGRect rect = label.frame;
        label.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rowHeight);
    }
}

- (void) changeBackgroundColorWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
         cell.backgroundColor = CLEARCOLOR;
        cell.contentView.backgroundColor = CLEARCOLOR;
    }
    else {
        cell.backgroundColor = rowGrayColor;
        cell.contentView.backgroundColor = rowGrayColor;
    }
}

- (void) reloadDataWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexpath
{
    for (int i = 0;i < labelNumber;i++) {
        UILabel *label = (UILabel *)[cell viewWithTag:100 + i];
        label.text = [self contentOfCellInIndexPath:indexpath labelIndex:i];
    }
}

@end
