//
//  BitThisViewController.h
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BitThisViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    IBOutlet UIImageView *imageView;
}

- (IBAction)convertButtonAction:(id)sender;
- (IBAction)chooseImageButtonAction:(id)sender;

@end
