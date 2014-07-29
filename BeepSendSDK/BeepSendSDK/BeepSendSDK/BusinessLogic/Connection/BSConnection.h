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
@class BSMCCMNC;

@class BSMessage;
@class BSWallet;

/*!
 @class BSConnection
 @discussion If authenticated using a Connection token only one connect object is accessible.
 If authenticated using a User token there can be one or several connections accessible.
 */
@interface BSConnection : BSGeneralModel

/*! Connection ID.
 */
@property (nonatomic, strong, readonly) NSString *connectionID;

/*! Type of connection, 1 for SMS connection or 2 for HLR connection.
 */
@property (nonatomic, assign, readonly) BSConnectionType type;

/*! List of users with read-write access to this connection.
 */
@property (nonatomic, strong, readonly) NSArray *users;

/*! Wallet that belongs to connection
 */
@property (nonatomic, strong, readonly) BSWallet *wallet;

//Properties that can be edited by user

/*! Connection label.
 */
@property (nonatomic, strong) NSString *label;

/*! (Optional) Description of this connection.
 */
@property (nonatomic, strong) NSString *description;

/*! Login name.
 */
@property (nonatomic, strong) NSString *systemID;

/*! Specifies if connection is default
 */
@property (nonatomic, assign) BOOL defaultConnection;

/*! API Token belonging to this connection.
 */
@property (nonatomic, strong, readonly) NSString *apiToken;

/*! Connection callbacks.
 */
@property (nonatomic, strong) BSCallbacks *callbackURLs;

/*! Customer name.
 */
@property (nonatomic, strong, readonly) NSString *customer;

/*! Tag-Length-Value field for returning mcc and mnc in DLR.
 */
@property (nonatomic, strong, readonly) NSNumber *TLVForMCCAndMNC;

/*! Whitelisted urls for connection
 */
@property (nonatomic, strong, readonly) NSArray *whitelist;

/*! Connection password
 */
@property (nonatomic, strong, readonly) NSString *password;

/*! Create Connection object
 Used only when ID of connection is available.
 
 @param cID - Connection ID
 
 @return Returns Connection object
 */
- (BSConnection *)initConnectionWithID:(NSString *)cID;

/*! Create Connection object
 Used for initializing connection object with object received from server
 
 @param cID - Connection ID
 @param cAPIToken - API token
 @param cCallbacks - Callbacks
 @param cCustomer - Customer
 @param cDescription - Description
 @param cLabel - Label
 @param cSystemID - System ID
 @param cTlvformccandmnc - Tag-Length-Value field for returning mcc and mnc in DLR.
 @param cType - Connection type
 @param cUsers - Users
 @param cWallet - Wallet
 @param cWhitelist - Whitelist
 @param password - Password
 
 @return Returns Connection object
 */
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

/*! Copy constructor with new API token
 
 @param connectionModel - Connection
 @param newToken - New API token
 
 @return Returns Connection object
 */
- (BSConnection *)initWithConnectionModel:(BSConnection *)connectionModel
							 withNewToken:(NSString *)newToken;

/*! Copy constructor with new password
 
 @param connectionModel - Connection
 @param newPassword - New password
 
 @return Returns Connection object
 */
- (BSConnection *)initWithConnectionModel:(BSConnection *)connectionModel
						  withNewPassword:(NSString *)newPassword;

/*! If Connection token is entered current connection will return connection for 
	given API token.
 
	If User token is entered current connection will return default connection 
	for that user.
 
 @return Returns Connection object
 */
+ (BSConnection *)currentConnection;

/*! If changes were made to connection use update method to save changes.
 */
- (void)updateConnection;

/*! If you think that the connection token used for authenticating with 
	the Beepsend API has been compromised you can use this method 
	(with a user token) to reset the connection token.
 */
- (void)resetConnectionToken;

/*! Receive all price lists revisions for a specific connection 
	related to the authenticated user. 
	A connection ID or alias tag "me" must be provided as reference.
 */
- (void)getPricelistsOnCompletion:(void(^)(NSArray *pricelists))block;

/*! Instead of fetching all revisions and then using the latest revision id to
	get the current price list the following can be used for both 
	User and Connection authentifications
 */
- (void)getCurrentPricelistOnCompletion:(void(^)(BSPricelist *pricelist))block;

/*! Method sends message and returns number of messages
 
 @param message - Message object for sending
 @param block - Block object that returns message if sending was successfull or error
 
 @return Returns number of messages
 */
