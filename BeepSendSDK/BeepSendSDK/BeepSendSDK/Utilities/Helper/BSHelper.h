//
//  BSHelper.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#	define BSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#	define BSLog(...)
#endif

@interface BSHelper : NSObject

+ (BOOL)isNilOrEmpty:(NSString*)string;

@end
