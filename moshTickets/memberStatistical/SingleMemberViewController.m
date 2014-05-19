//
//  SingleMemberViewController.m
//  moshTickets
//
//  Created by 魔时网 on 14-2-20.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "SingleMemberViewController.h"
#import "GlobalConfig.h"

static CGFloat rowFontSize = 14.0f;
static CGFloat rowHeight = 38.0f;

@interface SingleMemberViewController ()

@end

@implementation SingleMemberViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithMember:(MemberInfo *)member
{
    if (self = [super init]) {
        self.member = member;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:240/255.0f green:239/255.0f blue:244/255.0f alpha:1];
    self.baseTableView.separatorColor = [UIColor colorWithRed:230/255.0f green:239/255.0f blue:244/255.0f alpha:1];
    self.baseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    self.baseTableView.separatorInset = UIEdgeInsetsZero;
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemNone title:NAVTITLE_SINGLEMEMBER];
//    [self downloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) downloadData
//{
//    //加载
//    [self showLoadingView];
//    [[HTTPClient shareHTTPClient] singleMemberInfoWithEid:self.member.eid
//                                                      tid:self.member.tid
//                                                      uuid:self.member.uid
//                                                  isentry:self.member.isentry
//                                                  success:^(MemberInfo *info){
//                                                      [self hideLoadingView];
//                                                      self.member = info;
//                                                      [self.baseTableView reloadData];
//    }
//                                                     fail:^{
//                                                         [self hideLoadingView];
//                                                         [GlobalConfig showAlertViewWithMessage:ERROR_LOADINGFAIL superView:self.view];
//    }];
//}


//是否存在报名表
- (BOOL) isHaveOtherInfo
{
    return [GlobalConfig isKindOfNSArrayClassAndCountGreaterThanZero:self.member.otherInfoArray];
}

- (UITableViewStyle) returnBaseTableViewStyle
{
    return UITableViewStyleGrouped;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            if ([self isHaveOtherInfo]) {
                return self.member.otherInfoArray.count;
            }
            else {
                return 3;
            }
            break;
        case 1:
            return self.member.tickedTypeArray.count;
            break;
        default:
            return 0;
            break;
    }
}

//- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    switch (section) {
//        case 0:
//            return @"";
//            break;
//        case 1:
//            return @"购票数量";
//            break;
//            
//        default:
//            return @"";
//            break;
//    }
//}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, [self tableView:tableView heightForHeaderInSection:section])];
    
    view.backgroundColor = CLEARCOLOR;
    
    if (section == 1) {
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 2, view.frame.size.height - 4)];
        image.backgroundColor = [UIColor colorWithRed:1/255.0f green:175/255.0f blue:236/255.0f alpha:1];
        [view addSubview:image];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, SCREENWIDTH, [self tableView:tableView heightForHeaderInSection:section])];
        label.text = @"购票数量";
        label.backgroundColor = CLEARCOLOR;
        label.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1];
        [view addSubview:label];
        
    }
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"singleMember";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (int i = 0;i < 2;i++) {
            
            UILabel *label = [GlobalConfig createLabelWithFrame:[self rectOfLabel:i height:[self tableView:tableView heightForRowAtIndexPath:indexPath]] Text:@"" FontSize:rowFontSize textColor:BLACKCOLOR];
            label.textAlignment = UITextAlignmentLeft;
           label.textColor =  BLACKCOLOR;

            if (i == 0) {
                label.textAlignment = UITextAlignmentRight;
                
                 label.textColor =  [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1];
            }
            label.tag = 100 + i;
            label.numberOfLines = 0;
            [cell addSubview:label];
        }
    }
//    //改变label的高度
//    [self changeLabelHeightWithCell:cell indexPath:(indexPath)];
    //更换背景
//    [self changeBackgroundColorWithCell:cell indexPath:indexPath];
    
    //赋值
    [self reloadDataWithCell:cell indexPath:indexPath];
    
    return cell;

}

//- (void) changeLabelHeightWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
//{
//    CGSize size = [GlobalConfig getAdjustHeightOfContent:[self contentOfCellInIndexPath:indexPath labelIndex:0] width:[self rectOfLabel:0 height:0].size.width fontSize:rowFontSize];
//    
//    CGFloat rowHeight = size.height + rowExtendHeight;
//    
//    for (int i = 0;i < labelNumber;i++) {
//        UILabel *label = (UILabel *)[cell viewWithTag: 100 + i];
//        CGRect rect = label.frame;
//        label.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rowHeight);
//    }
//}

- (void) changeBackgroundColorWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 1) {
        cell.backgroundColor = CLEARCOLOR;
        cell.contentView.backgroundColor = CLEARCOLOR;
    }
    else {
        cell.backgroundColor = rowGrayColor;
        cell.contentView.backgroundColor = rowGrayColor;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}

- (void) reloadDataWithCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexpath
{
    NSString *first = nil;
    NSString *second = nil;
    TicketType *type = nil;
    OtherInfo *info = nil;
    switch (indexpath.section) {
        case 0:
            if ([self isHaveOtherInfo]) {
                info = self.member.otherInfoArray[indexpath.row];
                first = [NSString stringWithFormat:@"%@：",[GlobalConfig convertToString:info.title]];
                second = [GlobalConfig convertToString:info.memberInfo];
            }
            else {
                switch (indexpath.row) {
                    case 0:
                        first = @"姓名：";
                        second = self.member.name;
                        break;
                    case 1:
                        first = @"手机号：";
                        second = self.member.phoneNumber;
                        break;
                    case 2:
                        first = @"邮箱：";
                        second = self.member.email;
                        break;
                    default:
                        break;
                }
            }
            break;
        case 1:
            type =  self.member.tickedTypeArray[indexpath.row];
            first = type.tTypeName;
            second = [NSString stringWithFormat:@"%@张",type.number];
            break;
        default:
            break;
    }
        UILabel *label = (UILabel *)[cell viewWithTag:100];
        label.text = first;
    
        UILabel *label1 = (UILabel *)[cell viewWithTag:101];
        label1.text = second;
    
    if (indexpath.section == 1) {
        label.frame = CGRectMake(5, 0, 150, rowHeight);
        label1.frame = CGRectMake(165, 0, 150, rowHeight);
        label.textAlignment = UITextAlignmentCenter;
        label1.textAlignment = UITextAlignmentCenter;
    }
    else {
        label.frame = [self rectOfLabel:0 height:rowHeight];
        label1.frame = [self rectOfLabel:1 height:rowHeight];
        label.textAlignment = UITextAlignmentRight;
        label1.textAlignment = UITextAlignmentLeft;
    }

}

- (CGRect) rectOfLabel:(NSInteger)integer height:(CGFloat)height
{
    switch (integer) {
        case 0:
            return CGRectMake(5, 0, 100, height);
            break;
        case 1:
            return CGRectMake(115, 0, 200, height);
            break;
        default:
            return CGRectNull;
            break;
    }
    
}


@end
