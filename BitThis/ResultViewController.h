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
}

@property (strong, nonatomic) NSArray *result;

@end
