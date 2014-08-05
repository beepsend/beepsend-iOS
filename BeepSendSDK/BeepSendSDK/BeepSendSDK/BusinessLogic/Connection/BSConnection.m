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
#import "BSAnalyticsService.h"

#import "BSMessage.h"
#import "BSWallet.h"
#import "BSUser.h"

#define kDefaultMessageCountForLookup @100

@interface BSConnection ()

@property (nonatomic, strong, readwrite) NSString *connectionID;
@property (nonatomic, strong, readwrite) NSArray *users;
@property (nonatomic, strong, readwrite) NSString *apiToken;
@property (nonatomic, strong, readwrite) NSString *customer;
@property (nonatomic, strong, readwrite) NSNumber *TLVForMCCAndMNC;
@property (nonatomic, strong, readwrite) NSArray *whitelist;



@property (nonatomic, strong) BSConnection *connectionModel;

@property (nonatomic, strong) BSPricelist *currentPricelist;
@property (nonatomic, strong) NSArray *pricelists;

@property (nonatomic, strong) NSArray *lookups;
@property (nonatomic, strong) NSNumber *lookupPageLimit;

@end

@implementation BSConnection

#pragma mark - Properties

- (NSString *)connectionID
{
	return [BSHelper isNilOrEmpty:_connectionID] ? @"0" : [_connectionID isKindOfClass:[NSNumber class]] ? [(NSNumber *)_connectionID stringValue] : _connectionID;
}

- (NSArray *)users
{
	return _users ? _users : @[];
}

- (NSString *)apiToken
{
	return [BSHelper isNilOrEmpty:_apiToken] ? @"" : _apiToken;
}

- (NSString *)customer
{
	return [BSHelper isNilOrEmpty:_customer] ? @"" : _customer;
}

- (NSNumber *)TLVForMCCAndMNC
{
	return _TLVForMCCAndMNC ? _TLVForMCCAndMNC : @0;
}

- (NSArray *)whitelist
{
	return _whitelist ? _whitelist : @[];
}

- (NSString *)label {
	return _label;
}

- (NSString *)description {
	return _description;
}

- (NSString *)systemID {
	return _systemID;
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

- (BSConnection *)init
{
	if (self = [super initWithID:@"0" andTitle:@"Connection"]) {
		
		[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"API_TOKEN" : APIToken }];
		
		[[BSConnectionsService sharedService] getMeConnectionOnCompletion:^(BSConnection *connection, NSArray *errors) {
			
			if (!errors || errors.count == 0) {
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
			}
		}];
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
- (void)updateConnectionOnCompletion:(void(^)(NSArray *errors))block
{
	if ([_callbackURLs.DLR isEqualToString:_connectionModel.callbackURLs.DLR] &&
		[_callbackURLs.MO isEqualToString:_connectionModel.callbackURLs.MO] &&
		[_callbackURLs.method isEqualToString:_connectionModel.callbackURLs.method] &&
		[_systemID isEqualToString:_connectionModel.systemID] &&
		[_label isEqualToString:_connectionModel.label] &&
		[_description isEqualToString:_connectionModel.description]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"No changes were made!", @"")];
		block(@[error]);
		
		return; //No changes were made
	}
	
	[[BSConnectionsService sharedService] updateConnection:self
										   withCallbackDLR:[_callbackURLs.DLR isEqualToString:_connectionModel.callbackURLs.DLR] ? nil : _callbackURLs.DLR
												callbackMO:[_callbackURLs.MO isEqualToString:_connectionModel.callbackURLs.MO] ? nil : _callbackURLs.MO
											callbackMethod:[_callbackURLs.method isEqualToString:_connectionModel.callbackURLs.method] ? nil : _callbackURLs.method
												  systemID:[_systemID isEqualToString:_connectionModel.systemID] ? nil : _systemID
													 label:[_label isEqualToString:_connectionModel.label] ? nil : _label
											   description:[_description isEqualToString:_connectionModel.description] ? nil : _description
									   withCompletionBlock:^(BSConnection *connection, NSArray *errors) {
	
										   if (errors && errors.count>0) {
											   block(errors);
										   }
										   else {
											   
											   _callbackURLs.DLR = connection.callbackURLs.DLR;
											   _callbackURLs.MO = connection.callbackURLs.MO;
											   _callbackURLs.method = connection.callbackURLs.method;
											   
											   _systemID = connection.systemID;
											   _label = connection.label;
											   _description = connection.description;
											   
											   _connectionModel = connection;
											   
											   block(nil);
										   }
									   }];
}

