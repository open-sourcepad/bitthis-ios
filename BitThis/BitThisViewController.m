//
//  BitThisViewController.m
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#import "BitThisViewController.h"
#import "ResultViewController.h"
#import "PixelController.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "Utility.h"

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
    int count = IMAGE_DIMENSION;
    
    UIImage *imageToConvert = [Utility imageWithImage:imageView.image scaledToSize:CGSizeMake(IMAGE_DIMENSION, IMAGE_DIMENSION)];
    NSArray *result = [PixelController getRGBAsFromImage:imageToConvert atX:0 andY:0 count:count];
    
    ResultViewController *resultVC = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
    resultVC.result = result;
    [self.navigationController pushViewController:resultVC animated:YES];
    resultVC = nil;
}

- (IBAction)chooseImageButtonAction:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:imagePicker animated:YES completion:nil];
    imagePicker = nil;
}

#pragma mark Image Picker Controller Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    imageView.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
