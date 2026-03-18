//
//  MainViewController.m
//  ElectricCalculator
//
//  Created by kab on 25.12.12.
//  Copyright (c) 2012 kab. All rights reserved.
//

#import "MainViewController.h"
#define PI 3.14159265358979323846
#pragma mark UIKeyboard handling
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.35;

CGFloat animatedDistance;
CGRect viewFrameKey;
CGFloat heightFraction;
    //функция округления слидера
float setSlider(float sv){
    float  size=0.1;
     if(sv>10)size=1;
    if(sv>100)size=10;
    if(sv>1000)size=100;
    if(sv>10000)size=1000;
    float tt=sv/size;
    int tt0=tt;
    tt=tt-tt0;
    if(tt>=0.5)tt0=tt0+1;
    float r=(float)tt0*size;
    if(r<1)r=1;
    return r;
    
  
}
    //функция расчета мощности
float calWatt(float u,float i,int f, float cosF)
{
    if (f==1){
        return u*i*cosF;
    }
    else {
        return sqrtf(3)*u*i*cosF;
    }
}
    //функция расчета тока
float calAmp(float u,float w,int f, float cosF)
{
    if (f==1){
        return w/(u*cosF);
    }
    else {
        return w/(sqrtf(3)*u*cosF);
    }
}
@interface MainViewController ()

@end


@implementation MainViewController

@synthesize FieldU;
@synthesize FieldUiPad;
@synthesize FieldUPhone;
@synthesize FieldIiPad;
@synthesize FieldIPhone;
@synthesize FieldWiPad;
@synthesize FieldWPhone;
@synthesize SliderU;

@synthesize FieldW;
@synthesize FieldI;
@synthesize SliderI;
@synthesize SliderW;
    //@synthesize SliderFactor;
@synthesize swichFas;
@synthesize swichAl_Cu;
@synthesize imaegCav;

@synthesize butMaxW;
@synthesize butMaxI;
@synthesize butMaxU;
@synthesize labelMinI;
@synthesize labelMinW;
@synthesize labelMinU;
@synthesize lebAriyCave;
@synthesize leblDiamCave;
@synthesize lebRecAriyCave;
    //@synthesize m1;
@synthesize m3;
    //@synthesize mCu;
