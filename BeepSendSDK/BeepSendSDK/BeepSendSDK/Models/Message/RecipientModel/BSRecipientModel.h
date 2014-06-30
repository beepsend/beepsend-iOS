//
//  BSRecipientModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/27/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSRecipientModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *destinationNumber;
@property (nonatomic, strong, readonly) NSNumber *numberType;
@property (nonatomic, strong, readonly) NSNumber *numberPlanIndex;

- (BSRecipientModel *)initRecipientWithNumber:(NSString *)number numberType:(NSNumber *)nType planIndex:(NSNumber *)nPlanIndex;

@end
