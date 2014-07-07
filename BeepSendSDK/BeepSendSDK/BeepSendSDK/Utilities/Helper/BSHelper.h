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

//Defines date format for SMPP standard
//Used for converting to NSDate
#define kDateFormatForSMPPStandard @"YYMMDDhhmmsstnnp"

//Defines SMS character count for single SMS and long SMS
#define kSMSOrdinaryCharacterCountISO 160
#define kSMSLongCharacterCountISO 153

#define kSMSOrdinaryCharacterCountUTF16 70
#define kSMSLongCharacterCountUTF16 66

@interface BSHelper : NSObject

+ (BOOL)isNilOrEmpty:(NSString*)string;

@end
