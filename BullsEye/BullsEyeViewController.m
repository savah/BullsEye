//
//  BullsEyeViewController.m
//  BullsEye
//
//  Created by Paris Kapsouros on 9/29/13.
//  Copyright (c) 2013 Paris Kapsouros. All rights reserved.
//

#import "BullsEyeViewController.h"

@interface BullsEyeViewController ()

@end

@implementation BullsEyeViewController {
    int _currentValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _currentValue = 50;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert {

    NSString *message = [ NSString stringWithFormat:@"The current value of the slider is %d", _currentValue];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Hello world"
                              message:message
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil
                            ];
    
    [alertView show];
}

- (IBAction)sliderMoved:(UISlider *)slider {
    _currentValue = lroundf(slider.value);
}


@end
