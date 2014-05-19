//
//  BarCodeScannerViewController.m
//  Scanner
//
//  Created by bbdtek on 11-10-24.
//  Copyright 2011 bbdtek. All rights reserved.
//

#import "BarCodeScannerViewController.h"
#import "ScannerOverlayView.h"
#import "MoshDefine.h"

NSString *sContent;

@implementation BarCodeScannerViewController
@synthesize barCodeScannerDelegate;

- (void)toggleFlashlight
{
	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	
	if (device.torchMode == AVCaptureTorchModeOff) {
		
		[device lockForConfiguration:nil];
		
		// Set torch to on
		[device setTorchMode:AVCaptureTorchModeOn];
		
		[device unlockForConfiguration];
	}else {
		[device lockForConfiguration:nil];
		
		// Set torch to on
		[device setTorchMode:AVCaptureTorchModeOff];
		
		[device unlockForConfiguration];
	}
}

#pragma mark -
#pragma mark Button Options

- (void)cancelButtonPressed {
	[self.parentViewController dismissModalViewControllerAnimated:YES];
    if ([self.barCodeScannerDelegate respondsToSelector:@selector(barCodeScannerViewControllerDismissModelViewController)]) {
        [self.barCodeScannerDelegate barCodeScannerViewControllerDismissModelViewController];
    }
}

- (void)lightButtonPressed {
	if (flashlightOn == NO) {
		flashlightOn = YES;
		self.navigationItem.rightBarButtonItem.title = @"关灯";
    }else {
		flashlightOn = NO;
		self.navigationItem.rightBarButtonItem.title = @"开灯";
    }
	
    [self toggleFlashlight];
}


- (void)viewDidLoad {
	
	self.title = @"";
	
	sContent = nil;
	
	flashlightOn = NO;
    
	[super viewDidLoad];
    self.navigationController.navigationBar.tintColor = NORMAL_COLOR;
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
									 initWithTitle:@"返回"
									 style:UIBarButtonItemStyleBordered
									 target:self
									 action:@selector(cancelButtonPressed)];
	self.navigationItem.leftBarButtonItem = cancelButton;
    
	if ([ZBarReaderViewController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear]) {
		UIBarButtonItem *lightButton = [[UIBarButtonItem alloc]
										initWithTitle:@"开灯"
										style:UIBarButtonItemStyleBordered
										target:self
										action:@selector(lightButtonPressed)];
		self.navigationItem.rightBarButtonItem = lightButton;
	}
	
	[self initBarReaderViewController];
	[self initAudio];
	
	//set frame
	UIView *barReaderView = [barReaderViewController view];
	barReaderView.frame = CGRectMake(0.0, 0.0, 320.0, 416.0);
	
	//add overlay for barReaderView
    ScannerOverlayView *overlay = [[ScannerOverlayView alloc] initWithFrame:barReaderView.bounds];
	[barReaderViewController setCameraOverlayView:overlay];
	
	[[self view] addSubview:barReaderView];
	[barReaderViewController.readerView start];//start scanning
}

- (void)viewDidUnload{
	[super viewDidUnload];
	if (barReaderViewController) {
		//BH_RELEASE(barReaderViewController);
	}
	if (beep) {
		//BH_RELEASE(beep);
	}
}

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	isScannerAvailable = YES;
}


- (void)initBarReaderViewController{
	barReaderViewController = [ZBarReaderViewController new];
	[barReaderViewController setShowsZBarControls:NO];
	barReaderViewController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
	barReaderViewController.sourceType = UIImagePickerControllerSourceTypeCamera;
	barReaderViewController.showsCameraControls = NO;
	barReaderViewController.readerDelegate = self;
	barReaderViewController.readerView.torchMode = 0;
	ZBarImageScanner *scanner = barReaderViewController.scanner;
	
	
	[scanner setSymbology: ZBAR_ISBN10
				   config: ZBAR_CFG_ENABLE
					   to: 1];
	[scanner setSymbology: ZBAR_ISBN13
				   config: ZBAR_CFG_ENABLE
					   to: 1];
	
	// disable rarely used i2/5 to improve performance
	[scanner setSymbology: ZBAR_I25
				   config: ZBAR_CFG_ENABLE
					   to: 0];
}

- (void)initAudio
{
    if(beep)
        return;
    NSError *error = nil;
    beep = [[AVAudioPlayer alloc]
			initWithContentsOfURL:
			[[NSBundle mainBundle]
			 URLForResource: @"scan"
			 withExtension: @"wav"]
			error: &error];
    if(!beep)
        NSLog(@"ERROR loading sound: %@: %@", [error localizedDescription], [error localizedFailureReason]);
    else {
        beep.volume = .5f;
        [beep prepareToPlay];
    }
}

//扫描成功后播放声音
- (void) playBeep
{
    if(!beep)
        [self initAudio];
    [beep play];
}

- (void) prepareToPlay
{
    [beep prepareToPlay];
}

- (void) offBeep
{
    [beep stop];
}


- (void)imagePickerController: (UIImagePickerController*) picker didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    [self.barCodeScannerDelegate ProcessBarCodeScannerResult:self withInfo:info];
    
}

//失败后执行的方法
- (void) readerControllerDidFailToRead: (ZBarReaderController*) reader
                             withRetry: (BOOL) retry{
	//失败后啥也不干
}

@end
