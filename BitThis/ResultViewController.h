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
}

@property (strong, nonatomic) NSArray *result;

- (IBAction)rSliderValueChanged:(UISlider *)slider;
- (IBAction)gSliderValueChanged:(UISlider *)slider;
- (IBAction)bSliderValueChanged:(UISlider *)slider;

@end
