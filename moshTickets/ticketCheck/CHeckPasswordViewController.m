//
//  CHeckPasswordViewController.m
//  moshTickets
//
//  Created by 魔时网 on 14-3-10.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "CHeckPasswordViewController.h"
#import "MoshTicketDatabase.h"  
#import "CheckTickets.h"

#define MID_TAG 21
#define DETAIL_TAG 22

@interface CHeckPasswordViewController ()

@end

@implementation CHeckPasswordViewController

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
    self.view.backgroundColor = CLEARCOLOR;
    self.manualTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 10)];
    self.manualTextField.leftViewMode = UITextFieldViewModeAlways;

    self.baseTableView.tableHeaderView = self.ManualCheck;
    self.baseTableView.backgroundColor = CLEARCOLOR;
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    self.manualTextField.text = self.eid;
    self.ticket = nil;
    [self.baseTableView reloadData];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.manualTextField resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

- (void) viewResignFirstRespinder
{
    [self.manualTextField resignFirstResponder];
}

//手动验票
- (IBAction)manualCodeCheck:(id)sender {
    
    if (self.manualTextField.text.length == 11 || self.manualTextField.text.length == 13) {
        
        [self.manualTextField resignFirstResponder];
        
        [self checkTicketWithPassword:self.manualTextField.text];
    } else {
        
        [GlobalConfig alert:@"请输入长度为11或者13位的整数"];
        
    }
    
}

- (void) checkTicketWithPassword:(NSString *)password
{
    NSString *ticketID = [self getDatabaseTicketID:self.selectList];
    self.ticket = [[MoshTicketDatabase sharedInstance] getOneTicket:password eid:self.eid ticketID:ticketID];
    
    if (!self.ticket) {
        self.ticket = [[Ticket alloc] init];
        self.ticket.t_state = ticketState_unExist;
    }
    else if ([self.ticket.t_state isEqualToString:ticketState_unUse] || [self.ticket.t_state isEqualToString:ticketState_isUsed]) {
        
        [CheckTickets checkTicket:self.ticket];
    }
    else {

        self.ticket = [[Ticket alloc] init];
        self.ticket.t_state = ticketState_unExist;
    }
    
    [self.baseTableView reloadData];
}

#pragma -mark
#pragma TableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
           //正常验票
    if (indexPath.section == 0) {
        
        static NSString *CellIdentifier = @"cell1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.textLabel.font = [UIFont systemFontOfSize:22];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = CLEARCOLOR;
            cell.backgroundColor = CLEARCOLOR;
            
        }
        
        if (indexPath.row == 0) {
            
            if ([self.ticket.t_state isEqualToString:ticketState_unExist]) {
                
                //无效
                cell.textLabel.text = @"该票不存在 ×";
                cell.textLabel.textColor = [UIColor redColor];
                
            }else if ([self.ticket.t_state isEqualToString:ticketState_unUse]) {
                //正确
                cell.textLabel.text = @"￼验票通过 √";
                cell.textLabel.textColor = [UIColor greenColor];
                
            } else {
                //过期
                cell.textLabel.textColor = [UIColor orangeColor];
                cell.textLabel.text = @"该票已使用";
            }
            
        }
        return cell;
        
    } else {
        
        static NSString *CellIdentifier = @"cell2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor grayColor];
            
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor = [UIColor grayColor];

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.contentView.backgroundColor = CLEARCOLOR;
            cell.backgroundColor = CLEARCOLOR;
        }
        
        if ([self.ticket.t_state isEqualToString:ticketState_unExist]) {
            
            //无效
            cell.textLabel.text = @"      ";
            cell.detailTextLabel.text = @"该验票码错误";
            
        }
        else  {
            //有效
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"票种：";
                    cell.detailTextLabel.text = ([self.ticket.ticket_name isEqualToString:@""]) ? @"暂无" : self.ticket.ticket_name;
                    break;
                case 1:
                    cell.textLabel.text = @"密码：";
                    cell.detailTextLabel.text = ([self.ticket.t_password isEqualToString:@""]) ? @"暂无" : self.ticket.t_password;
                    break;
                case 2:
                    cell.textLabel.text = @"价格：";
                    cell.detailTextLabel.text = ([self.ticket.t_price isEqualToString:@""]) ? @"暂无" : self.ticket.t_price;
                    break;
                case 3:
                    cell.textLabel.text = @"手机：";
                    cell.detailTextLabel.text = ([self.ticket.tel isEqualToString:@""]) ? @"暂无" : self.ticket.tel;
                    break;
                case 4:
                    cell.textLabel.text = @"邮箱：";
                    cell.detailTextLabel.text = ([self.ticket.email isEqualToString:@""]) ? @"暂无" : self.ticket.email;
                    
                    break;
                case 5:
                    cell.textLabel.text = @"姓名：";
                    cell.detailTextLabel.text = ([self.ticket.name isEqualToString:@""]) ? @"暂无" : self.ticket.name;
                    break;
                case 6:
                    cell.textLabel.text = @"身份证号：";
                    cell.detailTextLabel.text = ([self.ticket.idCard isEqualToString:@""]) ? @"暂无" : self.ticket.idCard;
                    break;
                case 7:
                    cell.textLabel.text = @"使用时间：";
                    cell.detailTextLabel.text =[GlobalConfig dateFormater:self.ticket.use_date format:DATEFORMAT_05];
                    break;
                default:
                    break;
            }
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return  (indexPath.section == 0)?34:30;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.ticket == nil) {
        return 0;
        
    } else {
        
        if (section == 0) {
                return 1;
            
        } else {
            
            if ([self.ticket.t_state isEqualToString:ticketState_unExist]) {
                return 1;
            }
            else if ([self.ticket.t_state isEqualToString:ticketState_isUsed]){
                return 8;
            }
            else
                return 7;
            }
        }
}

#pragma mark 键盘
- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (doneInKeyboardButton.superview)
    {
        [doneInKeyboardButton removeFromSuperview];
    }
}

- (void)handleKeyboardDidShow:(NSNotification *)notification
{
    
    if ([self.manualTextField isFirstResponder]) {
        if (doneInKeyboardButton == nil)
        {
            doneInKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            doneInKeyboardButton.frame = CGRectMake(0, SCREENHEIGHT - 53, 106, 53);
            
            doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
            //图片直接抠腾讯财付通里面的= =!
    //        [doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_up@2x.png"] forState:UIControlStateNormal];
    //        [doneInKeyboardButton setImage:[UIImage imageNamed:@"btn_done_down@2x.png"] forState:UIControlStateHighlighted];
            [doneInKeyboardButton setTitle:@"完成" forState:UIControlStateNormal];
            [doneInKeyboardButton setTitle:@"完成" forState:UIControlStateHighlighted];
            [doneInKeyboardButton addTarget:self action:@selector(doneButton) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
        
        if (doneInKeyboardButton.superview == nil)
        {
            [tempWindow addSubview:doneInKeyboardButton];    // 注意这里直接加到window上
        }
    }
    
}

-(void) doneButton {
    
    [self.manualTextField resignFirstResponder];
}


@end