//If API token is compromised use this method for token reset
- (void)resetConnectionTokenOnCompletion:(void(^)(NSArray *errors))block
{
	[[BSConnectionsService sharedService] resetTokenForConnection:_connectionModel withCompletionBlock:^(BSConnection *updatedModel, NSArray *errors) {
		
		if (!errors || errors.count == 0) {
			//If previously saved API token is equal to connection token
			//then overwrite it. Otherwise saved token is User token.
			if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"API_TOKEN"] isEqualToString:_connectionModel.apiToken]) {
				[[NSUserDefaults standardUserDefaults] setObject:updatedModel.apiToken forKey:@"API_TOKEN"];
			}
			
			_connectionModel = updatedModel;
			_apiToken = updatedModel.apiToken;
			
			block(nil);
		}
		else {
			block(errors);
		}
	}];
}

//Returns pricelists
- (void)getPricelistsOnCompletion:(void(^)(NSArray *pricelists, NSArray *errors))block
{
	if (_pricelists) {
		block(_pricelists, nil);
	}
	
	[[BSPricelistService sharedService] getPricelistsForConnection:_connectionModel withCompletionBlock:^(NSArray *pricelists, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
		
			if (!_pricelists) {
				block(pricelists, nil);
			}
			_pricelists = pricelists;
		}
	}];
}

//Returns current pricelists
- (void)getCurrentPricelistOnCompletion:(void(^)(BSPricelist *pricelist, NSArray *errors))block
{
	if (_currentPricelist) {
		block(_currentPricelist, nil);
	}
	
	[[BSPricelistService sharedService] getCurrentPricelistsForConnection:_connectionModel withCompletionBlock:^(BSPricelist *pricelist, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
			if (!_currentPricelist) {
				block(pricelist, nil);
			}
			_currentPricelist = pricelist;
		}
	}];
}

//Send message
- (NSInteger)sendSMS:(BSMessage *)message withCompletionBlock:(void(^)(BSMessage *message, NSArray *errors))block
{
	if (_type != BSConnectionTypeSMS) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Connection can't send sms messages!", @"")];
		block(nil, @[error]);
		
		return 0; //This connection can't send SMS
	}
	
	if (!message) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message must be specified!", @"")];
		block(nil, @[error]);
		
		return 0;
	}
	
	if ([BSHelper isNilOrEmpty:message.message]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message body can't be empty!", @"")];
		block(nil, @[error]);
		
		return 0;
	}
	
	if ([BSHelper isNilOrEmpty:message.recipient] || message.recipients.count==0 || message.groups.count==0) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message recipient must be specified!", @"")];
		block(nil, @[error]);
		
		return 0;
	}
	
	if ([BSHelper isNilOrEmpty:message.sender]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message sender must be specified!", @"")];
		block(nil, @[error]);
		
		return 0;
	}
	
	__block BSMessage *msg = message;
	[[BSSMSService sharedService] sendMessage:message usingConnection:_connectionModel withCompletionBlock:^(BSMessage *mesage, NSArray *errors) {
		
		if (!errors || errors.count == 0) {
			block([[BSMessage alloc] initMessageWithID:[message messageID] andErrors:[message errors] forMessage:msg], nil);
		}
		else {
			block(nil, errors);
		}
	}];
	
	return [self smsCountForMessage:message];
}

