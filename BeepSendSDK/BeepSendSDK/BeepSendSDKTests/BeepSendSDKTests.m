//
//  BeepSendSDKTests.m
//  BeepSendSDKTests
//
//  Created by Vladica Pesic on 6/10/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BSTestSemaphor.h"
#import "BSHelper.h"

#import "BeepSendSDK.h"

@interface BeepSendSDKTests : XCTestCase

@property (nonatomic, strong) BSUser *user;
@property (nonatomic, strong) BSConnection *connection;

@end

@implementation BeepSendSDKTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
	_user = [BSUser currentUser];
	_connection = [BSConnection currentConnection];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Test methods

- (void)testGettingUserData
{
	NSAssert(_user!=nil, @"User object not created!");
	
	BSDLog(@"\nUser ID: %@", _user.userID);
	BSDLog(@"\nUser name: %@", _user.name);
	BSDLog(@"\nUser email: %@", _user.email);
	BSDLog(@"\nUser phone: %@", _user.phone);
	BSDLog(@"\nUser customer name: %@", _user.customerName);
	BSDLog(@"\nUser max level: %@", _user.maxLevel);
	BSDLog(@"\nUser API token: %@", _user.apiToken);
	BSDLog(@"\nUser user types: %@", _user.userTypes);
	BSDLog(@"\nUser verified: Phone: %@; Email: %@; Terms: %@;", _user.verified.verifiedPhone?@"YES":@"NO", _user.verified.verifiedEmail?@"YES":@"NO", _user.verified.verifiedTerms?@"YES":@"NO");
	
	NSAssert(_user.defaultConnection!=nil, @"User doesn't have default connection!");
	
	BSDLog(@"\nDefault connection ID: %@", _user.defaultConnection.connectionID);
	BSDLog(@"\nDefault connection type: %@", _user.defaultConnection.type==BSConnectionTypeSMS?@"SMS":@"HLR");
	BSDLog(@"\nDefault connection users: %@", _user.defaultConnection.users);
	BSDLog(@"\nDefault connection wallet: %@", _user.defaultConnection.wallet);
	BSDLog(@"\nDefault connection label: %@", _user.defaultConnection.label);
	BSDLog(@"\nDefault connection description: %@", _user.defaultConnection.description);
	BSDLog(@"\nDefault connection system ID: %@", _user.defaultConnection.systemID);
	BSDLog(@"\nDefault connection API token: %@", _user.defaultConnection.apiToken);
	BSDLog(@"\nDefault connection customer: %@", _user.defaultConnection.customer);
	BSDLog(@"\nDefault connection Tag-Length-Value field for returning mcc and mnc in DLR: %@", _user.defaultConnection.TLVForMCCAndMNC);
	BSDLog(@"\nDefault connection callbacks: DLR: %@; MO: %@; Method: %@;", _user.defaultConnection.callbackURLs.DLR, _user.defaultConnection.callbackURLs.MO, _user.defaultConnection.callbackURLs.method);
}

- (void)testGettingConnectionData
{
	NSAssert(_connection!=nil, @"Connection object not created!");
	
	BSDLog(@"\nConnection ID: %@", _connection.connectionID);
	BSDLog(@"\nConnection type: %@", _connection.type==BSConnectionTypeSMS?@"SMS":@"HLR");
	BSDLog(@"\nConnection users: %@", _connection.users);
	BSDLog(@"\nConnection wallet: %@", _connection.wallet);
	BSDLog(@"\nConnection label: %@", _connection.label);
	BSDLog(@"\nConnection description: %@", _connection.description);
	BSDLog(@"\nConnection system ID: %@", _connection.systemID);
	BSDLog(@"\nConnection API token: %@", _connection.apiToken);
	BSDLog(@"\nConnection customer: %@", _connection.customer);
	BSDLog(@"\nConnection is default: %@", _connection.defaultConnection?@"YES":@"NO");
	BSDLog(@"\nConnection Tag-Length-Value field for returning mcc and mnc in DLR: %@", _connection.TLVForMCCAndMNC);
	BSDLog(@"\nConnection callbacks: DLR: %@; MO: %@; Method: %@;", _connection.callbackURLs.DLR, _connection.callbackURLs.MO, _connection.callbackURLs.method);
}

