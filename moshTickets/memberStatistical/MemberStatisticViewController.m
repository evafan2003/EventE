//
//  MenberStatisticViewController.m
//  moshTickets
//
//  Created by 魔时网 on 14-2-20.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "MemberStatisticViewController.h"
#import "MemberInfo.h"
#import "HTTPClient.h"
#import "ControllerFactory.h"
#import "HTTPClient+Members.h"
#import "MoshTicketDatabase.h"

static NSString *allMemberInfo = @"全部购票者信息";
static CGFloat navViewWidth = 200.0f;
static CGFloat navImageWidth = 25.0f;
static CGFloat navViewHeight = 44.0f;
static CGFloat pickerViewwidth = 320.0f;
static CGFloat pickerViewHeight = 150.0f;

@interface MemberStatisticViewController ()

@end

@implementation MemberStatisticViewController

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
    labelNumber = 3;
    self.ticketTypeArray = [NSMutableArray arrayWithArray:_act.tickedTypeArray];
    self.type = [TicketType ticketType:@{@"tid":@"",@"ticket_name":allMemberInfo}];
    [self.ticketTypeArray insertObject:self.type atIndex:0];
    
    [self createSearchBar];
    self.baseTableView.contentOffset = CGPointMake(0, 44);
    [self createNavTitleView];
    [self createPickerView];
    [self downloadData];
    
    //添加消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memberDownloadSuccess:) name:Notification_MemberSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memberDownLoadFail) name:Notification_MemberFail object:nil];
}

- (void) createNavTitleView
{
    UIView *view = [GlobalConfig createViewWithFrame:CGRectMake(0, 0, navViewWidth, navViewHeight)];
    self.navLabel = [GlobalConfig createLabelWithFrame:CGRectMake(0, 0, 0, navViewHeight) Text:allMemberInfo FontSize:17 textColor:WHITECOLOR];
    self.navLabel.numberOfLines = 2;
    self.navLabel.textAlignment = UITextAlignmentLeft;
    CGRect rect =  self.navLabel.frame;
    CGRect rect1 =  [self.navLabel textRectForBounds:CGRectMake(0, 0,navViewWidth - navImageWidth, navViewHeight) limitedToNumberOfLines:2];
    rect.size.width = rect1.size.width;
    rect.origin.x = (navViewWidth - rect.size.width - navImageWidth)/2;
    self.navLabel.frame = rect;
   
    
    self.navImage = [GlobalConfig createImageViewWithFrame:CGRectMake(_navLabel.frame.size.width + _navLabel.frame.origin.x, 0, navImageWidth,navViewHeight) ImageName:@"nav_open"];

    UIButton *button = [GlobalConfig createButtonWithFrame:view.frame ImageName:nil Title:nil Target:self Action:@selector(changeTicketType)];
    [view addSubview:button];
    [view addSubview:_navLabel];
    [view addSubview:_navImage];
    
    self.navigationItem.titleView = view;
    
}

#pragma mark -download -
- (void) memberDownloadSuccess:(NSNotification *)noti
{
    NSNumber *progress = [noti object];
    if ([progress isKindOfClass:[NSNumber class]]) {
        if ([progress floatValue]  >= 1.0) {
            dispatch_async(dispatch_get_main_queue(), ^{
               
                self.loadingView.progress = [progress floatValue];
                [self hideLoadingView];
                self.loadingView.mode = MBProgressHUDModeIndeterminate;
                [self downloadDataFromDatabase];
            });
        }
    }
}

- (void) memberDownLoadFail
{
    [self hideLoadingView];
    self.loadingView.mode = MBProgressHUDModeIndeterminate;
    [GlobalConfig showAlertViewWithMessage:ERROR_LOADINGFAIL superView:self.view];
    [self downloadDataFromDatabase];
}

//- (void) downloadDataFromDatabase
//{
//    self.searchBar.text = nil;
//    self.searchBar.showsCancelButton = NO;
//    
//    self.memberArray = [[MoshTicketDatabase sharedInstance] getAllMemberByEid:_act.eid ticketID:self.type.tTypeID];
//    self.dataArray = self.memberArray;
//    [self.baseTableView reloadData];
//}

- (void) downloadDataFromDatabase
{
    self.searchBar.text = nil;
    self.searchBar.showsCancelButton = NO;
    self.memberArray  = [NSMutableArray array];
    
    NSMutableArray *member = [[MoshTicketDatabase sharedInstance] getAllMemberByEid:_act.eid ticketID:self.type.tTypeID];
    for (int i = 0;i < member.count;i++) {
        MemberInfo *info = member[i];
        if (i == 0) {
            [self.memberArray addObject:info];
        }
        else {
            for (int j= 0;j < self.memberArray.count;j++) {
                MemberInfo *info2 = self.memberArray[j];
                
                //如果两个人信息相同
                if ([info IsEqualMember:info2]) {
                    for (int k = 0;k < info2.tickedTypeArray.count;k++) {
                        
                        if (info.tickedTypeArray.count > 0) {
                            TicketType *type = info.tickedTypeArray[0];
                            TicketType *type2 = info2.tickedTypeArray[k];
                            //如果票信息相同
                            if ([type isEqual:type2]) {
                                type2.number = [NSString stringWithFormat:@"%d",([type2.number integerValue] + [type.number integerValue])];
                                break;
                            }
                            else {
                                //如果不相同则添加
                                if (k == (info2.tickedTypeArray.count - 1)) {
                                    [info2.tickedTypeArray addObject:type];
                                    break;
                                }
                            }
                        }
                    }
                    break;
                }
                else {//两个人不相同
                    
                    if (j == (self.memberArray.count - 1)) {
                        [self.memberArray addObject:info];
                        break;
                    }
                }
            }
        }
    }
    self.dataArray = self.memberArray;
    [self.baseTableView reloadData];
}

