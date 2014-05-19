//
//  PLSegmentCell.m
//  Copyright (c) 2012年 bbdtek. All rights reserved.
//

#import "PLSegmentCell.h"



@implementation PLSegmentCell
@synthesize cellType;

-(id)initWithNormalImage:(UIImage*)anormal selectedImage:(UIImage*)ahover textShow:(NSString*)str frame:(CGRect)aframe totCount:(int)total
{
	self =  [super initWithFrame:aframe];
	imageNormal = [[UIImageView alloc] initWithImage:anormal];
	imageHover = [[UIImageView alloc] initWithImage:ahover];	 
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.0f, anormal.size.width, (anormal.size.height - 0.0f))];
    
    switch (total)
    {
        case 2:
        {
            if (imageNormal.frame.size.height > 30)
                label.font = [UIFont boldSystemFontOfSize:16.0f];
            else 
                label.font = [UIFont boldSystemFontOfSize:12.0f];
        }
            break;
        case 3:
        {
            if (imageNormal.frame.size.height > 30)
                label.font = [UIFont boldSystemFontOfSize:15.0f];
            else 
                label.font = [UIFont boldSystemFontOfSize:13.0f];
        }
            break;
        case 4:
        {
            if (imageNormal.frame.size.height > 30)
                label.font = [UIFont boldSystemFontOfSize:14.0f];
            else 
                label.font = [UIFont boldSystemFontOfSize:13.0f];
        }
            break;
        default:
            label.font = [UIFont boldSystemFontOfSize:11.0f];
            break;
    }
    
    //label.numberOfLines = 2;
    label.text = str;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumFontSize = 10.0f;
    
	[self addSubview:imageNormal];
	[self addSubview:imageHover];
    [self addSubview:label];
	self.selected = NO;
	return self;	
}


-(id)initWithNormalImage:(UIImage *)anormal selectedImage:(UIImage *)ahover textShow:(NSString*)str startPoint:(CGPoint)apoint totCount:(int)total
{
	CGRect rect = CGRectMake(apoint.x, apoint.y, anormal.size.width, anormal.size.height);
	return [self initWithNormalImage:anormal selectedImage:ahover textShow:str frame:rect totCount:total];
}

//设置cell新显示
- (void)resetLabelText:(NSString *)theText {
    label.text = theText;
}

#pragma mark -
#pragma mark OverWrite for default select action and state property

- (void)setSelected:(BOOL)value
{
	[super setSelected:value];
	imageNormal.hidden = value;
	imageHover.hidden = !value;
    if (value)
    {
        label.textColor = self.cellType == cellTypeDefault ? [UIColor whiteColor]:[UIColor grayColor];
        //label.shadowColor = [UIColor blackColor];
    }
    else 
    {
        label.textColor = [UIColor whiteColor];
        //label.shadowColor = [UIColor whiteColor];
    }
}

@end
