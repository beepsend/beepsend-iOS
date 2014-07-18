//
//  BSConnection.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSConnection.h"

#import "BSInputData.h"

#import "BSTestSemaphor.h"

#import "BSConnectionsService.h"
#import "BSPricelistService.h"
#import "BSSMSService.h"
#import "BSHLRService.h"

#import "BSPricelist.h"
#import "BSCallbacks.h"
#import "BSBatch.h"
#import "BSEstimateCost.h"
#import "BSHLR.h"
#import "BSLookup.h"
#import "BSUser.h"
#import "BSMessage.h"

#define kDefaultMessageCountForLookup @100

@interface BSConnection ()

@property (nonatomic, strong) BSConnection *connectionModel;

@property (nonatomic, strong) BSPricelist *currentPricelist;
@property (nonatomic, strong) NSArray *pricelists;

@property (nonatomic, strong) NSArray *lookups;
@property (nonatomic, strong) NSNumber *lookupPageLimit;

@end

@implementation BSConnection

#pragma mark - Properties

- (NSString *)label {
	return _connectionModel ? _connectionModel.label : _label;
}

- (NSString *)description {
	return _connectionModel ? _connectionModel.description : _description;
}

- (NSString *)systemID {
	return _connectionModel ? _connectionModel.systemID : _systemID;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular connection"]) {
		_connectionID = @"-1";
	}
	return self;
}

- (BSConnection *)initConnectionWithID:(NSString *)cID
{
	if (self = [super initWithID:cID andTitle:@"Connection"]) {
		_connectionID = cID;
		_lookupPageLimit = kDefaultMessageCountForLookup;
	}
	return self;
}

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
								   password:(NSString *)password
{
	if (self = [super initWithID:cID andTitle:cLabel]) {
		_connectionID = cID;
		_apiToken = cAPIToken;
		_callbackURLs = cCallbacks;
		_customer = cCustomer;
		_description = cDescription;
		_label = cLabel;
		_systemID = cSystemID;
		_TLVForMCCAndMNC = cTlvformccandmnc;
		_type = cType;
		_users = cUsers;
		_wallet = cWallet;
		_whitelist = cWhitelist;
		_password = password;
		_lookupPageLimit = kDefaultMessageCountForLookup;
	}
	return self;
}

- (BSConnection *)initWithConnectionModel:(BSConnection *)connectionModel withNewToken:(NSString *)newToken
{
	if (self = [super initWithID:connectionModel.objectID andTitle:connectionModel.label]) {
		_connectionID = connectionModel.objectID;
		_apiToken = newToken;
		_callbackURLs = connectionModel.callbackURLs;
		_customer = connectionModel.customer;
		_description = connectionModel.description;
		_label = connectionModel.label;
		_systemID = connectionModel.systemID;
		_TLVForMCCAndMNC = connectionModel.TLVForMCCAndMNC;
		_type = connectionModel.type;
		_users = connectionModel.users;
		_wallet = connectionModel.wallet;
		_whitelist = connectionModel.whitelist;
		_password = connectionModel.password;
		_lookupPageLimit = kDefaultMessageCountForLookup;
	}
	return self;
}

- (BSConnection *)initWithConnectionModel:(BSConnection *)connectionModel withNewPassword:(NSString *)newPassword
{
	if (self = [super initWithID:connectionModel.objectID andTitle:connectionModel.label]) {
		_connectionID = connectionModel.objectID;
		_apiToken = connectionModel.apiToken;
		_callbackURLs = connectionModel.callbackURLs;
		_customer = connectionModel.customer;
		_description = connectionModel.description;
		_label = connectionModel.label;
		_systemID = connectionModel.systemID;
		_TLVForMCCAndMNC = connectionModel.TLVForMCCAndMNC;
		_type = connectionModel.type;
		_users = connectionModel.users;
		_wallet = connectionModel.wallet;
		_whitelist = connectionModel.whitelist;
		_password = newPassword;
		_lookupPageLimit = kDefaultMessageCountForLookup;
	}
	return self;
}

