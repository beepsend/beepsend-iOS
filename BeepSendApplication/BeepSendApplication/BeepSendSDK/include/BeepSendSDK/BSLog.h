//
//  BSLogModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/7/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

/*!
 @class BSLog
 @discussion Log is used to show transactions for given wallet.
 */
@interface BSLog : BSGeneralModel

/*! Transaction id.
 */
@property (nonatomic, strong, readonly) NSString *logID;

/*! Unix time when the transaction took place.
 */
@property (nonatomic, strong, readonly) NSDate *timeOfTransaction;

/*! Balance after the transaction.
 */
@property (nonatomic, strong, readonly) NSNumber *balanceAfterTransaction;

/*! Amount that was added/deducted from the wallet.
 */
@property (nonatomic, strong, readonly) NSNumber *change;

/*! Comment attached to transaction.
 */
@property (nonatomic, strong, readonly) NSString *comment;

/*! Create Log object
 
 @param logID - Transaction id
 @param time - Unix time when the transaction took place
 @param balance - Balance after the transaction
 @param change - Amount that was added/deducted from the wallet
 @param comment - Comment attached to transaction
 
 @return Returns Log object
 */
- (BSLog *)initLogWithID:(NSString *)logID
				  atTime:(NSDate *)time
			 withBalance:(NSNumber *)balance
				  change:(NSNumber *)change
				 comment:(NSString *)comment;

@end
