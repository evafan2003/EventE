//
//  TicketCheckViewController.m
//  MoshTicket
//
//  Created by evafan2003 on 12-6-15.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import "TicketCheckViewController.h"
#import "GlobalConfig.h"
#import "MoshTicketDatabase.h"  

#define SEGMENT_TAG 20

@interface TicketCheckViewController ()

@end

@implementation TicketCheckViewController

//验票页面
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemNone title:NAVTITLE_CHECK];
    [self loadTicket];

        //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadTicket) name:Notification_checkTicket object:nil];

    [self initSubViews];
     [self createChildrenControllers];
    [self segmentClickedAtIndex:0 onCurrentCell:YES from:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initSubViews {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,320.0f, 38.0f)];
    topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab"]];
    
    //段选择器
    PLSegmentView *segmentView = [[PLSegmentView alloc] initWithFrame:CGRectMake(0.0f, -6.0f, 320.0f, 38.0f)];
    segmentView.delegate = self;
    segmentView.segmentType = segmentTypeDefault;
    NSArray *textShow = [NSArray arrayWithObjects:@"电子票检票",@"二维码检票",@"手机号查询", nil];
    [segmentView setupCellsByTextShow:textShow offset:CGSizeMake(107.0f, 0.0f)];
    segmentView.selectedIndex = 0;
    segmentView.tag = SEGMENT_TAG;
    [topView addSubview:segmentView];
    [self.view addSubview:topView];
    
}

- (void) createChildrenControllers
{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 38, SCREENWIDTH, SCREENHEIGHT - NAVHEIGHT - 38)];
    _checkSearchCtl = (CheckSearchViewController *)[CheckSearchViewController viewControllerWithNib];
    _checkSearchCtl.eid = self.eid;
    _checkSearchCtl.selectList = self.selectList;
    _checkSearchCtl.view.frame = CGRectMake(0, 38, SCREENWIDTH, SCREENHEIGHT - 38);
    [self.view addSubview:_checkSearchCtl.view];
    [self addChildViewController:_checkSearchCtl];
    
    _checkBarCodeCtl =(CheckBarCodeViewController *) [CheckBarCodeViewController viewControllerWithNib];
    _checkBarCodeCtl.eid = self.eid;
    _checkBarCodeCtl.selectList = self.selectList;
        _checkBarCodeCtl.view.frame = CGRectMake(0, 38, SCREENWIDTH, SCREENHEIGHT  - 38);

    [self.view addSubview:_checkBarCodeCtl.view];
    [self addChildViewController:_checkBarCodeCtl];
    
    _checkPasswordCtl = (CHeckPasswordViewController *)[CHeckPasswordViewController viewControllerWithNib];
    _checkPasswordCtl.eid = self.eid;
    _checkPasswordCtl.selectList = self.selectList;
        _checkPasswordCtl.view.frame = CGRectMake(0, 38, SCREENWIDTH, SCREENHEIGHT  - 38);

    [self.view addSubview:_checkPasswordCtl.view];
    [self addChildViewController:_checkPasswordCtl];
}


//-(void)loadTicket {
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//
////            NSString *ticketID = [self getDatabaseTicketID:self.selectList];
////            if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:ticketID]) {
////                self.ticketList = [[MoshTicketDatabase sharedInstance] getAllTicketByEid:self.eid ticketID:ticketID];
////                self.usedTicketList = [[MoshTicketDatabase sharedInstance] getAllTicketByEid:self.eid status:ticketState_isUsed ticketID:ticketID];
////            }
////            else {
////                self.ticketList = [[MoshTicketDatabase sharedInstance] getAllTicketByEid:self.eid];
////                self.usedTicketList = [[MoshTicketDatabase sharedInstance] getAllTicketByEid:self.eid status:ticketState_isUsed];
////            }
////        
////            dispatch_async(dispatch_get_main_queue(), ^{
////            
////                _checkSearchCtl.checkTicketNumberLabel.text = [NSString stringWithFormat:@"已验票/总票数 %i/%i", [self.usedTicketList count], [self.ticketList count]];
////                self.title = [NSString stringWithFormat:@"已检%i张/总%i张", [self.usedTicketList count], [self.ticketList count]];
////            });
//        
//        NSString *ticketID = [self getDatabaseTicketID:self.selectList];
//        
//        int usedCount = [[MoshTicketDatabase sharedInstance] getAllTicketCountByEid:self.eid status:ticketState_isUsed ticketID:ticketID];
//        int totalCount = [[MoshTicketDatabase sharedInstance] getAllTicketCountByEid:self.eid status:nil ticketID:ticketID];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            _checkSearchCtl.checkTicketNumberLabel.text = [NSString stringWithFormat:@"已验票/总票数 %i/%i", usedCount,totalCount];
//            self.title = [NSString stringWithFormat:@"已检%i张/总%i张",usedCount,totalCount];
//        });
//        
//        
//        
//    });
//}

-(void)loadTicket {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *ticketID = [self getDatabaseTicketID:self.selectList];
        
        int usedCount = [[MoshTicketDatabase sharedInstance] getAllTicketCountByEid:self.eid status:ticketState_isUsed ticketID:ticketID];
        int totalCount = [[MoshTicketDatabase sharedInstance] getAllTicketCountByEid:self.eid status:nil ticketID:ticketID];
        
        
            _checkSearchCtl.checkTicketNumberLabel.text = [NSString stringWithFormat:@"已验票/总票数 %i/%i", usedCount,totalCount];
            self.title = [NSString stringWithFormat:@"已检%i张/总%i张",usedCount,totalCount];
        
    });
}





#pragma mark -
#pragma mark PLSegmentView delegate

- (void)segmentClickedAtIndex:(int)index onCurrentCell:(BOOL)isCurrent from:(id)sender
{
    NSArray *array = @[_checkPasswordCtl,_checkBarCodeCtl,_checkSearchCtl];
    for (UIViewController *ctl in array) {
        if ([array indexOfObject:ctl] == index) {
                ctl.view.hidden = NO;
        }
        else {
            ctl.view.hidden = YES;
        }
    }
    [_checkPasswordCtl viewResignFirstRespinder];
    [_checkSearchCtl viewResignFirstRespinder];
}


@end