- (BSConnection *)initConnectionWithID:(NSString *)cID
									  label:(NSString *)cLabel
								   systemID:(NSString *)cSystemID
									   type:(BSConnectionType)cType
{
	if (self = [super initWithID:cID andTitle:cLabel]) {
		_connectionID = cID;
		_label = cLabel;
		_systemID = cSystemID;
		_type = cType;
		_lookupPageLimit = kDefaultMessageCountForLookup;
		
	}
	return self;
}

- (BSConnection *)init
{
	if (self = [super initWithID:@"0" andTitle:@"Connection"]) {
		
		[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"API_TOKEN" : APIToken }];
		
		[[BSConnectionsService sharedService] getMeConnectionOnCompletion:^(BSConnection *connection, id error) {
//			[[BSTestSemaphor sharedInstance] lift:@"FetchConnection"];
			
			_connectionModel = connection;
			
			_connectionID = connection.objectID;
			_type = connection.type;
			_label = connection.label;
			_description = connection.description;
			_systemID = connection.systemID;
			
			_users = connection.users;
			
			_wallet = connection.wallet;
			_apiToken = connection.apiToken;
			_callbackURLs = connection.callbackURLs;
			_customer = connection.customer;
			_TLVForMCCAndMNC = connection.TLVForMCCAndMNC;
			_whitelist = connection.whitelist;
			_password = connection.password;
			_lookupPageLimit = kDefaultMessageCountForLookup;
		}];
//		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchConnection"];
	}
	return self;
}

+ (BSConnection *)currentConnection
{
	static BSConnection *singleton;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		singleton = [[BSConnection alloc] init];
	});
	return singleton;
}

#pragma mark - Public methods

//After made changes it is necessary to call method updateConnection
- (void)updateConnection
{
	if (!_connectionModel) {
		return; //Connection object can't be edited
	}
	
	if ([_callbackURLs.DLR isEqualToString:_connectionModel.callbackURLs.DLR] &&
		[_callbackURLs.MO isEqualToString:_connectionModel.callbackURLs.MO] &&
		[_callbackURLs.method isEqualToString:_connectionModel.callbackURLs.method] &&
		[_systemID isEqualToString:_connectionModel.systemID] &&
		[_label isEqualToString:_connectionModel.label] &&
		[_description isEqualToString:_connectionModel.description]) {
		
		return; //No changes were made
	}
	
	[[BSConnectionsService sharedService] updateConnection:self
										   withCallbackDLR:[_callbackURLs.DLR isEqualToString:_connectionModel.callbackURLs.DLR] ? nil : _callbackURLs.DLR
												callbackMO:[_callbackURLs.MO isEqualToString:_connectionModel.callbackURLs.MO] ? nil : _callbackURLs.MO
											callbackMethod:[_callbackURLs.method isEqualToString:_connectionModel.callbackURLs.method] ? nil : _callbackURLs.method
												  systemID:[_systemID isEqualToString:_connectionModel.systemID] ? nil : _systemID
													 label:[_label isEqualToString:_connectionModel.label] ? nil : _label
											   description:[_description isEqualToString:_connectionModel.description] ? nil : _description
									   withCompletionBlock:^(BSConnection *connection, id error) {
	
										   _connectionModel = connection;
										   
										   _callbackURLs.DLR = connection.callbackURLs.DLR;
										   _callbackURLs.MO = connection.callbackURLs.MO;
										   _callbackURLs.method = connection.callbackURLs.method;
										   
										   _systemID = connection.systemID;
										   _label = connection.label;
										   _description = connection.description;
										   
									   }];
}

