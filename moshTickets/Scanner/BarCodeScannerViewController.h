//
//  BarCodeScannerViewController.h
//  Scanner
//
//  Created by bbdtek on 11-10-24.
//  Copyright 2011 bbdtek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZBarSDK.h"
#import <AVFoundation/AVAudioPlayer.h>
#import <AVFoundation/AVFoundation.h>

@protocol BarCodeScannerDelegate;
@interface BarCodeScannerViewController : UIViewController<ZBarReaderDelegate> {
    
	ZBarReaderViewController *barReaderViewController;
	AVAudioPlayer *beep;
	BOOL isScannerAvailable;
	BOOL flashlightOn;
}

@property (nonatomic, assign) id <BarCodeScannerDelegate> barCodeScannerDelegate;
- (void)initBarReaderViewController;
- (void)initAudio;
- (void)playBeep;
- (void) offBeep;
- (void) prepareToPlay;
@end

@protocol BarCodeScannerDelegate <NSObject>

- (void)ProcessBarCodeScannerResult:(BarCodeScannerViewController*)sender withInfo:(NSDictionary*)info;

- (void) barCodeScannerViewControllerDismissModelViewController;
@end