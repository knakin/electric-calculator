//
//  MainViewController.h
//  ElectricCalculator
//
//  Created by kab on 25.12.12.
//  Copyright (c) 2012 kab. All rights reserved.
//

#import "FlipsideViewController.h"
#import "infoViewController.h"
    //@class FlipsideViewController;
    int metr;
    float cosff;
BOOL  preset380;


@interface MainViewController : UIViewController <UIPopoverControllerDelegate,UITextFieldDelegate,infoViewControllerDelegate,FlipsideViewControllerDelegate>
{
    
    
    int  lastchen;//маркер последнего изменения 1-ток 2-мощность
    BOOL timerI;//маркер работы таймера
    BOOL timerU;//маркер работы таймера
    BOOL timerW;//маркер работы таймера
    BOOL MChenI;//маркер сделаных изменений
    BOOL MChenU;//маркер сделаных изменений
    BOOL MChenW;//маркер сделаных изменений
}

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (strong, nonatomic) UIPopoverController *infoPopoverController;
@property (weak, nonatomic) IBOutlet UITextField *FieldU;
@property (weak, nonatomic) IBOutlet UITextField *FieldW;
@property (weak, nonatomic) IBOutlet UITextField *FieldI;
@property (weak, nonatomic) IBOutlet UITextField *FieldUiPad;
@property (weak, nonatomic) IBOutlet UITextField *FieldUPhone;
@property (weak, nonatomic) IBOutlet UITextField *FieldIiPad;
@property (weak, nonatomic) IBOutlet UITextField *FieldIPhone;
@property (weak, nonatomic) IBOutlet UITextField *FieldWiPad;
@property (weak, nonatomic) IBOutlet UITextField *FieldWPhone;
@property (weak, nonatomic) IBOutlet UISlider *SliderU;

@property (weak, nonatomic) IBOutlet UISlider *SliderI;
@property (weak, nonatomic) IBOutlet UISlider *SliderW;
@property (weak, nonatomic) IBOutlet UISwitch *swichFas;
@property (weak, nonatomic) IBOutlet UISwitch *swichAl_Cu;
@property (weak, nonatomic) IBOutlet UIImageView *imaegCav;
    //@property (weak, nonatomic) IBOutlet UILabel *labelMaxW;
@property (weak, nonatomic) IBOutlet UIButton *butMaxW;
@property (weak, nonatomic) IBOutlet UIButton *butMaxI;
@property (weak, nonatomic) IBOutlet UIButton *butMaxU;
    //@property (weak, nonatomic) IBOutlet UILabel *labelMaxI;
    //@property (weak, nonatomic) IBOutlet UILabel *labelMaxU;
@property (weak, nonatomic) IBOutlet UILabel *labelMinI;
@property (weak, nonatomic) IBOutlet UILabel *labelMinW;
@property (weak, nonatomic) IBOutlet UILabel *labelMinU;
@property (weak, nonatomic) IBOutlet UILabel *lebAriyCave;
@property (weak, nonatomic) IBOutlet UILabel *leblDiamCave;


@property (weak, nonatomic) IBOutlet UILabel *mAl;
@property (weak, nonatomic) IBOutlet UILabel *m3;
@property (weak, nonatomic) IBOutlet UILabel *lebRecAriyCave;


- (IBAction)Ix10:(id)sender;
- (IBAction)Ux10:(id)sender;
- (IBAction)Wx10:(id)sender;
- (IBAction)MovU:(id)sender;
- (IBAction)MovI:(id)sender;
- (IBAction)MovW:(id)sender;

- (IBAction)MovUTUP:(id)sender;
- (IBAction)MovITUP:(id)sender;
- (IBAction)MovWUP:(id)sender;

- (IBAction)cheng1_3F:(id)sender;
- (IBAction)changAl_Cu:(id)sender;
-(IBAction)inputI;
-(IBAction)inputW;
-(IBAction)inputU;
-(void)calW;
-(void)calI;
-(void)calS;
-(void)returnSelfView;
@end