//[[BSTestSemaphor sharedInstance] lift:@"key"];
//[[BSTestSemaphor sharedInstance] waitForKey:@"key"];

- (void)testGetAllConnections
{
//	- (void)getAvailableConnectionsOnCompletion:(void(^)(NSArray *connections, NSArray *errors))block;
//	- (NSArray *)getAvailableConnections;
}

- (void)testGetCustomer
{
//	- (void)getCustomerDetailsOnCompletion:(void(^)(BSCustomer *customer, NSArray *errors))block;
}

- (void)testUpdateData
{
//	- (void)updateUserOnCompletion:(void(^)(NSArray *errors))block;
}

- (void)testUpdateUserEmail
{
//	- (void)updateUserEmailWithPassword:(NSString *)password onCompletion:(void(^)(NSArray *errors))block;
}

- (void)testUpdateUserPassword
{
//	- (void)changePassword:(NSString *)currentPassword withNewPassword:(NSString *)newPassword onCompletion:(void(^)(NSArray *errors))block;
}

- (void)testResetUserToken
{
//	- (void)resetUserTokenWithPassword:(NSString *)password onCompletion:(void(^)(NSArray *errors))block;
}
//testResetingUserPassword()

- (void)testGetAllWallets
{
//	- (void)getAvailableWalletsOnCompletion:(void(^)(NSArray *wallets, NSArray *errors))block;
//	- (NSArray *)getAvailableWallets;
}

- (void)testGetContacts
{
//	- (void)getAllContactsOnCompletion:(void(^)(NSArray *contacts, NSArray *errors))block;
//	- (NSArray *)getAllContacts;
}

- (void)testAddContacts
{
//	- (void)addMultipleContacts:(NSArray *)contacts onCompletion:(void(^)(NSArray *response, NSArray *errors))block;
}

- (void)testSearchContacts
{
//	- (void)searchContactsWithQuery:(NSString *)query inGroup:(BSGroup *)group limit:(NSNumber *)limit onCompletion:(void(^)(NSArray *results, NSArray *errors))block;
}

- (void)testGetAllGroups
{
//	- (void)getAllGroupsOnCompletion:(void(^)(NSArray *groups, NSArray *errors))block;
//	- (NSArray *)getAllGroups;
}

- (void)testGetContactsInGroup
{
//	- (void)getContactsInGroup:(BSGroup *)group onCompletion:(void(^)(NSArray *results, NSArray *errors))block;
}

- (void)testSearchGroups
{
//	- (void)searchGroupsWithQuery:(NSString *)query limit:(NSNumber *)limit onCompletion:(void(^)(NSArray *results, NSArray *errors))block;
}

- (void)testAnalyticSummary
{
//	- (void)getAnalyticsSummaryFromDate:(NSDate *)startDate toDate:(NSDate *)endDate withCompletionBlock:(void(^)(NSArray *statistics, NSArray *errors))block;
}

- (void)testNetworkDetails
{
//	- (void)getNetworkDetailsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate mccmnc:(BSMCCMNC *)mccmnc withCompletionBlock:(void(^)(NSArray *networkDetails, NSArray *errors))block;
}

-(void)testUpdateConnection
{
//	- (void)updateConnection;
}

- (void)testResetConnectionPassword
{
//	- (void)resetConnectionToken;
}

- (void)testGetCurrentPricelists
{
//	- (void)getCurrentPricelistOnCompletion:(void(^)(BSPricelist *pricelist))block;
}

- (void)testGetPricelists
{
//	- (void)getPricelistsOnCompletion:(void(^)(NSArray *pricelists))block;
}

- (void)testSendMessage
{
//	- (NSInteger)sendSMS:(BSMessage *)message withCompletionBlock:(void(^)(BSMessage *message, NSArray *errors))block;
//	- (NSInteger)smsCountForMessage:(BSMessage *)message;
}

- (void)testSendMessages
{
//	- (NSInteger)sendMultipleSMS:(NSArray *)messages withCompletionBlock:(void(^)(NSArray *messages, NSArray *errors))block;
//	- (NSInteger)smsCountForMessages:(NSArray *)messages;
}

