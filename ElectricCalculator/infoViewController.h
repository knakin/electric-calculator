//
//  infoViewController.h
//  ElectricCalculator
//
//  Created by kab on 31.12.12.
//  Copyright (c) 2012 kab. All rights reserved.
//

#import <UIKit/UIKit.h>
    //---
    //@interface infoViewController : UIViewController

    //@end
    //--
@class infoViewController;

@protocol infoViewControllerDelegate
- (void)infoViewControllerDidFinish:(infoViewController *)controller;
@end

@interface infoViewController : UIViewController{
    
}

@property (weak, nonatomic) id <infoViewControllerDelegate> delegate;
- (IBAction)butDraw:(id)sender;
- (IBAction)butVirLaser:(id)sender;

- (IBAction)done:(id)sender;

@end