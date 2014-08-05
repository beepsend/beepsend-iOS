//
//  BSValueForNumberModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

/*!
 @class BSLookup
 @discussion Used for estimated cost of message. 
 Contains number and cost for that number.
 */
@interface BSValueForNumber : BSGeneralModel

/*! Number
 */
@property (nonatomic, strong, readonly) NSString *value;

/*! Numbers cost
 */
@property (nonatomic, strong, readonly) NSNumber *cost;

/*! Create ValueForNumber object
 
 @param value - Number
 @param cost - Cost
 
 @return Returns ValueForNumber object
 */
- (BSValueForNumber *)initWithValue:(NSString *)value
							   cost:(NSNumber *)cost;

@end
