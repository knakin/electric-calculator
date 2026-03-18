//
//  infoViewController.m
//  ElectricCalculator
//
//  Created by kab on 31.12.12.
//  Copyright (c) 2012 kab. All rights reserved.
//

#import "infoViewController.h"

@interface infoViewController ()

@end

@implementation infoViewController

- (void)awakeFromNib
{
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)butDraw:(id)sender {
    NSURL *url=[[NSURL alloc] initWithString:
               @"http://itunes.apple.com/us/app/draw-a-one-touch-hd/id527036970?mt=8"];
    
    [[UIApplication sharedApplication] openURL:url];

}

- (IBAction)butVirLaser:(id)sender {
    NSURL *url=[[NSURL alloc] initWithString:
                @"https://itunes.apple.com/us/app/virlaser-level/id421617837?mt=8"];
    
    [[UIApplication sharedApplication] openURL:url];

}

- (IBAction)done:(id)sender
{
    [self.delegate infoViewControllerDidFinish:self];
}
@end
    //---------
