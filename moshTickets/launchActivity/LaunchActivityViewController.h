//
//  LaunchActivityViewController.h
//  moshTickets
//
//  Created by 魔时网 on 14-3-5.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "BaseViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MoshPickerView.h"

@interface LaunchActivityViewController : BaseViewController<UIScrollViewDelegate,UITextFieldDelegate,UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MoshPickerViewDelegate>
{
    CGRect _rect;
    UIImageView *_converImageView;
}
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) MoshPickerView    *pickerView;

@property (weak, nonatomic) IBOutlet UIScrollView *baseScrollView;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *addressText;
@property (weak, nonatomic) IBOutlet UITextField *dateText;
@property (weak, nonatomic) IBOutlet UITextField *sponsor;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIImageView *activityImage;
@property (weak, nonatomic) IBOutlet UIButton *selectTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *addActImageButton;

- (IBAction)addTicketType:(id)sender;
- (IBAction)confirm:(id)sender;
- (IBAction)selectActType:(id)sender;
- (IBAction)addActivityImage:(id)sender;


@end
