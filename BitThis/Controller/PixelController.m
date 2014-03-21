//
//  PixelController.m
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#import "PixelController.h"
#import "BitThisAppDelegate.h"
#import "Utility.h"
#import "Constants.h"

@implementation PixelController

@synthesize delegate;

#pragma mark - Singleton
static PixelController *singleton = nil;

+ (PixelController *)getInstance
{
    if(singleton == nil) {
        singleton = [[PixelController alloc] init];
    }
    return singleton;
}

// http://stackoverflow.com/questions/448125/how-to-get-pixel-data-from-a-uiimage-cocoa-touch-or-cgimage-core-graphics

+ (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    NSString *resultString = @"";
    
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
        NSString *rowResultString = @"";
        
        for (int ii = 0 ; ii < count ; ++ii)
        {
//            CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
//            CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
//            CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
            
            int r = (int)((rawData[byteIndex]     * 1.0)/28) * 28;
            int g = (int)((rawData[byteIndex + 1] * 1.0)/28) * 28;
            int b = (int)((rawData[byteIndex + 2] * 1.0)/51) * 51;
            
            CGFloat red = r / 255.0;
            CGFloat green = g / 255.0;
            CGFloat blue = b / 255.0;
            CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
            
            NSLog(@"%3d, %3d, %3d", r, g, b);
            
            byteIndex += 4;
            
            UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
            
            // Convert to Hex color
            NSString *hexString = [Utility getHexStringForColor:acolor];
            [rowResult addObject:hexString];
            
            if(rowResultString.length==0)
                rowResultString = [NSString stringWithFormat:@"\"%@\"",hexString];
            else
                rowResultString = [NSString stringWithFormat:@"%@,\"%@\"", rowResultString, hexString];
        }
        // Add new space
        rowResultString = [NSString stringWithFormat:@"%@\n",rowResultString];
        resultString = [NSString stringWithFormat:@"%@%@", resultString, rowResultString];
        
        [result addObject:rowResult];
        rowResult = nil;
    }
    
    [Utility saveDataToCSV:resultString];
//    NSLog(@"%@", resultString);
    
    free(rawData);
    
    return result;
}

+ (void)postArts:(id <PixelControllerDelegate>)delegate
{
//    RKObjectManager *objMgr = ((BitThisAppDelegate *)[[UIApplication sharedApplication] delegate]).apiObjMgr;
//    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
//    
//    [objMgr setAcceptHeaderWithMIMEType:API_HEADER];
//    [objMgr.HTTPClient postPath:API_POST_ARTS
//                     parameters:params
//                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                            NSError *error;
//                            NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:0 error:&error];
//                            NSLog(@"Response: %@", responseDict);
//                            BOOL isSuccess = [[responseDict objectForKey:@"success"] boolValue];
//                            
//                            if(isSuccess) {
//                                
//                            }
//                            else {
//                                
//                            }
//                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                            NSLog(@"Error: %@", error.localizedDescription);
//                            
//                        }];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"bitthisapp@gmail.com", @"google_username",
                                   @"bitthis123", @"google_password",
                                   @"BitThisTest", @"title",
                                   nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *csvPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:HEX_CSV_FILENAME]];
    NSData *csvData = [NSData dataWithContentsOfFile:csvPath];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_BASE_URL, API_POST_ARTS]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:API_HEADER forHTTPHeaderField:@"Accept"];
    
    // set Content-Type in HTTP header
    NSString *boundary = @"0x0hHai1CanHazB0undar135";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    if (csvData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"hexdata.csv\"\r\n", @"hex_colors"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@",@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:csvData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                               NSLog(@"Response Dict: %@", responseDict);
                               
                               if(error) {
                                   if([delegate respondsToSelector:@selector(postArts:didFailWithResultDict:)])
                                       [delegate performSelector:@selector(postArts:didFailWithResultDict:) withObject:nil];
                               }
                               else {
                                   BOOL isSuccess = [[responseDict objectForKey:@"success"] boolValue];
                                   if(isSuccess) {
                                       if([delegate respondsToSelector:@selector(postArtsDidFinish:)])
                                           [delegate performSelector:@selector(postArtsDidFinish:) withObject:responseDict];
                                   }
                                   else {
                                       if([delegate respondsToSelector:@selector(postArts:didFailWithResultDict:)])
                                           [delegate performSelector:@selector(postArts:didFailWithResultDict:) withObject:nil];
                                   }
                               }
                           }];
}

@end
