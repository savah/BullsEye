//
//  AboutViewController.m
//  BullsEye
//
//  Created by Paris Kapsouros on 10/8/13.
//  Copyright (c) 2013 Paris Kapsouros. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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

- (IBAction)close {
    [self.presentingViewController
     dismissViewControllerAnimated:YES
     completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
