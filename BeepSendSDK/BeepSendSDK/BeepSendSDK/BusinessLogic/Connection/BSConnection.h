//
//  BSConnection.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"
#import "BSStructs.h"

@class BSPricelist;
@class BSCallbacks;
@class BSBatch;
@class BSEstimateCost;
@class BSHLR;
@class BSLookup;

@class BSMessage;
@class BSWallet;

@interface BSConnection : BSGeneralModel

/** Connection ID.
 */
@property (nonatomic, strong, readonly) NSString *connectionID;

/** Type of connection, 1 for SMS connection or 2 for HLR connection.
 */
@property (nonatomic, assign, readonly) BSConnectionType type;

/** List of users with read-write access to this connection.
 */
@property (nonatomic, strong, readonly) NSArray *users;

/** Wallet that belongs to connection
 */
@property (nonatomic, strong, readonly) BSWallet *wallet;

//Properties that can be edited by user

/** Connection label.
 */
@property (nonatomic, strong) NSString *label;

/** (Optional) Description of this connection.
 */
@property (nonatomic, strong) NSString *description;

/** Login name.
 */
@property (nonatomic, strong) NSString *systemID;

/** Specifies if connection is default
 */
@property (nonatomic, assign) BOOL defaultConnection;

/** API Token belonging to this connection.
 */
@property (nonatomic, strong, readonly) NSString *apiToken;

/** Connection callbacks.
 */
@property (nonatomic, strong) BSCallbacks *callbackURLs;

/** Customer name.
 */
@property (nonatomic, strong, readonly) NSString *customer;

/** Tag-Length-Value field for returning mcc and mnc in DLR.
 */
@property (nonatomic, strong, readonly) NSNumber *TLVForMCCAndMNC;

/** Whitelisted urls for connection
 */
@property (nonatomic, strong, readonly) NSArray *whitelist;

/** Connection password
 */
@property (nonatomic, strong, readonly) NSString *password;

- (BSConnection *)initConnectionWithID:(NSString *)cID;

- (BSConnection *)initConnectionWithID:(NSString *)cID
							  apiToken:(NSString *)cAPIToken
							 callbacks:(BSCallbacks *)cCallbacks
							  customer:(NSString *)cCustomer
						   description:(NSString *)cDescription
								 label:(NSString *)cLabel
							  systemID:(NSString *)cSystemID
					   tlvformccandmnc:(NSNumber *)cTlvformccandmnc
								  type:(BSConnectionType)cType
								 users:(NSArray *)cUsers
								wallet:(BSWallet *)cWallet
							 whitelist:(NSArray *)cWhitelist
							  password:(NSString *)password;

//Copy constructor with new API token
- (BSConnection *)initWithConnectionModel:(BSConnection *)connectionModel
							 withNewToken:(NSString *)newToken;

//Copy constructor with new password
- (BSConnection *)initWithConnectionModel:(BSConnection *)connectionModel
						  withNewPassword:(NSString *)newPassword;

- (BSConnection *)initConnectionWithID:(NSString *)cID
								 label:(NSString *)cLabel
							  systemID:(NSString *)cSystemID
								  type:(BSConnectionType)cType;

/** 
 */
+ (BSConnection *)currentConnection;

/** If changes were made to connection use update method to save changes.
 */
- (void)updateConnection;

/** If you think that the connection token used for authenticating with 
	the Beepsend API has been compromised you can use this method 
	(with a user token) to reset the connection token.
 */
- (void)resetConnectionToken;

/** Receive all price lists revisions for a specific connection 
	related to the authenticated user. 
	A connection ID or alias tag "me" must be provided as reference.
 */
- (void)getPricelistsOnCompletion:(void(^)(NSArray *pricelists))block;

/** Instead of fetching all revisions and then using the latest revision id to
	get the current price list the following can be used for both 
	User and Connection authentifications
 */
- (void)getCurrentPricelistOnCompletion:(void(^)(BSPricelist *pricelist))block;

