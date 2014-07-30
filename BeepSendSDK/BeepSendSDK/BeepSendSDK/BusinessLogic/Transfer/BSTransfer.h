//
//  BSTransferModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSWallet;

/*!
 @class BSTransfer
 @discussion Transfer model is response when funds are transfered between wallets.
 */
@interface BSTransfer : BSGeneralModel

/*! Source wallet.
 */
@property (nonatomic, strong, readonly) BSWallet *source;

/*! Target wallet.
 */
@property (nonatomic, strong, readonly) BSWallet *target;

/*! Amount to transfer.
 */
@property (nonatomic, strong, readonly) NSNumber *amount;

/*! Create Transaction object
 
 @param wallet1 - Source wallet
 @param wallet2 - Target wallet
 @param amount - Amount to transfer
 
 @return Returns Transaction object
 */
- (BSTransfer *)initTransferWithSourceWallet:(BSWallet *)wallet1
						   destinationWallet:(BSWallet *)wallet2
								  withAmount:(NSNumber *)amount;

@end
