//
//  BSHelper.h
//  BeepSendApplication
//
//  Created by Vladica Pesic on 6/11/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <Foundation/Foundation.h>

#import	"Constants.h"

////////////////////////////////////////////////////////////////////////////////
//Remove NSLog from release
#ifdef DISTRIBUTION
#	define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#	define DLog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//Count execution time
#define StartCounting NSDate *startTime
#define TICK startTime = [NSDate date]

#define TOCK DLog(@"Time: %f", -[startTime timeIntervalSinceNow])
////////////////////////////////////////////////////////////////////////////////

@interface Helper : NSObject

//Checks if string is nil or empty
+ (BOOL)isNilOrEmpty:(NSString*)string;

//Prints all available font names in iOS
+ (void)printAvailableFonts;

//Draws linear gradient
+ (void)drawLinearGradientWithContext:(CGContextRef)context inRect:(CGRect)rect startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor;

@end
