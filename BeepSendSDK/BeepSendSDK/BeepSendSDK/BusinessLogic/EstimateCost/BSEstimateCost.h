//
//  BSEstimateCostModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSValueForNumber.h"

@interface BSEstimateCost : BSGeneralModel

/** Array containing number and it's cost
 */
@property (nonatomic, strong, readonly) NSArray *recipients;

/** Total estimated cost for all messages
 */
@property (nonatomic, strong, readonly) NSNumber *totalCost;

/** Init Estimate cost with recipients, total cost
 
 @param recipients - Recipients
 @param totalCost - Total cost

 @return Returns Estimate cost object
 */
- (BSEstimateCost *)initWithRecipients:(NSArray *)recipients totalCost:(NSNumber *)totalCost;

@end
