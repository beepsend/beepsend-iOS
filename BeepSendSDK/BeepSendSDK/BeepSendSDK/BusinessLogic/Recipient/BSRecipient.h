//
//  BSRecipientModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSRecipient : BSGeneralModel

/** Destination address.
 */
@property (nonatomic, strong, readonly) NSString *destinationNumber;

/** Type of number.
 */
@property (nonatomic, strong, readonly) NSNumber *numberType;

/** Number Plan Index.
 */
@property (nonatomic, strong, readonly) NSNumber *numberPlanIndex;

- (BSRecipient *)initRecipientWithNumber:(NSString *)number numberType:(NSNumber *)nType planIndex:(NSNumber *)nPlanIndex;

@end
