//
//  BitThisViewController.m
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#import "BitThisViewController.h"
#import "PixelController.h"
#import "Constants.h"

@interface BitThisViewController ()

@end

@implementation BitThisViewController

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
    // Do any additional setup after loading the view from its nib.
    
    imageView.image = [UIImage imageNamed:@"test_16x16.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button Actions
- (IBAction)convertButtonAction:(id)sender
{
    [PixelController getRGBAsFromImage:imageView.image atX:0 andY:0 count:16];
}


@end
