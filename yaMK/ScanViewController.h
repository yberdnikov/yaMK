//
//  ScanViewController.h
//  iCash
//
//  Created by Vitaly Merenkov on 12.07.13.

//

#import <Foundation/Foundation.h>
#import <ImageCaptureCore/ImageCaptureCore.h>
#import <Quartz/Quartz.h>

@interface ScanViewController : NSObject<IKScannerDeviceViewDelegate, ICScannerDeviceDelegate, ICDeviceBrowserDelegate>

@property (weak) IBOutlet IKScannerDeviceView *scannerView;
@property ICDeviceBrowser *deviceBrowser;

-(void) prepareScan;

@end
