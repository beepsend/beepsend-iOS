//
//  BSTransferModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSWallet;

@interface BSTransferModel : BSGeneralModel

@property (nonatomic, strong, readonly) BSWallet *source;
@property (nonatomic, strong, readonly) BSWallet *target;
@property (nonatomic, strong, readonly) NSNumber *amount;

- (BSTransferModel *)initTransferWithSourceWallet:(BSWallet *)wallet1 destinationWallet:(BSWallet *)wallet2 withAmount:(NSNumber *)amount;

@end
