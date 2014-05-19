//
//  InfoViewController.h
//  MoshTicket
//
//  Created by evafan2003 on 12-5-13.
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    InfoTypeHowToGetAccount,
    InfoTypeLoginFail,
    InfoTypeTransFromFail,

} InfoType ;

@interface InfoViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIView *howToGetAccount;
@property (retain, nonatomic) IBOutlet UIView *loginFail;
@property (retain, nonatomic) IBOutlet UIView *transFromFail;
@property InfoType infoType;
@end
