//
//  ResultViewController.m
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#import "ResultViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"
#import "Constants.h"

@interface ResultViewController ()
@property (strong, nonatomic) UIBarButtonItem *rightBarButton;
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [self showResult:self.result];
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
}

- (void)doneAction:(id)sender
{
    _rightBarButton = nil;
    _rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction:)];
    self.navigationItem.rightBarButtonItem = _rightBarButton;
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
    UIView* view = recognizer.view;
    
    view.backgroundColor = [UIColor yellowColor];
//    CGPoint loc = [gestureRecognizer locationInView:view];
//    UIView* subview = [view hitTest:loc withEvent:nil];
}
@end
