//
//  Constants.h
//  BitThis
//
//  Created by Nikki Fernandez on 3/21/14.
//  Copyright (c) 2014 SourcePad. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define IMAGE_DIMENSION     16.0
#define SAVE_IMAGE_OUTPUT_WIDTH     320
#define SAVE_IMAGE_OUTPUT_HEIGHT    320

#define API_BASE_URL        @"http://bitthis-api.herokuapp.com"
#define API_POST_ARTS       @"/api/arts"
#define API_HEADER          @"application/vnd.bitthis+json;version=1"

#define HEX_CSV_FILENAME    @"hexdata.csv"