@synthesize mAl;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
            [self registerForKeyboardNotifications];
        //In ViewDidLoad
    viewFrameKey=self.view.frame;
	// Do any additional setup after loading the view, typically from a nib.
    FieldU.delegate = self;
    FieldI.delegate = self;
    FieldW.delegate = self;
    
    FieldUPhone.font= [UIFont fontWithName:@"DS-Digital-Italic" size:40];
          FieldUPhone.borderStyle =  UITextBorderStyleRoundedRect ;
    FieldUiPad.font= [UIFont fontWithName:@"DS-Digital-Italic" size:70];
          FieldUiPad.borderStyle =  UITextBorderStyleRoundedRect ;
    
    
    FieldI.font= [UIFont fontWithName:@"DS-Digital-Italic" size:40];
           FieldI.borderStyle =  UITextBorderStyleRoundedRect ;
    FieldIiPad.font= [UIFont fontWithName:@"DS-Digital-Italic" size:70];
          FieldIiPad.borderStyle =  UITextBorderStyleRoundedRect ;
    
    FieldW.font= [UIFont fontWithName:@"DS-Digital-Italic" size:40];
           FieldW.borderStyle =  UITextBorderStyleRoundedRect ;
    
    FieldWiPad.font= [UIFont fontWithName:@"DS-Digital-Italic" size:70];
    FieldWiPad.borderStyle=UITextBorderStyleRoundedRect;
     UIImage *dvij0=[UIImage imageNamed:@"dvijok@2x.png"] ;
     UIImage *dvij=[UIImage imageWithCGImage:dvij0.CGImage scale:5 orientation:UIImageOrientationUp];
     UIImage *dvijMin=[UIImage imageNamed:@"null.png"];
    
    [swichFas setOnTintColor:[UIColor colorWithWhite:0.4 alpha:0.8]];
    [swichAl_Cu setOnTintColor:[UIColor colorWithWhite:0.4 alpha:0.8]];

    [SliderU setThumbImage:dvij forState:UIControlStateNormal];
    [SliderU setThumbImage:dvij forState:UIControlStateHighlighted];
    [SliderU setMinimumTrackImage:dvijMin  forState:UIControlStateNormal];
    [SliderU setMaximumTrackImage:dvijMin  forState:UIControlStateNormal];
   
    [SliderW setThumbImage:dvij forState:UIControlStateNormal];
    [SliderW setThumbImage:dvij forState:UIControlStateHighlighted];
    [SliderW setMinimumTrackImage:dvijMin  forState:UIControlStateNormal];
    [SliderW setMaximumTrackImage:dvijMin  forState:UIControlStateNormal];
   
    [SliderI setThumbImage:dvij forState:UIControlStateNormal];
    [SliderI setThumbImage:dvij forState:UIControlStateHighlighted];
    [SliderI setMinimumTrackImage:dvijMin  forState:UIControlStateNormal];
    [SliderI setMaximumTrackImage:dvijMin  forState:UIControlStateNormal];
   
        // UIImage *ph10=[UIImage imageNamed:@"1ph@2x.png"] ;
        //  UIImage *ph30=[UIImage imageNamed:@"3ph@2x.png"] ;
    
        //  UIImage *ph1=[UIImage imageWithCGImage:ph10.CGImage scale:2 orientation:UIImageOrientationUp];
        //UIImage *ph3=[UIImage imageWithCGImage:ph30.CGImage scale:2 orientation:UIImageOrientationUp];
   
     if   (  swichFas.isOn)
        [m3 setText:@"3ph"];
      else [m3 setText:@"1ph"];
     if(swichAl_Cu.isOn)
         [mAl setText:@"Cu"];
      else  [mAl setText:@"Al"];
 
    
     lastchen=1;
     timerI=NO;//иницилизация таймера
     timerU=NO;//иницилизация таймера
     timerW=NO;//иницилизация таймера
     MChenI=NO;//маркер сделаных изменений
     MChenU=NO;//маркер сделаных изменений
     MChenW=NO;//маркер сделаных изменений
    SliderU.value=setSlider(SliderU.value);
    FieldU.text=[NSString stringWithFormat:@ "%.1F",SliderU.value];
               
    SliderI.value=setSlider(SliderI.value);
    FieldI.text=[NSString stringWithFormat:@ "%.1F",SliderI.value];
  
    cosff =[[NSUserDefaults standardUserDefaults]floatForKey: @"cosff" ];
    if(cosff==0)cosff=1;
    metr=[[NSUserDefaults standardUserDefaults]floatForKey: @"metr" ];
    if(metr==0) metr=1;
    preset380=[[NSUserDefaults standardUserDefaults]boolForKey:@"preset380" ];
        //if(preset380==false) preset380=true;
    
     [self calW];
     [self calS];
}


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
          [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillBeHidden:)
//                                                 name:UIKeyboardDidHideNotification object:nil];
}


