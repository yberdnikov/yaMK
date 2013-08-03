//
//  ScanViewController.m
//  iCash
//
//  Created by Vitaly Merenkov on 12.07.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "ScanViewController.h"

@implementation ScanViewController

- (void)scannerDeviceDidBecomeAvailable:(ICScannerDevice*)scanner {
    [scanner requestOpenSession];
}

- (void)deviceBrowser:(ICDeviceBrowser*)browser didAddDevice:(ICDevice*)addedDevice moreComing:(BOOL)moreComing {
    if ( (addedDevice.type & ICDeviceTypeMaskScanner) == ICDeviceTypeScanner ) {
        [_scannerView setScannerDevice:(ICScannerDevice*)addedDevice];
    }
}

- (void)didRemoveDevice:(ICDevice*)removedDevice {
    [removedDevice requestCloseSession];
}

- (void)deviceBrowser:(ICDeviceBrowser *)browser didRemoveDevice:(ICDevice *)device moreGoing:(BOOL)moreGoing {
    
}

- (void) prepareScan {
    [_deviceBrowser setDelegate:self];
    [_deviceBrowser setBrowsedDeviceTypeMask:ICDeviceLocationTypeMaskLocal|ICDeviceLocationTypeMaskRemote|ICDeviceTypeMaskScanner];
    [_deviceBrowser start];
}

@end