/** Method sends message and returns number of messages
 
 @param message - Message object for sending
 @param block - Block object that returns message if sending was successfull or error
 */
- (NSInteger)sendSMS:(BSMessage *)message withCompletionBlock:(void(^)(BSMessage *message, id error))block;

/** Method sends multiple messages and returns number of messages
 
 @param messages - Array of message objects for sending
 @param block - Block object that returns array of messages if sending was successfull or errors
 */
- (NSInteger)sendMultipleSMS:(NSArray *)messages withCompletionBlock:(void(^)(NSArray *messages, id error))block;

/** Method that calculates number of messages for message
	based on character count and encoding
 
 @param message - Message object to calculate message count
 */
- (NSInteger)smsCountForMessage:(BSMessage *)message;

/** Method that calculates number of messages for array of messages
	based on character count and encoding
	Message count is sum of calculated message count for every message in array
 
 @param messages - Array of message objects to calculate message count
 */
- (NSInteger)smsCountForMessages:(NSArray *)messages;

/** Method that performs a dry run of SMS sending
 
 @param message - Message to validate
 @param block - Returns message without ID or error if validation failed
 */
- (void)validateSMS:(BSMessage *)message onCompletion:(void(^)(BSMessage *message, id error))block;

/** The API can be utilized to get details of any message sent through Beepsend 
	no matter if you submitted it via SMPP or HTTP
 
 @param message - Message to lookup
 @param block - Returns message lookup or error if lookup failed
 */
- (void)getDetailsForSMS:(BSMessage *)message onCompletion:(void(^)(BSLookup *lookup, id error))block;

/** Get details regarding multiple sent messages with filters.
 
 @param recipient - MSISDN (phone number), the to address.
 @param sender - Sender id. The from address.
 @param batch - Will return every message sent with the same batch.
 @param bDate - Filter messages sent before this date.
 @param aDate - Filter messages sent after this date.
 @param nextPage - If YES then new page with results will be loaded
 @param block - Returns array of found messages or error
 */
- (void)getDetailsForMessagesSentTo:(NSString *)recipient
						   sentFrom:(NSString *)sender
						  usedBatch:(BSBatch *)batch
						 beforeDate:(NSDate *)bDate
						  afterDate:(NSDate *)aDate
						forNextPage:(BOOL)nextPage
					   onCompletion:(void(^)(NSArray *lookups, id error))block;

/** How many SMS objects to fetch.
 
 @param lookupPageLimit - Maximum 200, default 100.
 */
- (void)setLookupPageLimit:(NSNumber *)lookupPageLimit;

/** Get batch details
 
 @param batch - Batch with ID
 @param block - Returns batch details
 */
- (void)getDetailsForBatch:(BSBatch *)batch onCompletion:(void(^)(BSBatch *batch, id error))block;

/** Get previous batches
 
 @param block - Returns array of previous batches
 */
- (void)getPreviousBatchesOnCompletion:(void(^)(NSArray *batches, id error))block;

/** Estimates message cost (not necessarily accurate)
 
 @param messages - Messages to estimate price for
 @param block - Returns array of cost per message
 */
- (void)estimateSMSCostForMessages:(NSArray *)messages onCompletion:(void(^)(NSArray *cost, id error))block;

/** Method that performs immediate HLR lookup
	(takes some time)
 
 @param phoneNumber - Phone number to perform HLR
 @param block - Returns HLR response or error
 */
- (void)immediateHLRForNumber:(NSString *)phoneNumber onCompletion:(void(^)(BSHLR *hlr, id error))block;

/** Method that performs a dry run of HLR lookup
	(takes some time)
 
 @param phoneNumber - Phone number to perform HLR
 @param block - Returns HLR response or error
 */
- (void)validateHLRForNumber:(NSString *)phoneNumber onCompletion:(void(^)(BSHLR *hlr, id error))black;

@end
