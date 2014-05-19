//
//  BaseViewController.m
//  modelTest
//
//  Created by mosh on 13-10-21.
//  Copyright (c) 2013年 mosh. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "GlobalConfig.h"
#import "TicketType.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if ([GlobalConfig versionIsIOS7]) {
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND;
    if (!self.dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    //loadingView
    [self createLoadingView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//私有方法 不需要写在.h文件中
#pragma privateAction
- (void) createLoadingView
{
    self.loadingView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.loadingView];
    [self hideLoadingView];
}

//受保护方法 继承类可用
#pragma protectAction
- (void) showLoadingView
{
    self.loadingView.labelText = [self returnLoadingViewLabelText];
    [self.view bringSubviewToFront:self.loadingView];
    [self.loadingView show:YES];
}

- (void)showProgressDialog:(int)current total:(int)total complete:(void (^)(void))complete {
    
    //设置模式为进度框形的
    self.loadingView.mode = MBProgressHUDModeAnnularDeterminate;
    
    [self.loadingView showAnimated:YES whileExecutingBlock:^{

            self.loadingView.progress = current;
            usleep(total);
        
    } completionBlock:^{
//        complete();
        [self hideLoadingView];
        
    }];
}

- (void) hideLoadingView
{
    [self.loadingView hide:YES];
}

- (NSString *) returnLoadingViewLabelText
{
    return LOADING;
}


+ (BaseViewController *) viewController
{
    return [[self alloc] init];
}

+ (BaseViewController *) viewControllerWithNib
{
    return [[self alloc] initWithNibName:NSStringFromClass(self.class) bundle:nil];
}

//公共方法
#pragma publicAction

- (void) createBarWithLeftBarItem:(MoshNavigationBarItemType)leftItem
                     rightBarItem:(MoshNavigationBarItemType)rightItem
                            title:(NSString *)title
{
    self.title = title;
    
    self.navigationItem.leftBarButtonItem = [self barButtonItemWithBarItemType:leftItem isLeft:YES];
    self.navigationItem.rightBarButtonItem = [self barButtonItemWithBarItemType:rightItem isLeft:NO];
    
}

- (UIBarButtonItem *) barButtonItemWithBarItemType:(MoshNavigationBarItemType)type isLeft:(BOOL)isLeft
{
    switch (type) {
        case MoshNavigationBarItemBack:
            return [BaseViewController createNavigationBarItemWithNormalImageName:NAVBUTTON_back highlightImageName:NAVBUTTON_back_h title:nil isLeft:isLeft action:@selector(navBackClick) target:self];
            break;
        case MoshNavigationBarItemList:
            return [BaseViewController createNavigationBarItemWithNormalImageName:NAVBUTTON_list highlightImageName:NAVBUTTON_list_h title:nil isLeft:isLeft action:@selector(navListClick) target:self];
            break;
        case MoshNavigationBarItemshare:
           return [BaseViewController createNavigationBarItemWithNormalImageName:NAVBUTTON_share highlightImageName:NAVBUTTON_share_h title:nil isLeft:isLeft action:@selector(navShareClick) target:self];
            break;
        case MoshNavigationBarItemUser:
            return [BaseViewController createNavigationBarItemWithNormalImageName:NAVBUTTON_user highlightImageName:NAVBUTTON_user_h title:nil isLeft:isLeft action:@selector(navUserClick) target:self];
            break;
        case MoshNavigationBarItemUserExited:
            return [BaseViewController createNavigationBarItemWithNormalImageName:NAVBUTTON_exit highlightImageName:NAVBUTTON_exit_h title:nil isLeft:isLeft action:@selector(navUserExitClick) target:self];
            break;
        case MoshNavigationBarItemDelete:
            return [BaseViewController createNavigationBarItemWithNormalImageName:NAVBUTTON_delete highlightImageName:NAVBUTTON_delete_h title:nil isLeft:isLeft action:@selector(navDeleteClick) target:self];
            break;
        case MoshNavigationBarItemRefresh:
            return [BaseViewController createNavigationBarItemWithNormalImageName:NAVBUTTON_refresh highlightImageName:NAVBUTTON_refresh_h title:nil isLeft:isLeft action:@selector(navRefreshClick) target:self];
            break;
        case MoshNavigationBarItemCheck:
            return [BaseViewController createNavigationBarItemWithNormalImageName:NAVBUTTON_check highlightImageName:NAVBUTTON_check_h title:nil isLeft:isLeft action:@selector(navCheckClick)target:self];
            break;
        case MoshNavigationBarItemNone:
            return nil;
            break;
        default:
            return nil;
            break;
    }
}

+ (UIBarButtonItem *) createNavigationBarItemWithNormalImageName:(NSString *)normalImageName
                                              highlightImageName:(NSString *)highlightImageName
                                                           title:(NSString *)title
                                                          isLeft:(BOOL)isLeft
                                                          action:(SEL)action
                                                          target:(id)vtl
{
    UIView *view = [GlobalConfig createViewWithFrame:CGRectMake( 0, 0, 44, 44)];
    view.clipsToBounds = YES;
    UIImage *image = [UIImage imageNamed:normalImageName];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    if ([title length] != 0) {
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    [button addTarget:vtl action:action forControlEvents:UIControlEventTouchUpInside];
    CGFloat pointX = 0;
//    if ([GlobalConfig versionIsIOS7]) {
//        pointX = (isLeft ? -10 : 6);
//    }
    button.frame = CGRectMake(pointX,0,image.size.width,image.size.height);
    [view addSubview:button];
    UIBarButtonItem *iteml = [[UIBarButtonItem alloc] initWithCustomView:view];
    return iteml;
}

- (void) downloadData
{
    
}

- (void) navListClick
{
}

- (void) navBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) navUserClick
{
}
- (void) navShareClick
{

}

- (void) navUserExitClick
{
    [GlobalConfig deleteUserInfo];
}

- (void) navDeleteClick
{
    
}

- (void) navRefreshClick
{
    
}

- (void) navCheckClick
{
    
}

- (NSString *) getDatabaseTicketID:(NSArray *)array
{
    NSMutableString *ticketID = nil;
    for (TicketType *type in [GlobalConfig convertToArray:array]) {
        if ([type isKindOfClass:[TicketType class]]) {
            if ([array indexOfObject:type] == 0) {
                ticketID = [NSMutableString stringWithString:type.tTypeID];
            }
            else {
                [ticketID appendString:[NSString stringWithFormat:@",%@",type.tTypeID]];
            }
        }
    }
    return ticketID;
}
@end