//If API token is compromised use this method for token reset
- (void)resetConnectionToken
{
	[[BSConnectionsService sharedService] resetTokenForConnection:_connectionModel withCompletionBlock:^(BSConnection *updatedModel, id error) {
		
		if (!error) {
			//If previously saved API token is equal to connection token
			//then overwrite it. Otherwise saved token is User token.
			if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"API_TOKEN"] isEqualToString:_connectionModel.apiToken]) {
				[[NSUserDefaults standardUserDefaults] setObject:updatedModel.apiToken forKey:@"API_TOKEN"];
			}
			
			_connectionModel = updatedModel;
			_apiToken = updatedModel.apiToken;
		}
	}];
}

//Returns pricelists
- (void)getPricelistsOnCompletion:(void(^)(NSArray *pricelists))block
{
	if (_pricelists) {
		block(_pricelists);
	}
	
	[[BSPricelistService sharedService] getPricelistsForConnection:_connectionModel withCompletionBlock:^(NSArray *pricelists, id error) {
		
		if (!_pricelists) {
			block(pricelists);
		}
		_pricelists = pricelists;
		
	}];
}

//Returns current pricelists
- (void)getCurrentPricelistOnCompletion:(void(^)(BSPricelist *pricelist))block
{
	if (_currentPricelist) {
		block(_currentPricelist);
	}
	
	[[BSPricelistService sharedService] getCurrentPricelistsForConnection:_connectionModel withCompletionBlock:^(BSPricelist *pricelist, id error) {
		
		if (!_currentPricelist) {
			block(pricelist);
		}
		_currentPricelist = pricelist;
		
	}];
}

//Send message
- (NSInteger)sendSMS:(BSMessage *)message withCompletionBlock:(void(^)(BSMessage *message, id error))block
{
	if (_type != BSConnectionTypeSMS) {
		return 0; //This connection can't send SMS
	}
	
	__block BSMessage *msg = message;
	[[BSSMSService sharedService] sendMessage:message usingConnection:_connectionModel withCompletionBlock:^(NSArray *response, id error) {
		
		if (response.count > 0) {
			block([[BSMessage alloc] initMessageWithID:[response[0] messageID] andErrors:[response[0] errors] forMessage:msg], error);
		}
		else {
			block(nil, error);
		}
	}];
	
	return [self smsCountForMessage:message];
}

//Send messages
- (NSInteger)sendMultipleSMS:(NSArray *)messages withCompletionBlock:(void(^)(NSArray *messages, id error))block
{
	if (_type != BSConnectionTypeSMS) {
		return 0; //This connection can't send SMS
	}
	
	__block NSArray *msgs = messages;
	[[BSSMSService sharedService] sendMessages:messages usingConnection:_connectionModel withCompletionBlock:^(NSArray *array, id error) {
		
		if (array.count > 0) {
			NSMutableArray *mArr = [@[] mutableCopy];
			for (BSMessage *m in array) {
				[mArr addObject:[[BSMessage alloc] initMessageWithID:m.messageID andErrors:m.errors forMessage:msgs[[array indexOfObject:m]]]];
			}
			block([NSArray arrayWithArray:msgs], error);
		}
		else {
			block(nil, error);
		}
	}];
	
	return [self smsCountForMessages:messages];
}

- (NSInteger)smsCountForMessage:(BSMessage *)message
{
	BOOL isUTF8 = is_utf8([message.message cStringUsingEncoding:NSUTF16BigEndianStringEncoding]);
	return message.message.length<=(isUTF8?160:70) ? 1 : message.message.length/(isUTF8?153:66);
}

- (NSInteger)smsCountForMessages:(NSArray *)messages
{
	NSInteger messageCount = 0;
	for (BSMessage *m in messages) {
		messageCount += [self smsCountForMessage:m];
	}
	
	return messageCount;
}

//Validate SMS
- (void)validateSMS:(BSMessage *)message onCompletion:(void(^)(BSMessage *message, id error))block
{
	if (_type != BSConnectionTypeSMS) {
		return; //This connection can't send SMS
	}
	
	[[BSSMSService sharedService] validateSMSForMessage:message withCompletionBlock:^(BSMessage *message, id error) {
		
		block(message, error);
	}];
}

