//
//  PasswordViewController.h
//  moshTickets
//
//  Created by 魔时网 on 14-2-17.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef enum {
    PasswordView_usernameView,
    PasswordView_emailAlertView,
    PasswordView_passwordView,
    PasswordView_checkNumberView,
} PasswordView;

@interface PasswordViewController : BaseViewController
@property (assign, nonatomic) PasswordView currentView;
@property (strong, nonatomic) NSString  *checkNumber;
@property (strong, nonatomic) NSString *userType;

@property (strong, nonatomic) IBOutlet UIView *usernameView;
@property (strong, nonatomic) IBOutlet UIView *checkNumberView;
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UIView *emailAlertView;


@property (weak, nonatomic) IBOutlet UITextField *usernameView_username;
@property (weak, nonatomic) IBOutlet UITextField *userNameView_checkNumber;
@property (weak, nonatomic) IBOutlet UILabel *userNameView_checkLabel;
- (IBAction)usernameViewButtonPress:(id)sender;
- (IBAction)userNameViewCheckButtonPress:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *userNameView_checkButton;


@property (weak, nonatomic) IBOutlet UILabel *checkNumberView_SecondLabel;
@property (weak, nonatomic) IBOutlet UITextField *checkNumberView_ckeckNumber;
@property (weak, nonatomic) IBOutlet UIButton *checkNumberView_getNumberButton;
- (IBAction)checkNumberViewButtonPress:(id)sender;
- (IBAction)checkNumberViewGetNumberPress:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *passwordView_password;
@property (weak, nonatomic) IBOutlet UITextField *passwordView_confirmPassword;
- (IBAction)passwordViewButtonPress:(id)sender;


- (IBAction)emailAlertViewButtonPress:(id)sender;




@end
