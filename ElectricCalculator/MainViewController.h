//
//  MainViewController.h
//  ElectricCalculator
//
//  Created by kab on 25.12.12.
//  Copyright (c) 2012 kab. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
