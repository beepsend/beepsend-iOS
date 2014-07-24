//
//  BSValueForNumberModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSValueForNumber : BSGeneralModel

/** Number
 */
@property (nonatomic, strong, readonly) NSString *value;

/** Numbers cost
 */
@property (nonatomic, strong, readonly) NSNumber *cost;

/** Init ValueForNumber with value, cost
 
 @param value - Value
 @param cost - Cost
 
 @return Returns ValueForNumber cost object
 */
- (BSValueForNumber *)initWithValue:(NSString *)value cost:(NSNumber *)cost;

@end
