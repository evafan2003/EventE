//
//  LaunchActivityViewController.m
//  moshTickets
//
//  Created by 魔时网 on 14-3-5.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "LaunchActivityViewController.h"
#import "ControllerFactory.h"

static NSString *detail = @"活动详情，请尽量生动、具体";
static CGFloat  scrollViewHeight = 734.0f;

@interface LaunchActivityViewController ()

@end

@implementation LaunchActivityViewController

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
    // Do any additional setup after loading the view from its nib.
    
    [self createBarWithLeftBarItem:MoshNavigationBarItemBack rightBarItem:MoshNavigationBarItemNone title:NAVTITLE_ADDEVENT];
    self.baseScrollView.contentSize = CGSizeMake(SCREENWIDTH, scrollViewHeight);
    self.dateText.placeholder = [GlobalConfig date:[NSDate date] format:DATEFORMAT_06];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
    [self.activityImage addGestureRecognizer:tap];
    
    [self initPickerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - private action -

- (void) initPickerView
{
    self.typeArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    self.pickerView = [[MoshPickerView alloc] initWithArray:self.typeArray];
    self.pickerView.delegate = self;
    [self.view addSubview:_pickerView];

}

- (void) imageTap:(UITapGestureRecognizer *)ges
{
    _rect = [self.activityImage convertRect:self.activityImage.bounds toView:self.view.window];
    _converImageView = [[UIImageView alloc] initWithImage:self.activityImage.image];
    _converImageView.contentMode = UIViewContentModeScaleAspectFit;
    _converImageView.userInteractionEnabled = YES;
    _converImageView.frame = _rect;
    [self.view.window addSubview:_converImageView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _converImageView.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2);
    } completion:^(BOOL finish) {
        [UIView animateWithDuration:0.5 animations:^{
                _converImageView.bounds = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        }];
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigImageTap:)];
    [_converImageView addGestureRecognizer:tap];

}

- (void) bigImageTap:(UITapGestureRecognizer *)ges
{
    [UIView animateWithDuration:0.5 animations:^{
        _converImageView.frame = CGRectMake(SCREENWIDTH/2, SCREENHEIGHT/2, _rect.size.width, _rect.size.height);
    } completion:^(BOOL finish) {
        
        [UIView animateWithDuration:0.5 animations:^{
            _converImageView.frame = _rect;
        } completion:^(BOOL finish) {
            [_converImageView removeFromSuperview];
        }];
    }];
}

- (void) textResignFirstResponder
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        NSArray *textArray = @[_titleText,_addressText,_dateText,_detailTextView,_sponsor,_phoneNumber];
        for (UIView *view in textArray) {
            if ([view isFirstResponder]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [view resignFirstResponder];
                });
            }
        }
    });
}

#pragma mark -buttonAction -

- (IBAction)addActivityImage:(id)sender {
    [self textResignFirstResponder];
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍摄照片" otherButtonTitles:@"从照片库选取", nil];
    [sheet showInView:self.view];
}
- (IBAction)addTicketType:(id)sender {
    [self textResignFirstResponder];
    [self.navigationController pushViewController:[ControllerFactory addTicketTypeViewController] animated:YES];

}

- (IBAction)confirm:(id)sender {
    [self textResignFirstResponder];
}

- (IBAction)selectActType:(id)sender {
    [self textResignFirstResponder];
    [self.pickerView showPickerView];
}

#pragma mark -scrollViewDelegate -

- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self textResignFirstResponder];
}

#pragma  mark actionSheetDelegate -
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    //    创建图片选取器
    UIImagePickerController *pickerCtl = [[UIImagePickerController alloc] init];
    pickerCtl.delegate = self;
    
    switch (buttonIndex) {
        case 0:
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [GlobalConfig alert:@"没有检查到摄像设备"];
                return;
            
            }
            else {
            
                pickerCtl.sourceType = UIImagePickerControllerSourceTypeCamera;
                 [self presentViewController:pickerCtl animated:YES completion:^{}];
            }
            break;
        case 1:
            
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [GlobalConfig alert:@"没有检查到照片库"];
                return;
                
            }
            else {
            //    检查照片库是否可用
                if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied) {
                    [GlobalConfig alert:ALERT_IMAGEPICKER];
                }
                else {
                     pickerCtl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    [self presentViewController:pickerCtl animated:YES completion:^{}];
                }
            }
            break;
        default:
            break;
    }
}

#pragma mark ImagePickerDelegate -
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    self.activityImage.image = image;
    [self.addActImageButton setTitle:@"更改活动易海报" forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

#pragma  mark - moshPickerViewDelegate -
- (void) selectArray:(NSArray *)array startArray:(NSArray *)startArray
{
    NSNumber *number= [GlobalConfig convertToNumber:array[0]];
    NSString *str = self.typeArray[[number integerValue]];
    [self.selectTypeButton setTitle:str forState:UIControlStateNormal];
}

#pragma mark - textDelegate -

//- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}

- (void) textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:detail])
    {
        textView.text = nil;
    }
     [self.baseScrollView setContentOffset: CGPointMake(0,textView.frame.origin.y - 20) animated:YES];
}

- (void) textFieldDidBeginEditing:(UITextField *)textField
{
    [self.baseScrollView setContentOffset: CGPointMake(0,textField.frame.origin.y - 20) animated:YES];
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _phoneNumber) {
        [self.baseScrollView setContentOffset:CGPointMake(0, scrollViewHeight - (SCREENHEIGHT - NAVHEIGHT)) animated:YES];
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    NSArray *textArray = @[_titleText,_dateText,_addressText,_detailTextView,_sponsor,_phoneNumber];
        [GlobalConfig textFieldReturnKeyWithArray:textArray fistResponder:textField andAnimationBlock:^{
            self.baseScrollView.contentOffset = CGPointMake(0,textField.frame.origin.y - 20);
        }];
    return YES;
}
@end