//Send messages
- (NSInteger)sendMultipleSMS:(NSArray *)messages withCompletionBlock:(void(^)(NSArray *messages, NSArray *errors))block
{
	if (_type != BSConnectionTypeSMS) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Connection can't send sms messages!", @"")];
		block(nil, @[error]);
		
		return 0; //This connection can't send SMS
	}
	
	BOOL nonMessageObject = NO;
	for (id object in messages) {
		if ([object isKindOfClass:[BSMessage class]]) {
			
			if ([BSHelper isNilOrEmpty:[(BSMessage *)object message]]) {
				
				BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message body can't be empty!", @"")];
				block(nil, @[error]);
				
				return 0;
			}
			
			if ([BSHelper isNilOrEmpty:[(BSMessage *)object recipient]] ||
				 [[(BSMessage *)object recipients] count]==0 ||
				 [[(BSMessage *)object  groups] count]==0) {
				
				BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message recipient must be specified!", @"")];
				block(nil, @[error]);
				
				return 0;
			}
			
			if ([BSHelper isNilOrEmpty:[(BSMessage *)object sender]]) {
				
				BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message sender must be specified!", @"")];
				block(nil, @[error]);
				
				return 0;
			}
		}
		else {
			nonMessageObject = YES;
			break;
		}
	}
	if (nonMessageObject) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Only message objects can be sent!", @"")];
		block(nil, @[error]);
		
		return 0;
	}
	
	__block NSArray *msgs = messages;
	[[BSSMSService sharedService] sendMessages:messages usingConnection:_connectionModel withCompletionBlock:^(NSArray *array, NSArray *errors) {
		
		if (array.count > 0) {
			NSMutableArray *mArr = [@[] mutableCopy];
			NSMutableArray *err = [@[] mutableCopy];
			for (BSMessage *m in array) {
				[mArr addObject:[[BSMessage alloc] initMessageWithID:m.messageID andErrors:m.errors forMessage:msgs[[array indexOfObject:m]]]];
				[err addObjectsFromArray:m.errors];
			}
			block([NSArray arrayWithArray:msgs], err.count>0 ? [NSArray arrayWithArray:err] : nil);
		}
		else {
			block(nil, errors);
		}
	}];
	
	return [self smsCountForMessages:messages];
}

- (NSInteger)smsCountForMessage:(BSMessage *)message
{
	BOOL isUTF8;
	
#ifdef TARGET_IPHONE_SIMULATOR 
	isUTF8 = YES;
#else
	isUTF8 = is_utf8([message.message cStringUsingEncoding:NSUTF16BigEndianStringEncoding]);
#endif
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
- (void)validateSMS:(BSMessage *)message onCompletion:(void(^)(BSMessage *message, NSArray *errors))block
{
	if (_type != BSConnectionTypeSMS) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Connection can't send sms messages!", @"")];
		block(nil, @[error]);
		
		return; //This connection can't send SMS
	}
	
	if (!message) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message must be specified!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	if ([BSHelper isNilOrEmpty:message.message]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message body can't be empty!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	if ([BSHelper isNilOrEmpty:message.recipient] && message.recipients.count==0 && message.groups.count==0) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message recipient must be specified!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	if ([BSHelper isNilOrEmpty:message.sender]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message sender must be specified!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSSMSService sharedService] validateSMSForMessage:message withCompletionBlock:^(BSMessage *message, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
			block(message, nil);
		}
	}];
}

//Get sms details
- (void)getDetailsForSMS:(BSMessage *)message onCompletion:(void(^)(BSLookup *lookup, NSArray *errors))block
{
	if (_type != BSConnectionTypeSMS) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Connection can't send sms messages!", @"")];
		block(nil, @[error]);
		
		return; //This connection can't send SMS
	}
	
	if ([BSHelper isNilOrEmpty:message.messageID]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message ID missing!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSSMSService sharedService] lookupSMS:message withCompletionBlock:^(BSLookup *lookupResponse, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
			block(lookupResponse, nil);
		}
		
	}];
}

- (void)getDetailsForMessagesSentTo:(NSString *)recipient sentFrom:(NSString *)sender usedBatch:(BSBatch *)batch beforeDate:(NSDate *)bDate afterDate:(NSDate *)aDate forNextPage:(BOOL)nextPage onCompletion:(void(^)(NSArray *lookups, NSArray *errors))block
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
									  withCompletionBlock:^(NSArray *lookupResponse, NSArray *errors) {
										  
										  if (errors && errors.count > 0) {
											  block(nil, errors);
										  }
										  else {
											  NSMutableArray *mArr = [NSMutableArray arrayWithArray:_lookups];
											  if (!errors || errors.count==0) {
												  [mArr removeLastObject];
												  _lookups = [mArr arrayByAddingObjectsFromArray:lookupResponse];
											  }
											  
											  block(_lookups, nil);
										  }
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
- (void)getDetailsForBatch:(BSBatch *)batch onCompletion:(void(^)(BSBatch *batch, NSArray *errors))block
{
	if (!batch || [BSHelper isNilOrEmpty:batch.batchID]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Batch missing!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSSMSService sharedService] getDetailsForBatch:batch.batchID withCompletionBlock:^(BSBatch *batch, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
			block(batch, nil);
		}
	}];
}

//Get previous batches
- (void)getPreviousBatchesOnCompletion:(void(^)(NSArray *batches, NSArray *errors))block
{
	[[BSSMSService sharedService] getPreviousBatchesWithCompletionBlock:^(NSArray *bathces, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
			block(bathces, nil);
		}
	}];
}

