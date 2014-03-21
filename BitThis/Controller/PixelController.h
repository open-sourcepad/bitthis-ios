//
//  PixelController.h
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PixelController : NSObject

+ (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count;

@end
