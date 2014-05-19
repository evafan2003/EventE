//
//  CHeckPasswordViewController.h
//  moshTickets
//
//  Created by 魔时网 on 14-3-10.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CHeckPasswordViewController : BaseTableViewController<UITextFieldDelegate>
{
    UIButton *doneInKeyboardButton;
}


@property (strong, nonatomic) NSString *eid;
@property (strong, nonatomic) Ticket *ticket;
@property (strong, nonatomic) IBOutlet UIView *ManualCheck;
@property (strong, nonatomic) IBOutlet UITextField *manualTextField;
@property (strong, nonatomic) NSMutableArray *selectList;//选择的票种

- (IBAction)manualCodeCheck:(id)sender;
- (void) viewResignFirstRespinder;
@end
