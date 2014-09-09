//
//  BSHelper.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSHelper.h"

#import "BSAPError.h"
#import "BSError.h"

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

+ (NSArray *)handleErrorWithResponse:(id)response andOptionalError:(id)error
{
	static NSString *errorKey = @"errors";
	
	NSMutableArray *mArr = [@[] mutableCopy];
	if (response[errorKey]) {
		if ([response[errorKey] isKindOfClass:[NSArray class]]) {
			mArr = [[BSAPError arrayOfObjectsFromArrayOfDictionaries:response[errorKey]] mutableCopy];
		}
		else if ([response[errorKey] isKindOfClass:[NSDictionary class]]) {
			[mArr addObject:[[BSAPError classFromDict:response[errorKey]] convertToModel]];
		}
		else {
			[mArr addObject:[[BSError alloc] initWithCode:@0
										   andDescription:NSLocalizedString(@"Unknown error", @"")]];
		}
	}
	else {
		[mArr addObject:[[BSError alloc] initWithCode:@0
									   andDescription:[error isKindOfClass:[NSError class]] ? [(NSError *)error localizedDescription] : NSLocalizedString(@"Unknown error", @"")]];
	}
	
	return mArr.count==0 ? nil : [NSArray arrayWithArray:mArr];
}

@end
