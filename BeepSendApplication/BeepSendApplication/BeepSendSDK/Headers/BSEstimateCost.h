//
//  BSEstimateCostModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSValueForNumber.h"

/*!
 @class BSEstimateCost
 @discussion Estimated model contains cost for numbers plus total cost 
 (if list of numbers or groups is entered)
 */
@interface BSEstimateCost : BSGeneralModel

/*! Array containing number and it's cost
 */
@property (nonatomic, strong, readonly) NSArray *recipients;

/*! Total estimated cost for all messages
 */
@property (nonatomic, strong, readonly) NSNumber *totalCost;

/*! Create Estimate cost object
 
 @param recipients - Array containing number and it's cost
 @param totalCost - Total estimated cost for all messages

 @return Returns Estimate cost object
 */
- (BSEstimateCost *)initWithRecipients:(NSArray *)recipients
							 totalCost:(NSNumber *)totalCost;

@end
