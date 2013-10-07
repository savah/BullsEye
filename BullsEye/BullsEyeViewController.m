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
    int _targetValue;
    int _score;
    int _round; //default 0
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self startNewGame];
    [self updateLabels];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)startNewGame {
    _score = 0;
    _round = 0;
    [self startNewRound];
}

- (void)startNewRound {
    _targetValue = 1 + arc4random_uniform(100);
    _currentValue = 50;
    _round += 1;
    self.slider.value = _currentValue;
}

- (IBAction)startOver {
    [self startNewGame];
    [self updateLabels];
}

- (void)updateLabels {
    self.targetLabel.text = [NSString stringWithFormat:@"%d",_targetValue];
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",_score];
    self.roundLabel.text = [NSString stringWithFormat:@"%d", _round];
}

- (IBAction)showAlert {
    
    int difference = abs(_currentValue - _targetValue);
    
    int points = 100 - difference;
    
    NSString *message = [NSString stringWithFormat:@"You scored %d points", points];
    NSString *title;
    
    if (difference == 0) {
        title = @"Perfect";
        points += 100;
    } else if (difference <5) {
        if (difference == 1) {
            points += 50;
        }
        title = @"You almost had it there!";
    } else if (difference <10) {
        title = @"Pretty good!";
    } else {
        title = @"Not even close...";
    }
    
    _score += points;
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:title
                              message:message
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil
                              ];
    [alertView show];
}

- (IBAction)sliderMoved:(UISlider *)slider {
    _currentValue = lroundf(slider.value);
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self startNewRound];
    [self updateLabels];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
