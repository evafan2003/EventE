//
//  PLSegmentCell.h
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//


#import <UIKit/UIKit.h>
typedef enum {
    
    cellTypeDefault,
    cellTypeCheckBox
    
} CellType;

@interface PLSegmentCell : UIControl {
	UIImageView *imageNormal;
	UIImageView *imageHover;
    UILabel *label;
}

@property (nonatomic, assign) CellType cellType;
-(id)initWithNormalImage:(UIImage*)anormal selectedImage:(UIImage*)ahover textShow:(NSString*)str frame:(CGRect)aframe totCount:(int)total;

-(id)initWithNormalImage:(UIImage*)anormal selectedImage:(UIImage*)ahover textShow:(NSString*)str startPoint:(CGPoint)apoint totCount:(int)total;

//设置cell新显示
- (void)resetLabelText:(NSString *)theText;

@end
