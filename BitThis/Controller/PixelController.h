//
//  PixelController.h
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@protocol PixelControllerDelegate;

@interface PixelController : NSObject
{
    @private
    id <PixelControllerDelegate> delegate;
}

@property (strong, nonatomic) id <PixelControllerDelegate> delegate;

+ (void)postArts:(id <PixelControllerDelegate>)delegate;

+ (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count;

@end

@protocol PixelControllerDelegate <NSObject>

@end
