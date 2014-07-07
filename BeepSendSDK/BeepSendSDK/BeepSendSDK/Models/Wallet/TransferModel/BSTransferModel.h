//
//  BSTransferModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSWalletModel;

@interface BSTransferModel : BSGeneralModel

@property (nonatomic, strong, readonly) BSWalletModel *source;
@property (nonatomic, strong, readonly) BSWalletModel *target;
@property (nonatomic, strong, readonly) NSNumber *amount;

- (BSTransferModel *)initTransferWithSourceWallet:(BSWalletModel *)wallet1 destinationWallet:(BSWalletModel *)wallet2 withAmount:(NSNumber *)amount;

@end
