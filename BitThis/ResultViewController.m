//
//  ResultViewController.m
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#import "ResultViewController.h"
#import "PixelController.h"
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"
#import "Constants.h"

@interface ResultViewController () <PixelControllerDelegate>
@property (strong, nonatomic) UIBarButtonItem *rightBarButton;
@property (strong, nonatomic) NSArray *rColorArray;
@property (strong, nonatomic) NSArray *gColorArray;
@property (strong, nonatomic) NSArray *bColorArray;
@property (nonatomic) CGFloat rColorFloat;
@property (nonatomic) CGFloat gColorFloat;
@property (nonatomic) CGFloat bColorFloat;
@property (nonatomic) BOOL isEditing;
@end

@implementation ResultViewController

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
    
    resultView.layer.borderWidth = 1.0;
    resultView.layer.borderColor = [UIColor blackColor].CGColor;
    
    _rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction:)];
    self.navigationItem.rightBarButtonItem = _rightBarButton;
    
    _rColorArray = [NSArray arrayWithObjects:@"0", @"32", @"64", @"96", @"128", @"160", @"196", @"224", @"255", nil];
    _gColorArray = [NSArray arrayWithObjects:@"0", @"32", @"64", @"96", @"128", @"160", @"196", @"224", @"255", nil];
    _bColorArray = [NSArray arrayWithObjects:@"0", @"64", @"128", @"192", @"255", nil];
    _rColorFloat = 1.0;
    _gColorFloat = 1.0;
    _bColorFloat = 1.0;
    
    // Disable editing
    slidersContainerView.hidden = YES;
    _isEditing = NO;

}

- (void)viewWillAppear:(BOOL)animated
{
    [self showResult:self.result];
    [PixelController postArts:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button Actions
- (void)editAction:(id)sender
{
    _rightBarButton = nil;
    _rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    self.navigationItem.rightBarButtonItem = _rightBarButton;
    // Enable editing
    slidersContainerView.hidden = NO;
    _isEditing = YES;
    // Hide Save Image button
    saveImageButton.hidden = YES;
}

- (void)doneAction:(id)sender
{
    _rightBarButton = nil;
    _rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction:)];
    self.navigationItem.rightBarButtonItem = _rightBarButton;
    // Disable editing
    slidersContainerView.hidden = YES;
    _isEditing = NO;
    // Show Save Image button
    saveImageButton.hidden = NO;
}

#pragma mark Private Method
- (void)showResult:(NSArray *)result
{
    int count = IMAGE_DIMENSION;
    
    // Plot results
    CGFloat squareDimension = resultView.frame.size.width/(CGFloat)count;
    CGFloat xPos = 0.0;
    CGFloat yPos = 0.0;
    
    for(int col=0; col<count; col++) {
        
        for(int row=0; row<count; row++) {
            UIImageView *squareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, yPos, squareDimension, squareDimension)];
            squareImageView.backgroundColor = [Utility getColorFromHexString:[[result objectAtIndex:col] objectAtIndex:row]];
            squareImageView.userInteractionEnabled = YES;
            [resultView addSubview:squareImageView];
            
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedSquare:)];
            [squareImageView addGestureRecognizer:tapGestureRecognizer];
            tapGestureRecognizer = nil;
            
            xPos += squareDimension;
            squareImageView = nil;
        }
        xPos = 0.0;
        yPos += squareDimension;
    }
}

#pragma mark Gesture Recognizer
- (void)tappedSquare:(UIGestureRecognizer *)recognizer
{
    if (!_isEditing) return;
    
    UIView* view = recognizer.view;
    
    view.backgroundColor = [UIColor colorWithRed:_rColorFloat green:_gColorFloat blue:_bColorFloat alpha:1.0];
//    CGPoint loc = [gestureRecognizer locationInView:view];
//    UIView* subview = [view hitTest:loc withEvent:nil];
}


#pragma mark - Slider actions
- (IBAction)rSliderValueChanged:(UISlider *)slider
{
    _rColorFloat = [[_rColorArray objectAtIndex:slider.value] floatValue] / 255.0;
    // Update color preview
    sliderPreview.backgroundColor = [UIColor colorWithRed:_rColorFloat green:_gColorFloat blue:_bColorFloat alpha:1.0];
}

- (IBAction)gSliderValueChanged:(UISlider *)slider
{
    _gColorFloat = [[_gColorArray objectAtIndex:slider.value] floatValue] / 255.0;
    // Update color preview
    sliderPreview.backgroundColor = [UIColor colorWithRed:_rColorFloat green:_gColorFloat blue:_bColorFloat alpha:1.0];
}

- (IBAction)bSliderValueChanged:(UISlider *)slider
{
    _bColorFloat = [[_bColorArray objectAtIndex:slider.value] floatValue] / 255.0;
    // Update color preview
    sliderPreview.backgroundColor = [UIColor colorWithRed:_rColorFloat green:_gColorFloat blue:_bColorFloat alpha:1.0];
}

@end
