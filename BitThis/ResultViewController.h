//
//  ResultViewController.h
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
{
    IBOutlet UIView *resultView;
    IBOutlet UIImageView *sliderPreview;
    IBOutlet UIView *slidersContainerView;
    IBOutlet UIButton *saveImageButton;
    IBOutlet UIButton *postImageButton;
}

@property (strong, nonatomic) NSArray *result;

- (IBAction)rSliderValueChanged:(UISlider *)slider;
- (IBAction)gSliderValueChanged:(UISlider *)slider;
- (IBAction)bSliderValueChanged:(UISlider *)slider;

- (IBAction)saveImageButtonAction:(id)sender;
- (IBAction)postImageButtonAction:(id)sender;

@end
