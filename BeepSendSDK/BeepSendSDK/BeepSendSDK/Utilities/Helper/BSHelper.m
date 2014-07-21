//
//  BSHelper.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSHelper.h"

@implementation BSHelper

+ (BOOL)isNilOrEmpty:(NSString*)string {
	
	if ([string isKindOfClass:[NSNumber class]]) {
		return string ? NO : YES;
	}
	
	if (string == nil || [string isEqual:[NSNull null]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
		return YES;
	}
	else {
		return NO;
	}
}

@end
