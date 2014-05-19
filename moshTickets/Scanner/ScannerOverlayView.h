//
//  ScannerOverlayView.h
//  Scanner
//
//  Created by bbdtek on 11-10-24.
//  Copyright 2011 bbdtek. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
	VERTICAL = 0,
	HORIZONTAL
} OverlayOrientation;

@interface ScannerOverlayView : UIView {
	UIView *infoView;
	OverlayOrientation overlayOrientation;
}
- (void)configOverlayOrientation;
- (void)cameraRotate:(NSNotification *)notification ;
- (void)drawSquareIndicatorWithContext:(CGContextRef)context;

@end