- (void) progressChange
{

}

- (void) downloadData
{
    //加载
    [self showLoadingView];
    self.loadingView.mode = MBProgressHUDModeAnnularDeterminate;
    
    [[HTTPClient shareHTTPClient] memberInfoWithEid:_act.eid
                                       ticketTypeID:self.type.tTypeID];

    //虚假动画
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        while (self.loadingView.progress < 0.9) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.loadingView.progress += 0.01;
            });
            
            usleep(500000);
        }
    });
}


- (void) changeTicketType
{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.frame = CGRectMake(0, SCREENHEIGHT - NAVHEIGHT - pickerViewHeight, pickerViewwidth, pickerViewHeight);
        self.toolBar.frame = CGRectMake(0, self.pickerView.frame.origin.y - 30, pickerViewwidth, 30);
    }];
}

- (void)createPickerView
{
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT, pickerViewwidth, pickerViewHeight)];
    self.pickerView.backgroundColor = WHITECOLOR;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:self.pickerView];
    
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.pickerView.frame.origin.y - 30, pickerViewwidth, 30)];
    self.toolBar.backgroundColor = [UIColor blackColor];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(pickerViewSelected)];
    self.toolBar.items = [NSArray arrayWithObjects:space,done, nil];
    [self.view addSubview:self.toolBar];
}

- (NSMutableArray *) searchMemberWithInfo:(NSString *)info
{
    NSMutableArray *array = [NSMutableArray array];

    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:info]) {
        for (MemberInfo *mem in self.memberArray) {
            if ([mem memberIsContainInfo:info]) {
                [array addObject:mem];
            }
        }
        return array;
    }
    else {
        array = self.memberArray;
        return array;
    }

}

#pragma mark
#pragma UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    self.dataArray = [self searchMemberWithInfo:searchBar.text];
    
    [self.baseTableView reloadData];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    
    self.dataArray = [self searchMemberWithInfo:searchBar.text];
    [self.baseTableView reloadData];
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
}


#pragma  mark - pickerView -
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.ticketTypeArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    TicketType *type = (TicketType *)self.ticketTypeArray[row];
    return type.tTypeName;
}

- (void) pickerViewSelected
{
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    if (row < self.ticketTypeArray.count && row >= 0) {
    
        TicketType *type = (TicketType *)self.ticketTypeArray[row];
        if (self.type != type) {
            self.type = type;
            self.navLabel.text = type.tTypeName;
            CGRect rect =  self.navLabel.frame;
            CGRect rect1 =  [self.navLabel textRectForBounds:CGRectMake(0, 0,navViewWidth - navImageWidth, navViewHeight) limitedToNumberOfLines:2];
            rect.size.width = rect1.size.width;
            rect.origin.x = (navViewWidth - rect.size.width - navImageWidth)/2;
            self.navLabel.frame = rect;
            
            self.navImage.frame = CGRectMake(_navLabel.frame.size.width + _navLabel.frame.origin.x, 0, navImageWidth,navViewHeight);
            [self downloadDataFromDatabase];
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerView.frame = CGRectMake(0, SCREENHEIGHT, pickerViewwidth, pickerViewHeight);
        self.toolBar.frame = CGRectMake(0, self.pickerView.frame.origin.y - 30, pickerViewwidth, 30);
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) listLabelName:(NSInteger)index
{
    switch (index) {
        case 0:
            return @"姓名";
        case 1:
            return @"手机";
        case 2:
            return @"邮箱";
        default:
            return @"";
            break;
    }
}

- (CGRect) rectOfLabel:(NSInteger)integer height:(CGFloat)height
{
    switch (integer) {
        case 0:
            return CGRectMake(5, 0, 70, height);
            break;
        case 1:
            return CGRectMake(75, 0, 90, height);
            break;
        case 2:
            return CGRectMake(165,0 ,150, height);
            break;
        default:
            return CGRectNull;
            break;
    }

}

- (NSString *) contentOfCellInIndexPath:(NSIndexPath *)indexPath labelIndex:(NSInteger)index
{
    MemberInfo *resource = (MemberInfo *)self.dataArray[indexPath.row];
    switch (index) {
        case 0:
            return resource.name;
            break;
        case 1:
            return resource.phoneNumber;
            break;
        case 2:
            return resource.email;
            break;
        default:
            return @"";
            break;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      MemberInfo *resource = (MemberInfo *)self.dataArray[indexPath.row];
    [self.navigationController pushViewController:[ControllerFactory singleMemberViewControllerWithMemberInfo:resource] animated:YES];
}



@end
