//
//  Utility.m
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#import "Utility.h"
#import "Constants.h"

@implementation Utility

+ (NSString *)getHexStringForColor:(UIColor *)color
{
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"#%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    return hexString;
}

+ (UIColor *)getColorFromHexString:(NSString *)colorHexString
{
    // Assumes input like "#00FF00" (#RRGGBB).

    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:colorHexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    UIColor *color = UIColorFromRGB(rgbValue);
    
    return color;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (void)saveDataToCSV:(NSString *)dataString
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //create an array and store result of our search for the documents directory in it
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //create NSString object, that holds our exact path to the documents directory
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"Document Dir: %@",documentsDirectory);
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:HEX_CSV_FILENAME]];
    [fileManager createFileAtPath:fullPath contents:[dataString dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
}

@end
