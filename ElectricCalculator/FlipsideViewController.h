//
//  FlipsideViewController.h
//  ElectricCalculator
//
//  Created by kab on 25.12.12.
//  Copyright (c) 2012 kab. All rights reserved.
//

#import <UIKit/UIKit.h>
    //#import "MainViewController.h"
@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end
#import "MainViewController.h"
@interface FlipsideViewController : UIViewController{
    
}

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UISwitch *butinMetrik;
@property (weak, nonatomic) IBOutlet UISlider *sliderCos;
@property (weak, nonatomic) IBOutlet UILabel *leblKoff;
@property (weak, nonatomic) IBOutlet UISwitch *SwitchPreSet380;

- (IBAction)ActPreSet380:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)movSlidCosF:(id)sender;

@end
