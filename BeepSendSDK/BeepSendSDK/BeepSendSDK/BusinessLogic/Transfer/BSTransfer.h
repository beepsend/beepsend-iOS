//
//  BSTransferModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSWallet;

@interface BSTransfer : BSGeneralModel

/** Source wallet
 */
@property (nonatomic, strong, readonly) BSWallet *source;

/** Target wallet
 */
@property (nonatomic, strong, readonly) BSWallet *target;

/** Amount to transfer
 */
@property (nonatomic, strong, readonly) NSNumber *amount;

- (BSTransfer *)initTransferWithSourceWallet:(BSWallet *)wallet1 destinationWallet:(BSWallet *)wallet2 withAmount:(NSNumber *)amount;

@end
