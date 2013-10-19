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
    
    /*
     This sets four images on the slider: two for the thumb and two for the track.
     The thumb works like a button so it gets an image for the normal, un-pressed state and one for the highlighted state.
     The slider uses different images for the track on the left of the thumb (green) and the track to the right of the thumb (gray).
     */
    
    UIImage *thumbImageNormal = [UIImage imageNamed:@"SliderThumb-Normal"];
    [self.slider setThumbImage:thumbImageNormal forState:UIControlStateNormal];
    
    UIImage *thumbImageHighlighted = [UIImage imageNamed:@"SliderThumb-Highlighted"];
    [self.slider setThumbImage:thumbImageHighlighted forState:UIControlStateHighlighted];
    
    UIImage *trackLeftImage = [[UIImage imageNamed:@"SliderTrackLeft"]
                               resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [self.slider setMinimumTrackImage:trackLeftImage forState:UIControlStateNormal];
    
    UIImage *trackRightImage = [[UIImage imageNamed:@"SliderTrackRight"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 14)];
    [self.slider setMaximumTrackImage:trackRightImage forState:UIControlStateNormal];
    
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
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    [self startNewGame];
    [self updateLabels];
    
    [self.view.layer addAnimation:transition forKey:nil];
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
    
    /*

     ******
     Wait for the aler to dismissed before updating labels and start a new round
     ******
     
     You can ask the alert view to send you a message when it is being closed. In the mean time, you simply do nothing. When the user finally taps the OK button on the alert view, the alert will remove itself from the screen and sends you that message. That’s your cue to take it from there.
     
     This is also known as the listener pattern or observer pattern. You make the Bull’s Eye view controller listen to events coming from the alert view. In proper iOS terminology such listeners are named delegates and that’s the term we’ll be using from now on.
     in the alert view object we say that the delegate is the view controller itself, meaning that it will start listening for alerts that are coming from the alert view.
    
    */
    
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

/*
 This is the delegate method that is called by the alert view when the user closes it. When you get this message it basically says: “Hi, delegate. The alert view so-and- so was dismissed because the user pressed such-and-such button.” Your alert view only has one button but for an alert with multiple buttons you’d look at the buttonIndex parameter to figure out which button was pressed.
 */

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self startNewRound];
    [self updateLabels];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
