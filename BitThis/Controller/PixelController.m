//
//  PixelController.m
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#import "PixelController.h"
#import "Utility.h"

@implementation PixelController

// http://stackoverflow.com/questions/448125/how-to-get-pixel-data-from-a-uiimage-cocoa-touch-or-cgimage-core-graphics
+ (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    
    // First get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    for(int jj= yy; jj<count; jj++) {
        
        NSMutableArray *rowResult = [NSMutableArray arrayWithCapacity:count];
        int byteIndex = (int)((bytesPerRow * jj) + xx * bytesPerPixel);
        
        for (int ii = 0 ; ii < count ; ++ii)
        {
            CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
            CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
            CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
            CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
            
            byteIndex += 4;
            
            UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
            
            // Convert to Hex color
            NSString *hexString = [Utility getHexStringForColor:acolor];
            [rowResult addObject:hexString];
        }
        [result addObject:rowResult];
        rowResult = nil;
    }
    
    free(rawData);
    
    NSLog(@"Result: %@", result);
    
    return result;
}

@end