//Get sms details
- (void)getDetailsForSMS:(BSMessage *)message onCompletion:(void(^)(BSLookup *lookup, id error))block
{
	if (_type != BSConnectionTypeSMS) {
		return; //This connection can't send SMS
	}
	
	[[BSSMSService sharedService] lookupSMS:message withCompletionBlock:^(BSLookup *lookupResponse, id error) {
		
		block(lookupResponse, error);
	}];
}

- (void)getDetailsForMessagesSentTo:(NSString *)recipient sentFrom:(NSString *)sender usedBatch:(BSBatch *)batch beforeDate:(NSDate *)bDate afterDate:(NSDate *)aDate forNextPage:(BOOL)nextPage onCompletion:(void(^)(NSArray *lookups, id error))block
{
	NSString *maxID = nil;
	if (_lookups) {
		maxID = [_lookups lastObject] ? [[_lookups lastObject] objectID] : nil;
	}
	
	if (!nextPage) {
		_lookups = @[];
	}
	
	[[BSSMSService sharedService] lookupMultipleSMSSentTo:recipient
												 setnFrom:sender
										  usingConnection:self
													batch:batch
												  sinceID:nil
													maxID:nextPage ? maxID : nil
												afterDate:aDate
											   beforeDate:bDate
													count:nextPage ? [NSNumber numberWithInteger:(_lookupPageLimit.integerValue+1)] : _lookupPageLimit
									  withCompletionBlock:^(NSArray *lookupResponse, id error) {
										  
										  
										  NSMutableArray *mArr = [NSMutableArray arrayWithArray:_lookups];
										  if (!error) {
											  [mArr removeLastObject];
											  _lookups = [mArr arrayByAddingObjectsFromArray:lookupResponse];
										  }
										  
										  block(_lookups, error);
	}];
}

- (void)setLookupPageLimit:(NSNumber *)lookupPageLimit
{
	if ([lookupPageLimit integerValue] > 200) {
		_lookupPageLimit = @200;
	}
	
	if ([lookupPageLimit integerValue] < 1) {
		_lookupPageLimit = @1;
	}
	
	_lookupPageLimit = lookupPageLimit;
}

//Get batch details
- (void)getDetailsForBatch:(BSBatch *)batch onCompletion:(void(^)(BSBatch *batch, id error))block
{
	[[BSSMSService sharedService] getDetailsForBatch:batch.batchID withCompletionBlock:^(BSBatch *batch, id error) {
		
		block(batch, error);
	}];
}

//Get previous batches
- (void)getPreviousBatchesOnCompletion:(void(^)(NSArray *batches, id error))block
{
	[[BSSMSService sharedService] getPreviousBatchesWithCompletionBlock:^(NSArray *bathces, id error) {
		
		block(bathces, error);
	}];
}

//Estimates message cost (not necessarily accurate)
- (void)estimateSMSCostForMessages:(NSArray *)messages onCompletion:(void(^)(NSArray *cost, id error))block
{
	[[BSSMSService sharedService] estimateCostForMessages:messages usingConnection:self withCompletionBlock:^(NSArray *response, id error) {
		
		block(response, error);
	}];
}

//Do immediate HLR for given number
- (void)immediateHLRForNumber:(NSString *)phoneNumber onCompletion:(void(^)(BSHLR *hlr, id error))block
{
	if (_type != BSConnectionTypeHLR) {
		return; //This connection can't send HLR
	}
	
	[[BSHLRService sharedService] doImmediateHLRForNumber:phoneNumber withConnection:self withCompletionBlock:^(BSHLR *hlr, id error) {
		
		block(hlr, error);
	}];
}

//Validate HLR for phone number
- (void)validateHLRForNumber:(NSString *)phoneNumber onCompletion:(void(^)(BSHLR *hlr, id error))black
{
	if (_type != BSConnectionTypeHLR) {
		return; //This connection can't send HLR
	}
	
	[[BSHLRService sharedService] validateHLRForNumber:phoneNumber withConnection:self withCompletionBlock:^(id response, id error) {
		
		
	}];
}

@end