- (void)deregisterFromKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
              [self.view.window convertRect:textField.bounds fromView:textField];

    heightFraction = textFieldRect.origin.y +  textFieldRect.size.height+20;
  
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self returnSelfView];
}
-(void) returnSelfView{
     [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrameKey];
    [UIView commitAnimations];
   
}
    //---------
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.FieldU resignFirstResponder];
    [self.FieldW resignFirstResponder];
    [self.FieldI resignFirstResponder];
    return NO;
    
}
- (void)keyboardWillShown:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect frame = self.view.frame;
    frame.size.height -= kbSize.height;
   
    CGRect viewFrame = self.view.bounds;
    float hf=heightFraction-(self.view.bounds.size.height- kbSize.height);
    if(hf<0)hf=0;
    viewFrame.origin.y -=hf;
        // NSLog(@"DM=%S, hf=%f", heightFraction);
        // NSLog(@"DM=%S, kbh=%f", kbSize.height);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
         [self returnSelfView];
    
   
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   
//          UITouch *touch  = [touches anyObject];
    UITouch *touch1 = [[event allTouches] anyObject];
    if(([self.FieldU isEditing])&([touch1 view]!=FieldU))[self.FieldU resignFirstResponder];
     if(([self.FieldW isEditing])&([touch1 view]!=FieldW))[self.FieldW resignFirstResponder];
     if(([self.FieldI isEditing])&([touch1 view]!=FieldI))[self.FieldI resignFirstResponder];
}
-(void)seved{
    NSDictionary * appPrerfs = [NSDictionary dictionaryWithObjectsAndKeys:
								[NSNumber numberWithFloat:metr], @"metr",
								[NSNumber numberWithFloat:cosff], @"cosff",
							    [NSNumber numberWithBool:preset380], @"preset380",
								nil];
	
        // Регистрация и сохранить словарь на диск
	[[NSUserDefaults standardUserDefaults] setValuesForKeysWithDictionary: appPrerfs];//
	[[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
        
    }
     [self seved];
      [self calS];
        if( lastchen==2)[self calI];//считаем в зависимости от постледних вычислений
        else [self calW];
    
}
- (void)infoViewControllerDidFinish:(infoViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
   
    } else {
        [self.infoPopoverController dismissPopoverAnimated:YES];
        self.infoPopoverController = nil;
        
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
     self.infoPopoverController = nil;
    [self seved];
    [self calS];
    if( lastchen==2)[self calI];//сцитаем в зависимости от постледних вычислений
    else [self calW];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
    if ([[segue identifier] isEqualToString:@"infoBat"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.infoPopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
    if (self.infoPopoverController) {
        [self.infoPopoverController dismissPopoverAnimated:YES];
        self.infoPopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"infoBat" sender:sender];
    }
}

- (IBAction)Ix10:(id)sender {

    if(SliderI.maximumValue==10){
        SliderI.maximumValue=100;
        [butMaxI setTitle:@"100" forState:UIControlStateNormal];
     
        return;
    }
    if(SliderI.maximumValue==100){
        SliderI.maximumValue=1000;
        [butMaxI setTitle:@"1000" forState:UIControlStateNormal];
        
        return;
    }
    if(SliderI.maximumValue==1000){
        SliderI.maximumValue=10000;
        [butMaxI setTitle:@"10k" forState:UIControlStateNormal];
        
          return;
    }
    if(SliderI.maximumValue>=10000){
        SliderI.maximumValue=10;
        [butMaxI setTitle:@"10" forState:UIControlStateNormal];
          return;
    }

}

- (IBAction)Ux10:(id)sender {
   if(  SliderU.maximumValue==400){
        SliderU.maximumValue=10000;
        [butMaxU setTitle:@"10к" forState:UIControlStateNormal];
    }
    else{
        SliderU.maximumValue=400;
        [butMaxU setTitle:@"400" forState:UIControlStateNormal];
    }
}

- (IBAction)MovU:(id)sender {
    
        //организации функции двойного тыкания в придел увеличивает его
    if(SliderU.value== SliderU.maximumValue)
        {
        if(timerU==NO)
            {
            [NSTimer scheduledTimerWithTimeInterval:2
                         target:self selector:@selector(targetMethodU) userInfo:nil repeats:NO];
            timerU=YES;  MChenU=YES;
            }
        if((timerU==YES)&(MChenU==NO)){
            if(  SliderU.maximumValue==400){
                SliderU.maximumValue=10000;
                SliderU.value=10000;
                [butMaxU setTitle:@ "10к" forState:UIControlStateNormal];
                MChenU=YES;
              }
            }
        }
    if(SliderU.value== SliderU.minimumValue)
            {
            if(timerU==NO)
                {
                [NSTimer scheduledTimerWithTimeInterval:2
                                                 target:self selector:@selector(targetMethodU) userInfo:nil repeats:NO];
                timerU=YES;  MChenU=YES;
                }
            if((timerU==YES)&(MChenU==NO)) {
                if(  SliderU.maximumValue>=10000)
                    {
                    SliderU.maximumValue=400;
                    [butMaxU setTitle:@ "400" forState:UIControlStateNormal];
                      MChenU=YES;
                    }
                }
            }
   
     if((SliderU.value>SliderU.minimumValue)&(SliderU.value<SliderU.maximumValue))
         MChenU=NO;//&(timerU==NO)
                   // SliderU.value=setSlider(SliderU.value);
    FieldU.text=[NSString stringWithFormat:@ "%.1F",setSlider(SliderU.value)];
    if( lastchen==2)[self calI];//сцитаем в зависимости от постледних вычислений
    else [self calW];
}

- (IBAction)MovI:(id)sender {
        //организации функции двойного тыкания в придел увеличивает его
    if(SliderI.value== SliderI.maximumValue)
        {
        if(timerI==NO)
            {
            [NSTimer scheduledTimerWithTimeInterval:2
                                             target:self selector:@selector(targetMethodI) userInfo:nil repeats:NO];
            timerI=YES;  MChenI=YES;
            }
      if((timerI==YES)&(MChenI==NO)) {
            
               if(SliderI.maximumValue==1000){
                    SliderI.maximumValue=10000;
                    [butMaxI setTitle:@"10k" forState:UIControlStateNormal];
                   SliderI.value=10000;
                    MChenI=YES;
                     }
              if(SliderI.maximumValue==100){
                    SliderI.maximumValue=1000;
                    SliderI.value=1000;
                    [butMaxI setTitle:@"1000" forState:UIControlStateNormal];
                         MChenI=YES;
                     }
          if(SliderI.maximumValue==10){
              SliderI.maximumValue=100;
              SliderI.value=100;
              [butMaxI setTitle:@"100" forState:UIControlStateNormal];
              MChenI=YES;
          }
             }
        }
    if(SliderI.value== SliderI.minimumValue)
            {
            if(timerI==NO)
                {
                [NSTimer scheduledTimerWithTimeInterval:2
                                                 target:self selector:@selector(targetMethodI) userInfo:nil repeats:NO];
                timerI=YES;  MChenI=YES;
                }
           if((timerI==YES)&(MChenI==NO)) {
               if(SliderI.maximumValue==100){
                   SliderI.maximumValue=10;
                   [butMaxI setTitle:@"10" forState:UIControlStateNormal];
                   MChenI=YES;
               }
                if(SliderI.maximumValue==1000){
                    SliderI.maximumValue=100;
                    [butMaxI setTitle:@"100" forState:UIControlStateNormal];
                           MChenI=YES;
                    }
                if(SliderI.maximumValue>=10000){
                    SliderI.maximumValue=1000;
                    [butMaxI setTitle:@"1000" forState:UIControlStateNormal];
                           MChenI=YES;
                }
                }
            }
    if((SliderI.value>SliderI.minimumValue)
       &(SliderI.value<SliderI.maximumValue)
   )
        MChenI=NO;//    &(timerI==NO)
                  // SliderI.value=setSlider(SliderI.value);
    FieldI.text=[NSString stringWithFormat:@ "%.1F",setSlider(SliderI.value)];
     lastchen=1;
    [self calW];
    [self calS];
}

- (IBAction)MovW:(id)sender {
    
    if(SliderW.value== SliderW.maximumValue)
        {
        if(timerW==NO)
            {
            [NSTimer scheduledTimerWithTimeInterval:2
                                             target:self selector:@selector(targetMethodW) userInfo:nil repeats:NO];
            timerW=YES; MChenW=YES;
            }
          if((timerW==YES)&(MChenW==NO))  {
              if(SliderW.maximumValue==100000){
                  SliderW.maximumValue=10000000;
                  SliderW.value=10000000;
                  [butMaxW setTitle:@"10M" forState:UIControlStateNormal];
                  MChenW=YES;
              }
             if(SliderW.maximumValue==10000){
                SliderW.maximumValue=100000;
                SliderW.value=100000;
                [butMaxW setTitle:@"100k" forState:UIControlStateNormal];
                 MChenW=YES;
                }
             if( SliderW.maximumValue==1000){
                SliderW.maximumValue=10000;
                SliderW.value=10000;
                [butMaxW setTitle:@"10k" forState:UIControlStateNormal];
                 MChenW=YES;
              }
           
        }
        }
    if(SliderW.value== SliderW.minimumValue)
        {
        if(timerW==NO)
            {
            [NSTimer scheduledTimerWithTimeInterval:2
                                             target:self selector:@selector(targetMethodW) userInfo:nil repeats:NO];
            timerW=YES;MChenW=YES;
            }
      if((timerW==YES)&(MChenW==NO))  {
            
            if(SliderW.maximumValue==10000){
                SliderW.maximumValue=1000;
                [butMaxW setTitle:@ "1000" forState:UIControlStateNormal];
                  MChenW=YES;
            }
            if( SliderW.maximumValue>=100000){
                SliderW.maximumValue=10000;
                [butMaxW setTitle:@ "10k" forState:UIControlStateNormal];
                  MChenW=YES;
            }
           
        }
        }
    if((SliderW.value>SliderW.minimumValue)
       &(SliderW.value<SliderW.maximumValue)
       ) MChenW=NO;// &(timerW==NO)
                   // SliderW.value=setSlider(SliderW.value);
    FieldW.text=[NSString stringWithFormat:@ "%.1F",setSlider(SliderW.value)];
    lastchen=2;
    [self calI];
}
-(IBAction)inputU{
    FieldU.text=[NSString stringWithFormat:@ "%.1F",(CGFloat)[FieldU.text floatValue]];
    if((CGFloat)[FieldU.text floatValue]>10000)FieldU.text=[NSString stringWithFormat:@ "%.1F",(float)10000];
    if((CGFloat)[FieldU.text floatValue]<0.01)FieldU.text=[NSString stringWithFormat:@ "%.1F",(float)0.01];
    
    if( (CGFloat)[FieldU.text floatValue]>400 ){SliderU.maximumValue=10000; [butMaxU setTitle:@ "10к" forState:UIControlStateNormal]; }
    if( (CGFloat)[FieldU.text floatValue]<=400 ){SliderU.maximumValue=400; [butMaxU setTitle:@ "400" forState:UIControlStateNormal];}
    SliderU.value=setSlider((CGFloat)[FieldU.text floatValue]);
    [self calW];
}
-(IBAction)inputW{
    FieldW.text=[NSString stringWithFormat:@ "%.1F",(CGFloat)[FieldW.text floatValue]];
    
    if((CGFloat)[FieldW.text floatValue]>10000000)FieldW.text=[NSString stringWithFormat:@ "%.1F",(float)10000000];
    if((CGFloat)[FieldW.text floatValue]<0.01)FieldW.text=[NSString stringWithFormat:@ "%.1F",0.01];
    [self calI];
}
-(IBAction)inputI{
    FieldI.text=[NSString stringWithFormat:@ "%.1F",(CGFloat)[FieldI.text floatValue]];
    if((CGFloat)[FieldI.text floatValue]>10000)FieldI.text=[NSString stringWithFormat:@ "%.1F",(float)10000];
    if((CGFloat)[FieldI.text floatValue]<0.01)FieldI.text=[NSString stringWithFormat:@ "%.1F",(float)0.01];
    [self calW];
    [self calS];
}
-(void)targetMethodW{
    timerW=NO;
        }
-(void)targetMethodU{
    timerU=NO;
}
-(void)targetMethodI{
    timerI=NO;
}
- (IBAction)Wx10:(id)sender {
    

    if( SliderW.maximumValue==1000){
        SliderW.maximumValue=10000;
        [butMaxW setTitle:@"10k" forState:UIControlStateNormal];
        return;
    }
    if(SliderW.maximumValue==10000){
        SliderW.maximumValue=100000;
        [butMaxW setTitle:@"100k" forState:UIControlStateNormal];
          return;
    }
    if(SliderW.maximumValue==100000){
        SliderW.maximumValue=10000000;
        [butMaxW setTitle:@"10M" forState:UIControlStateNormal];
        return;
    }
    if(SliderW.maximumValue>=1000000){
        SliderW.maximumValue=1000;
        [butMaxW setTitle:@"1000" forState:UIControlStateNormal];
          return;
    }
}

- (IBAction)MovUTUP:(id)sender {
     SliderU.value=setSlider(SliderU.value);
}

- (IBAction)MovITUP:(id)sender {
     SliderI.value=setSlider(SliderI.value);
     [self calS];
}

- (IBAction)MovWUP:(id)sender {
     SliderW.value=setSlider(SliderW.value);
}



- (IBAction)cheng1_3F:(id)sender {
    if   (  swichFas.isOn)
        { [m3 setText:@ "3ph"];
            if(preset380==true){
              FieldU.text=@ "380.0";
              SliderU.maximumValue=400;
              [butMaxU setTitle:@ "400" forState:UIControlStateNormal];
              SliderU.value=setSlider((CGFloat)[FieldU.text floatValue]);
              }
        }
    else [m3 setText:@ "1ph"];
    if( lastchen==2)[self calI];
    else [self calW];
    if(swichFas.isOn)imaegCav.image=[UIImage imageNamed:@"cave3f@x2.png"];
    else imaegCav.image=[UIImage imageNamed:@"cave1f@x2.png"];
}

- (IBAction)changAl_Cu:(id)sender {
  
    if(swichAl_Cu.isOn)
        [mAl setText:@ "Cu"];
    else  [mAl setText:@ "Al"];
    [self calS];
}
-(void)calW{
//    SliderU.value=setSlider(SliderU.value);
//    FieldU.text=[NSString stringWithFormat:@ "%.1F",SliderU.value];
//    (CGFloat)[FieldW.text floatValue];
//    SliderI.value=setSlider(SliderI.value);
//    FieldI.text=[NSString stringWithFormat:@ "%.1F",SliderI.value];
    int f=1;
    if(swichFas.isOn)f=3;
        //  float w=calWatt( setSlider( SliderU.value),  setSlider( SliderI.value), f, cosff);
        //float w=calWatt( setSlider( (CGFloat)[FieldU.text floatValue]),  setSlider( (CGFloat)[FieldI.text floatValue]), f, cosff);
   float w=calWatt(  (CGFloat)[FieldU.text floatValue],(CGFloat)[FieldI.text floatValue], f, cosff);
    SliderW.maximumValue=1000;
    [butMaxW setTitle:@"1000" forState:UIControlStateNormal];
    if(w>1000){
        SliderW.maximumValue=10000;
        [butMaxW setTitle:@"10k" forState:UIControlStateNormal];
    }
    if(w>10000){
        SliderW.maximumValue=100000;
        [butMaxW setTitle:@"100k" forState:UIControlStateNormal];
    }
    if(w>100000){
        SliderW.maximumValue=1000000;
        [butMaxW setTitle:@"1000k" forState:UIControlStateNormal];
    }
    if(w>1000000){
        SliderW.maximumValue=10000000;
        [butMaxW setTitle:@"10м" forState:UIControlStateNormal];
    }
    if(w>10000000){
        SliderW.maximumValue=100000000;
        [butMaxW setTitle:@"100м" forState:UIControlStateNormal];
    }
    if(w>100000000){
        SliderW.maximumValue=1000000000;
        [butMaxW setTitle:@"1g" forState:UIControlStateNormal];
    }
    SliderW.value=setSlider(w);
    FieldW.text=[NSString stringWithFormat:@ "%.1F",w];
}
-(void)calI{
//    SliderU.value=setSlider(SliderU.value);
//    FieldU.text=[NSString stringWithFormat:@ "%.1F",SliderU.value];
//    (CGFloat)[FieldW.text floatValue]
//    SliderW.value=setSlider(SliderW.value);
//    FieldW.text=[NSString stringWithFormat:@ "%.1F",SliderW.value];
    int f=1;
    
    if(swichFas.isOn)f=3;
        //float i=calAmp( setSlider(SliderU.value), setSlider(SliderW.value), f, cosff);
        // float i=calAmp( setSlider((CGFloat)[FieldU.text floatValue]), setSlider((CGFloat)[FieldW.text floatValue]), f, cosff);
    float i=calAmp( (CGFloat)[FieldU.text floatValue], (CGFloat)[FieldW.text floatValue], f, cosff);
    SliderI.maximumValue=10;
  [butMaxI setTitle:@"10" forState:UIControlStateNormal];
    if(i>10){
        SliderI.maximumValue=100;
        [butMaxI setTitle:@"100" forState:UIControlStateNormal];
    }
    if(i>100){
        SliderI.maximumValue=1000;
     [butMaxI setTitle:@"1000" forState:UIControlStateNormal];
    }
    if(i>1000){
        SliderI.maximumValue=10000;
       [butMaxI setTitle:@"10k" forState:UIControlStateNormal];
    }
    if(i>10000){
        SliderI.maximumValue=100000;
        [butMaxI setTitle:@"100k" forState:UIControlStateNormal];
    }
    
    SliderI.value=setSlider(i);
    FieldI.text=[NSString stringWithFormat:@ "%.1F",i];
    [self calS];
    
}
-(void)calS{
       //полщадь сечения провода
       //(CGFloat)[FieldW.text floatValue]
       //float i= setSlider(SliderI.value);
    float i= setSlider((CGFloat)[FieldI.text floatValue]);
    float s;
    float sRek;
    if(swichAl_Cu.isOn){
        s=0.01*powf(i, 1.64);
        }
    else {
        s=0.0165591*powf(i, 1.575);
          }
    if(s<0.5)s=0.5;
    if(metr==1){
    lebAriyCave.text=[NSString stringWithFormat:@ "%.1F mm²",s];
    leblDiamCave.text=[NSString stringWithFormat:@ "%.1F mm",2.0*sqrtf(s/PI)];
    }
    else{
        lebAriyCave.text=[NSString stringWithFormat:@ "%.3F inch²",s*(powf(1.0/25.4, 2))];
        leblDiamCave.text=[NSString stringWithFormat:@ "%.3F inch",2.0*sqrtf(s/PI)*(1.0/25.4)];
    }
        //рекомендуемые значения
    {
    if(swichAl_Cu.isOn){
            //для меди
        if(i<2)sRek=0.5;
        if((i>=2)&(i<3))sRek=0.75;
        if((i>=3)&(i<6))sRek=1;
        if((i>=6)&(i<12))sRek=1.5;
        if((i>=12)&(i<23))sRek=2.5;
        if((i>=23)&(i<30))sRek=4;
        if((i>=30)&(i<40))sRek=6;
        if((i>=40)&(i<60))sRek=10;
        if((i>=60)&(i<90))sRek=16;
        if((i>=90)&(i<110))sRek=25;
        if((i>=110)&(i<140))sRek=35;
        if((i>=140)&(i<180))sRek=50;
        if((i>=180)&(i<200))sRek=70;
        if((i>=200)&(i<260))sRek=95;
        if((i>=260)&(i<300))sRek=120;
        if((i>=300)&(i<350))sRek=150;
        if((i>=350)&(i<390))sRek=185;
        if((i>=390)&(i<470))sRek=240;
        if((i>=470)&(i<530))sRek=300;
        if((i>=530)&(i<640))sRek=400;
        if(i>=640) sRek=0.01*powf((i*1.15), 1.64);
      }
    else {
            //для АЛЮМИН
            //   if(i<2)sRek=0.5;
            //  if((i>=2)&(i<3))sRek=0.75;
            // if((i>=3)&(i<6))sRek=1;
        if(i<14)sRek=2;
        if((i>=14)&(i<16))sRek=2.5;
        if((i>=16)&(i<18))sRek=3;
        if((i>=18)&(i<21))sRek=4;
        if((i>=21)&(i<24))sRek=5;
        if((i>=24)&(i<26))sRek=6;
        if((i>=26)&(i<32))sRek=8;
        if((i>=32)&(i<38))sRek=10;
        if((i>=38)&(i<55))sRek=16;
        if((i>=55)&(i<65))sRek=25;
        if((i>=65)&(i<75))sRek=35;
        if((i>=75)&(i<105))sRek=50;
        if((i>=105)&(i<135))sRek=70;
        if((i>=135)&(i<165))sRek=95;
        if((i>=165)&(i<190))sRek=120;
        if((i>=190)&(i<250))sRek=150;
        if((i>=250)&(i<300))sRek=185;
        if((i>=300)&(i<370))sRek=240;
        if((i>=370)&(i<450))sRek=300;
        if((i>=450)&(i<535))sRek=400;
        if(i>=535) sRek=0.0165591*powf((i*1.25), 1.575);
       }
    
    }
    if(metr==1){
        lebRecAriyCave.text=[NSString stringWithFormat:@ "%.2F mm²",sRek];
       
    }
    else{
        lebRecAriyCave.text=[NSString stringWithFormat:@ "%.3F inch²",sRek*(powf(1.0/25.4, 2))];
        
    }
}


- (void)viewDidUnload {
    
         [self setMAl:nil];
          [self setM3:nil];
          [self setLebRecAriyCave:nil];
        // [self un];
          [super viewDidUnload];
}
@end