- (void)testValidateMessage
{
//	- (void)validateSMS:(BSMessage *)message onCompletion:(void(^)(BSMessage *message, NSArray *errors))block;
}

- (void)getMessageDetails
{
//	- (void)getDetailsForSMS:(BSMessage *)message onCompletion:(void(^)(BSLookup *lookup, NSArray *errors))block;
//	- (void)getDetailsForMessagesSentTo:(NSString *)recipient sentFrom:(NSString *)sender usedBatch:(BSBatch *)batch beforeDate:(NSDate *)bDate afterDate:(NSDate *)aDate forNextPage:(BOOL)nextPage onCompletion:(void(^)(NSArray *lookups, NSArray *errors))block;
//	- (void)setLookupPageLimit:(NSNumber *)lookupPageLimit;
}

- (void)testGetBatchDetails
{
//	- (void)getDetailsForBatch:(BSBatch *)batch onCompletion:(void(^)(BSBatch *batch, NSArray *errors))block;
}

- (void)testGetBatches
{
//	- (void)getPreviousBatchesOnCompletion:(void(^)(NSArray *batches, NSArray *errors))block;
}

- (void)testEstimateMessageCost
{
//	- (void)estimateSMSCostForMessages:(NSArray *)messages onCompletion:(void(^)(NSArray *cost, NSArray *errors))block;
}

- (void)testImmediateHLR
{
//	- (void)immediateHLRForNumber:(NSString *)phoneNumber onCompletion:(void(^)(BSHLR *hlr, NSArray *errors))block;
}

- (void)testValidateHLR
{
//	- (void)validateHLRForNumber:(NSString *)phoneNumber onCompletion:(void(^)(BSHLR *hlr, NSArray *errors))black;
}

- (void)testConnectionAnalyticSummary
{
//	- (void)getAnalyticsSummaryFromDate:(NSDate *)startDate toDate:(NSDate *)endDate withCompletionBlock:(void(^)(NSArray *statistics, NSArray *errors))block;
}

- (void)testConnectionNetworkDetails
{
//	- (void)getNetworkDetailsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate mccmnc:(BSMCCMNC *)mccmnc withCompletionBlock:(void(^)(NSArray *networkDetails, NSArray *errors))block;
}

- (void)testGetDeliveryStatistics
{
//	- (void)getDeliveryStatisticsWithCompletionBlock:(void(^)(NSArray *statistics, NSArray *errors))block;
}

- (void)testUpdateWallet
{
//	- (void)updateWallet;
}

- (void)testGetTransactionLog
{
//	- (void)getTransactionLogForNextPage:(BOOL)nextPage onCompletion:(void(^)(NSArray *log))block;
//	- (void)setMaximumLogCount:(NSNumber *)logCount;
}

- (void)testTransferFunds
{
//	- (void)transferFunds:(NSNumber *)funds toWallet:(BSWallet *)wallet;
//	- (void)transferFunds:(NSNumber *)funds fromWallet:(BSWallet *)wallet;
}

- (void)testGetEmails
{
//	- (void)getEmailsOnCompletion:(void(^)(NSArray *emails))block;
}

- (void)testAddEmail
{
//	- (void)addEmail:(NSString *)email;
}

- (void)testRemoveEmail
{
//	- (void)removeEmail:(BSEmail *)email;
}

- (void)testSaveContact
{
	//	- (void)saveContact;
}

- (void)testUpdateContact
{
//	- (void)updateContact;
}

- (void)testRemoveContact
{
//	- (void)removeContact;
}

- (void)testSaveGroup
{
//	- (void)saveGroup;
}

- (void)testUpdateGroup
{
//	- (void)updateGroup;
}

- (void)testRemoveGroup
{
//	- (void)removeGroup;
}

- (void)testAddContactToGroup
{
//	- (void)addContact:(BSContact *)contact;
}

- (void)testAddContactsToGroup
{
//	- (void)addContacts:(NSArray *)contacts;
}

- (void)testRemoveContactFromGroup
{
//	- (void)removeContact:(BSContact *)contact;
}

- (void)testRemoveContactsFromGroup
{
//	- (void)removeContacts:(NSArray *)contacts;
}

@end
