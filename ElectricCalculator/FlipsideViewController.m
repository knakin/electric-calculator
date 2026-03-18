//
//  FlipsideViewController.m
//  ElectricCalculator
//
//  Created by kab on 25.12.12.
//  Copyright (c) 2012 kab. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController
@synthesize butinMetrik;
@synthesize sliderCos;
@synthesize leblKoff;
@synthesize SwitchPreSet380;

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [butinMetrik setOnTintColor:[UIColor colorWithWhite:0.4 alpha:0.8]];
    if(metr==2)[butinMetrik setOn:NO];
    else [butinMetrik setOn:YES];
    [sliderCos setValue:cosff];
    leblKoff.text=[NSString stringWithFormat:@ "%.1F",cosff];
    
    [SwitchPreSet380 setOnTintColor:[UIColor colorWithWhite:0.4 alpha:0.8]];
    if(preset380==true)[SwitchPreSet380 setOn:YES];
    else [SwitchPreSet380 setOn:NO];
   
    [sliderCos setValue:cosff];
   
    UIImage *nullimeg=[UIImage imageNamed:@"null.png"];
    @try{
    [butinMetrik setOnImage:nullimeg];
    [butinMetrik setOffImage:nullimeg];
    }
    @catch (NSException *exception) {
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)ActPreSet380:(id)sender {
    if(SwitchPreSet380.isOn)preset380=true;
    else preset380=false;
    
}

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)swichMetrik:(id)sender {
    if (butinMetrik.isOn)metr=1;
    else metr=2;
}

- (IBAction)movSlidCosF:(id)sender {
    cosff=sliderCos.value;
      leblKoff.text=[NSString stringWithFormat:@ "%.1F",cosff];
}

@end
