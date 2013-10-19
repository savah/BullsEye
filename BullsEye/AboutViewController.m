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
    
    /*
     This piece of code loads a html file in a webview. Dont forget to connect the Outlet from the viewcontroller to the webview.
     1) First it finds the BullsEye.html file in the application bundle,
     2) then loads it into an NSData object,
     3) and finally asks the web view to show the contents of this data object.
    */
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"BullsEye" ofType:@"html"];
    
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
    
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    
    [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
    
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
