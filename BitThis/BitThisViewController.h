//
//  BitThisViewController.h
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BitThisViewController : UIViewController
{
    IBOutlet UIImageView *imageView;
    IBOutlet UIButton *convertButton;
}

- (IBAction)convertButtonAction:(id)sender;

@end