//Estimates message cost (not necessarily accurate)
- (void)estimateSMSCostForMessages:(NSArray *)messages onCompletion:(void(^)(NSArray *cost, NSArray *errors))block
{
	if (_type != BSConnectionTypeSMS) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Connection can't send sms messages!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	BOOL nonMessageObject = NO;
	for (id object in messages) {
		if ([object isKindOfClass:[BSMessage class]]) {
			
			if ([BSHelper isNilOrEmpty:[(BSMessage *)object message]]) {
				
				BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message body can't be empty!", @"")];
				block(nil, @[error]);
				
				return;
			}
			
			if ([BSHelper isNilOrEmpty:[(BSMessage *)object recipient]] ||
				[[(BSMessage *)object recipients] count]==0 ||
				[[(BSMessage *)object  groups] count]==0) {
				
				BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message recipient must be specified!", @"")];
				block(nil, @[error]);
				
				return;
			}
			
			if ([BSHelper isNilOrEmpty:[(BSMessage *)object sender]]) {
				
				BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Message sender must be specified!", @"")];
				block(nil, @[error]);
				
				return;
			}
		}
		else {
			nonMessageObject = YES;
			break;
		}
	}
	if (nonMessageObject) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Only message objects can be sent!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSSMSService sharedService] estimateCostForMessages:messages usingConnection:self withCompletionBlock:^(NSArray *response, NSArray *errors) {
		
		if (errors && errors.count>0) {
			block(nil, errors);
		}
		else {
			block(response, nil);
		}
	}];
}

//Do immediate HLR for given number
- (void)immediateHLRForNumber:(NSString *)phoneNumber onCompletion:(void(^)(BSHLR *hlr, NSArray *errors))block
{
	if (_type != BSConnectionTypeHLR) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Connection can't send HLR request!", @"")];
		block(nil, @[error]);
		
		return; //This connection can't send HLR
	}
	
	if ([BSHelper isNilOrEmpty:phoneNumber]) {
	
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Phone number must be specified!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSHLRService sharedService] doImmediateHLRForNumber:phoneNumber withConnection:self withCompletionBlock:^(BSHLR *hlr, NSArray *errors) {
		
		if (errors && errors.count>0) {
			block(nil, errors);
		}
		else {
			block(hlr, nil);
		}
	}];
}

//Validate HLR for phone number
- (void)validateHLRForNumber:(NSString *)phoneNumber onCompletion:(void(^)(BSHLR *hlr, NSArray *errors))block
{
	if (_type != BSConnectionTypeHLR) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Connection can't send HLR request!", @"")];
		block(nil, @[error]);
		
		return; //This connection can't send HLR
	}
	
	if ([BSHelper isNilOrEmpty:phoneNumber]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Phone number must be specified!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSHLRService sharedService] validateHLRForNumber:phoneNumber withConnection:self withCompletionBlock:^(BSHLR *response, NSArray *errors) {
		
		if (errors && errors.count>0) {
			block(nil, errors);
		}
		else {
			block(response, nil);
		}
	}];
}

- (void)getAnalyticsSummaryFromDate:(NSDate *)startDate toDate:(NSDate *)endDate withCompletionBlock:(void(^)(NSArray *statistics, NSArray *errors))block
{
	if ((startDate!=nil && endDate!=nil) && [[startDate laterDate:endDate] isEqualToDate:startDate]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Start date must be before end date", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSAnalyticsService sharedService] getAnalyticsSummaryFromDate:startDate toDate:endDate usingConnection:self withCompletionBlock:^(NSArray *statistics, NSArray *errors) {
		
		if (errors && errors.count>0) {
			block(nil, errors);
		}
		else {
			block(statistics, nil);
		}
		
	}];
}

- (void)getNetworkDetailsFromDate:(NSDate *)startDate toDate:(NSDate *)endDate mccmnc:(BSMCCMNC *)mccmnc withCompletionBlock:(void(^)(NSArray *networkDetails, NSArray *errors))block
{
	if ((startDate!=nil && endDate!=nil) && [[startDate laterDate:endDate] isEqualToDate:startDate]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Start date must be before end date", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSAnalyticsService sharedService] getNetworkDetailsFromDate:startDate toDate:endDate mccmnc:mccmnc usingConnection:self withCompletionBlock:^(NSArray *networkDetails, NSArray *errors) {
		
		if (errors && errors.count>0) {
			block(nil, errors);
		}
		else {
			block(networkDetails, nil);
		}
	}];
}

@end