- (NSInteger)sendSMS:(BSMessage *)message
 withCompletionBlock:(void(^)(BSMessage *message, NSArray *errors))block;

/*! Method sends multiple messages and returns number of messages
 
 @param messages - Array of message objects for sending
 @param block - Block object that returns array of messages if sending was successfull or errors
 
 @return Returns number on messages
 */
- (NSInteger)sendMultipleSMS:(NSArray *)messages
		 withCompletionBlock:(void(^)(NSArray *messages, NSArray *errors))block;

/*! Method that calculates number of messages for message
	based on character count and encoding
 
 @param message - Message object to calculate message count
 
 @return Returns number of messages
 */
- (NSInteger)smsCountForMessage:(BSMessage *)message;

/*! Method that calculates number of messages for array of messages
	based on character count and encoding
	Message count is sum of calculated message count for every message in array
 
 @param messages - Array of message objects to calculate message count
 
 @return Returns number of messages
 */
- (NSInteger)smsCountForMessages:(NSArray *)messages;

/*! Method that performs a dry run of SMS sending
 
 @param message - Message to validate
 @param block - Returns message without ID or error if validation failed
 */
- (void)validateSMS:(BSMessage *)message
	   onCompletion:(void(^)(BSMessage *message, NSArray *errors))block;

/*! The API can be utilized to get details of any message sent through Beepsend 
	no matter if you submitted it via SMPP or HTTP
 
 @param message - Message to lookup
 @param block - Returns message lookup or error if lookup failed
 */
- (void)getDetailsForSMS:(BSMessage *)message
			onCompletion:(void(^)(BSLookup *lookup, NSArray *errors))block;

/*! Get details regarding multiple sent messages with filters.
 
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
					   onCompletion:(void(^)(NSArray *lookups, NSArray *errors))block;

/*! How many SMS objects to fetch.
 
 @param lookupPageLimit - Maximum 200, default 100.
 */
- (void)setLookupPageLimit:(NSNumber *)lookupPageLimit;

/*! Get batch details
 
 @param batch - Batch with ID
 @param block - Returns batch details
 */
- (void)getDetailsForBatch:(BSBatch *)batch
			  onCompletion:(void(^)(BSBatch *batch, NSArray *errors))block;

/*! Get previous batches
 
 @param block - Returns array of previous batches
 */
- (void)getPreviousBatchesOnCompletion:(void(^)(NSArray *batches, NSArray *errors))block;

/*! Estimates message cost (not necessarily accurate)
 
 @param messages - Messages to estimate price for
 @param block - Returns array of cost per message
 */
- (void)estimateSMSCostForMessages:(NSArray *)messages
					  onCompletion:(void(^)(NSArray *cost, NSArray *errors))block;

/*! Method that performs immediate HLR lookup
	(takes some time)
 
 @param phoneNumber - Phone number to perform HLR
 @param block - Returns HLR response or error
 */
- (void)immediateHLRForNumber:(NSString *)phoneNumber
				 onCompletion:(void(^)(BSHLR *hlr, NSArray *errors))block;

/*! Method that performs a dry run of HLR lookup
	(takes some time)
 
 @param phoneNumber - Phone number to perform HLR
 @param block - Returns HLR response or error
 */
- (void)validateHLRForNumber:(NSString *)phoneNumber
				onCompletion:(void(^)(BSHLR *hlr, NSArray *errors))black;

/*! This call does not consider delivery statistics
	and should merely be used for aggregated views on traffic. 

 @param startDate - Begin Date in Unix time.
 @param endDate - End dates in Unix time.
 @param block - Returns statistics or error
 */
- (void)getAnalyticsSummaryFromDate:(NSDate *)startDate
							 toDate:(NSDate *)endDate
				withCompletionBlock:(void(^)(NSArray *statistics, NSArray *errors))block;

/*! The call supports a summary for available connections on used token. 
 
 @param startDate - Begin Date in Unix time.
 @param endDate - End dates in Unix time.
 @param mccmnc - Mobile Country Code
 @param block - Returns network details or error
 */
- (void)getNetworkDetailsFromDate:(NSDate *)startDate
						   toDate:(NSDate *)endDate
						   mccmnc:(BSMCCMNC *)mccmnc
			  withCompletionBlock:(void(^)(NSArray *networkDetails, NSArray *errors))block;

@end
