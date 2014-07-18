//
//  BSHelper.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#	define BSDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#	define BSDLog(...)
#endif

//Defines date format for SMPP standard
//Used for converting to NSDate
#define kDateFormatForSMPPStandard @"YYMMDDhhmmsstnnp"

//Defines SMS character count for single SMS and long SMS
#define kSMSOrdinaryCharacterCountISO 160
#define kSMSLongCharacterCountISO 153

#define kSMSOrdinaryCharacterCountUTF16 70
#define kSMSLongCharacterCountUTF16 66

_Bool is_utf8(const char * string)
{
    if(!string)
        return 0;
	
    const unsigned char * bytes = (const unsigned char *)string;
    while(*bytes)
    {
        if( (// ASCII
             // use bytes[0] <= 0x7F to allow ASCII control characters
			 bytes[0] == 0x09 ||
			 bytes[0] == 0x0A ||
			 bytes[0] == 0x0D ||
			 (0x20 <= bytes[0] && bytes[0] <= 0x7E)
			 )
		   ) {
            bytes += 1;
            continue;
        }
		
        if( (// non-overlong 2-byte
			 (0xC2 <= bytes[0] && bytes[0] <= 0xDF) &&
			 (0x80 <= bytes[1] && bytes[1] <= 0xBF)
			 )
		   ) {
            bytes += 2;
            continue;
        }
		
        if( (// excluding overlongs
			 bytes[0] == 0xE0 &&
			 (0xA0 <= bytes[1] && bytes[1] <= 0xBF) &&
			 (0x80 <= bytes[2] && bytes[2] <= 0xBF)
			 ) ||
		   (// straight 3-byte
			((0xE1 <= bytes[0] && bytes[0] <= 0xEC) ||
			 bytes[0] == 0xEE ||
			 bytes[0] == 0xEF) &&
			(0x80 <= bytes[1] && bytes[1] <= 0xBF) &&
			(0x80 <= bytes[2] && bytes[2] <= 0xBF)
            ) ||
		   (// excluding surrogates
			bytes[0] == 0xED &&
			(0x80 <= bytes[1] && bytes[1] <= 0x9F) &&
			(0x80 <= bytes[2] && bytes[2] <= 0xBF)
            )
		   ) {
            bytes += 3;
            continue;
        }
		
        if( (// planes 1-3
			 bytes[0] == 0xF0 &&
			 (0x90 <= bytes[1] && bytes[1] <= 0xBF) &&
			 (0x80 <= bytes[2] && bytes[2] <= 0xBF) &&
			 (0x80 <= bytes[3] && bytes[3] <= 0xBF)
			 ) ||
		   (// planes 4-15
			(0xF1 <= bytes[0] && bytes[0] <= 0xF3) &&
			(0x80 <= bytes[1] && bytes[1] <= 0xBF) &&
			(0x80 <= bytes[2] && bytes[2] <= 0xBF) &&
			(0x80 <= bytes[3] && bytes[3] <= 0xBF)
            ) ||
		   (// plane 16
			bytes[0] == 0xF4 &&
			(0x80 <= bytes[1] && bytes[1] <= 0x8F) &&
			(0x80 <= bytes[2] && bytes[2] <= 0xBF) &&
			(0x80 <= bytes[3] && bytes[3] <= 0xBF)
            )
		   ) {
            bytes += 4;
            continue;
        }
		
        return 0;
    }
	
    return 1;
}

@interface BSHelper : NSObject

+ (BOOL)isNilOrEmpty:(NSString*)string;

@end
