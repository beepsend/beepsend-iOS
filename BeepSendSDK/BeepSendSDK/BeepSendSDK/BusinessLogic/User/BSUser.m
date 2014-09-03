//
//  BSUser.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSUser.h"

#import "BSUserService.h"
#import "BSConnectionsService.h"
#import "BSCustomerService.h"
#import "BSWalletService.h"
#import "BSContactsService.h"
#import "BSGroupsService.h"
#import "BSAnalyticsService.h"

#import "BSTestSemaphor.h"

#import "BSConnection.h"

#define kDefaultContactCount @200
#define kDefaultGroupCount @200

@interface BSUser ()

@property (nonatomic, strong, readwrite) NSString *userID;
@property (nonatomic, strong, readwrite) NSString *customerName;
@property (nonatomic, strong, readwrite) NSString *apiToken;
@property (nonatomic, strong, readwrite) NSNumber *maxLevel;
@property (nonatomic, strong, readwrite) NSString *password;
@property (nonatomic, strong, readwrite) NSString *theNewPassword;

@property (nonatomic, strong) BSUser *currentUser;

@property (nonatomic, strong) NSArray *connections;
@property (nonatomic, strong) NSArray *wallets;

@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) NSArray *groups;

@property (nonatomic, strong) NSNumber *contactPageLimit;
@property (nonatomic, strong) NSNumber *groupPageLimit;

@end

@implementation BSUser

#pragma mark - Properties


- (NSString *)userID
{
	return [BSHelper isNilOrEmpty:_userID] ? @"0" : [_userID isKindOfClass:[NSNumber class]] ? [(NSNumber *)_userID stringValue] : _userID;
}

- (NSString *)customerName
{
	return [BSHelper isNilOrEmpty:_customerName] ? @"" : _customerName;
}

- (NSString *)apiToken
{
	return [BSHelper isNilOrEmpty:_apiToken] ? @"" : _apiToken;
}

- (NSArray *)userTypes
{
	return _userTypes ? _userTypes : @[];
}

- (NSNumber *)maxLevel
{
	return _maxLevel ? _maxLevel : @0;
}

- (NSString *)name {
	return _name;
}

- (NSString *)phone {
	return _phone;
}

- (NSString *)email {
	return _email;
}

- (BSConnection *)defaultConnection {
	if (_defaultConnection) {
		return _defaultConnection;
	}
	return _defaultConnection = [BSConnection currentConnection];
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular user"]) {
		
	}
	return self;
}

- (BSUser *)initUserWithEmail:(NSString *)uEmail
				  andPassword:(NSString *)uPassword
{
	if (self = [super initWithID:@"0" andTitle:@"Update email user"]) {
		_userID = @"0";
		_email = uEmail;
		_password = uPassword;
	}
	return self;
}

- (BSUser *)initUserWithPassword:(NSString *)uPassword
				  andNewPassword:(NSString *)uNewPassword
{
	if (self = [super initWithID:@"0" andTitle:@"Update user password"]) {
		_userID = @"0";
		_password = uPassword;
		_theNewPassword = uNewPassword;
	}
	return self;
}

- (BSUser *)initWithName:(NSString *)uName
				   phone:(NSString *)uPhone
	   defaultConnection:(BSConnection *)uConnection
			   userTypes:(NSArray *)uTypes
				verified:(BSVerified *)uVerified
{
	if (self = [super initWithID:@"0" andTitle:uName]) {
		_userID = @"0";
		_name = uName;
		_phone = uPhone;
		_defaultConnection = uConnection;
		_userTypes = uTypes;
		_verified = uVerified;
	}
	return self;
}

- (BSUser *)initUserWithID:(NSString *)uID
					  name:(NSString *)uName
					 email:(NSString *)uEmail
					 phone:(NSString *)uPhone
				  customer:(NSString *)uCustomer
				  apiToken:(NSString *)uAPIToken
		 defaultConnection:(BSConnection *)uConnection
				 userTypes:(NSArray *)uUserTypes
				  maxLevel:(NSNumber *)uMaxLevel
				  verified:(BSVerified *)uVerified
{
	if (self = [super initWithID:uID andTitle:uName]) {
		_userID = uID;
		_name = uName;
		_email = uEmail;
		_phone = uPhone;
		_customerName = uCustomer;
		_apiToken = uAPIToken;
		_defaultConnection = uConnection;
		_userTypes = uUserTypes;
		_maxLevel = uMaxLevel;
		_verified = uVerified;
		
		_contactPageLimit = kDefaultContactCount;
		_groupPageLimit = kDefaultGroupCount;
	}
	return self;
}

- (BSUser *)initWithUserID:(NSString *)uID
{
	if (self = [super initWithID:@"0" andTitle:@"User"]) {
		_userID = uID;
		
		_contactPageLimit = kDefaultContactCount;
		_groupPageLimit = kDefaultGroupCount;
	}
	return self;
}

- (BSUser *)init
{
	if (self = [super initWithID:@"0" andTitle:@"User"]) {
		
		if (![[NSUserDefaults standardUserDefaults] objectForKey:@"API_TOKEN"]) {
			NSString *apiToken = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"BeepSendToken"];
			[[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"API_TOKEN" : apiToken }];
		}
		
		[[BSUserService sharedService] getUserDetailsWithCompletionBlock:^(BSUser *user, NSArray *errors) {
		
			if (!errors || errors.count == 0) {
			
				_currentUser = user;
			
				_name = user.name;
				_email = user.email;
				_phone = user.phone;
				
				_userID = user.userID;

				_customerName = user.customerName;
				_apiToken = user.apiToken;

				_userTypes = user.userTypes;
				_maxLevel = user.maxLevel;
				_verified = user.verified;
				
				_defaultConnection = [BSConnection currentConnection];
				
				_contactPageLimit = kDefaultContactCount;
				_groupPageLimit = kDefaultGroupCount;
			}
		}];
	}
	return self;
}

+ (BSUser *)currentUser
{
	static BSUser *singleton;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		singleton = [[BSUser alloc] init];
	});
	return singleton;
}

#pragma mark - Public methods

- (void)updateUserOnCompletion:(void(^)(NSArray *errors))block
{
	if (!_currentUser) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"User can't be edited", @"")];
		block(@[error]);
		
		return; //User object can not be edited
	}
	
	if ([_name isEqualToString:_currentUser.name] &&
		[_phone isEqualToString:_currentUser.phone] &&
		[_defaultConnection.connectionID isEqualToString:_currentUser.defaultConnection.objectID] &&
		[_userTypes isEqualToArray:_currentUser.userTypes] &&
		_verified.isVerifiedTerms==_currentUser.verified.isVerifiedTerms) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"No changes were made", @"")];
		block(@[error]);
		
		return; //No changes were made
	}
	
	[[BSUserService sharedService] updateUserWithName:[_name isEqualToString:_currentUser.name]?nil:_name
												phone:[_phone isEqualToString:_currentUser.phone]?nil:_phone
									defaultConnection:[_defaultConnection.connectionID isEqualToString:_currentUser.defaultConnection.objectID]?nil:_defaultConnection
											userTypes:[_userTypes isEqualToArray:_currentUser.userTypes]?nil:_userTypes
										verifiedTerms:_verified.isVerifiedTerms==_currentUser.verified.isVerifiedTerms?nil:_verified.termsVerified
								  withCompletionBlock:^(BSUser *user, NSArray *errors) {
									  
									  if (errors && errors.count>0) {
										  block(errors);
									  }
									  else {

										  _name = user.name;
										  _phone = user.phone;
										  
										  _defaultConnection = user.defaultConnection;
										  
										  _userTypes = user.userTypes;
										  
										  _verified.termsVerified = user.verified.termsVerified;
										  
										  _currentUser = user;
										  
										  block(nil);
									  }
	}];
}

- (void)updateUserEmailWithPassword:(NSString *)password onCompletion:(void(^)(NSArray *errors))block
{
	if ([BSHelper isNilOrEmpty:password]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Missing password", @"")];
		block(@[error]);
		
		return;//Missing password
	}
	
	if (_password) {
		if (![_password isEqualToString:password]) {
			
			BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Invalid password", @"")];
			block(@[error]);
			
			return;//Invalid password
		}
	}
	
	if (![_email isEqualToString:_currentUser.email]) {
		[[BSUserService sharedService] updateUserEmail:_email userPassword:password withCompletionBlock:^(BOOL success, NSArray *errors) {
			if (success) {
				_currentUser.email = _email;
				_password = password;
				
				block(nil);
			}
			else {
				block(errors);
			}
		}];
	}
	else {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"No changes were made", @"")];
		block(@[error]);
		
		return;//Email needs to be updated first
	}
}

- (void)changePassword:(NSString *)currentPassword withNewPassword:(NSString *)newPassword onCompletion:(void(^)(NSArray *errors))block
{
	if ([BSHelper isNilOrEmpty:currentPassword] || [BSHelper isNilOrEmpty:newPassword]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Missing password", @"")];
		block(@[error]);
		
		return; //Missing password
	}
	
	if ([currentPassword isEqualToString:newPassword]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Passwords don't match", @"")];
		block(@[error]);
		
		return; //Passwords don't match
	}
	
	if (_password) {
		
		if (![_password isEqualToString:currentPassword]) {
			
			BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Invalid password", @"")];
			block(@[error]);
			
			return; //Invalid password
		}
	}
	
	[[BSUserService sharedService] updateUserPassword:_password userNewPassword:_theNewPassword withCompletionBlock:^(BOOL success, NSArray *errors) {
		if (success) {
			
			_password = _theNewPassword;
			_theNewPassword = nil;
			
			block(nil);
		}
		else {
			block(errors);
		}
	}];
}

- (void)resetUserTokenWithPassword:(NSString *)password onCompletion:(void(^)(NSArray *errors))block
{
	if ([BSHelper isNilOrEmpty:password]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Missing password", @"")];
		block(@[error]);
		
		return;//Missing password
	}
	
	if (_password) {
		
		if (![_password isEqualToString:password]) {
			
			BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Invalid password", @"")];
			block(@[error]);
			
			return; //Invalid password
		}
	}
	
	[[BSUserService sharedService] resetUserTokenUsingPassword:password withCompletionBlock:^(NSString *apiToken, NSArray *errors) {
		
		if (errors && errors.count>0) {
			block(errors);
		}
		else {
			[[NSUserDefaults standardUserDefaults] setObject:apiToken forKey:@"API_TOKEN"];
			[[NSUserDefaults standardUserDefaults] synchronize];
			
			_apiToken = apiToken;
			_password = password;
			
			block(nil);
		}
	}];
}

- (void)resetUserPasswordOnCompletion:(void(^)(BOOL success, NSArray *errors))block
{
	[[BSUserService sharedService] resetUserPasswordForEmail:_email withCompletionBlock:^(BOOL success, NSArray *errors) {
		if (success) {
			
			_password = nil;
			
			block(YES, nil);
		}
		else {
			block(NO, errors);
		}
	}];
}

- (void)getAvailableConnectionsOnCompletion:(void(^)(NSArray *connections, NSArray *errors))block
{
	[[BSConnectionsService sharedService] getAllAvailableConnectsionOnCompletion:^(NSArray *connections, NSArray *errors) {
	
		if (errors && errors.count > 0) {
			_connections = nil;
			
			block(@[], nil);
		}
		else {
			_connections = connections;
			
			block(_connections, nil);
		}
	}];
}

- (NSArray *)getAvailableConnections
{
	if (_connections) {
		return _connections;
	}
	else {
		[[BSConnectionsService sharedService] getAllAvailableConnectsionOnCompletion:^(NSArray *connections, NSArray *errors) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchConnections"];
			
			if (errors && errors.count>0) {
				_connections = nil;
			}
			else {
				_connections = connections;
			}
			
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchConnections"];
		
		return _connections;
	}
}

- (void)getCustomerDetailsOnCompletion:(void(^)(BSCustomer *customer, NSArray *errors))block
{
	if (_customer) {
		block(_customer, nil);
		
		return;
	}
	
	[[BSCustomerService sharedService] getCustomerOnCompletion:^(BSCustomer *customer, NSArray *errors) {
		
		if (!_customer) {
			block(customer, errors);
		}
		
		_customer = customer;
	}];
}

- (void)getAvailableWalletsOnCompletion:(void(^)(NSArray *wallets, NSArray *errors))block
{
	[[BSWalletService sharedService] getAllWalletsWithCompletionBlock:^(NSArray *wallets, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			_wallets = nil;
			
			block(@[], nil);
		}
		else {
			_wallets = wallets;
			
			block(_wallets, nil);
		}
	}];
}

- (NSArray *)getAvailableWallets
{
	if (_wallets) {
		return _wallets;
	}
	else {
		[[BSWalletService sharedService] getAllWalletsWithCompletionBlock:^(NSArray *wallets, NSArray *errors) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchWallets"];
			
			if (errors && errors.count>0) {
				_wallets = nil;
			}
			else {
				_wallets = wallets;
			}
			
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchWallets"];
		
		return _wallets;
	}
}

- (void)getWalletDetailsForID:(NSString *)walletID onCompletion:(void(^)(BSWallet *wallet, NSArray *errors))block
{
	if ([BSHelper isNilOrEmpty:walletID]) {
	
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"You must specify wallet ID", @"")];
		block(nil, @[error]);
	
		return;
	}
	
	[[BSWalletService sharedService] getWalletDetailsForID:walletID withCompletionBlock:^(BSWallet *wallet, NSArray *errors) {
		
		if (errors && errors.count>0) {
			block(nil, errors);
		}
		else {
			block(wallet, nil);
		}
		
	}];
	
}

- (void)getAllContactsfromGroup:(BSGroup *)group sorted:(NSString *)sort forNextPage:(BOOL)nextPage onCompletion:(void(^)(NSArray *contacts, NSArray *errors))block
{
	NSString *maxID = nil;
	if (_contacts) {
		maxID = [_contacts lastObject] ? [[_contacts lastObject] objectID] : nil;
	}
	
	if (!nextPage) {
		_contacts = @[];
	}
	
	[[BSContactsService sharedService] getAllContactsInGroup:group.groupID
													 sinceID:nil
													   maxID:nextPage ? maxID : nil
												contactCount:_contactPageLimit
													  offset:nil
														sort:sort
										 withCompletionBlock:^(NSArray *contacts, NSArray *errors) {
											 
											 if (errors && errors.count > 0) {
												 
												 block(nil, errors);
											 }
											 else {
												 
												 NSMutableArray *mArr = [NSMutableArray arrayWithArray:_contacts];
												 if (!errors || errors.count==0) {
													 [mArr removeLastObject];
													 _contacts = [mArr arrayByAddingObjectsFromArray:contacts];
												 }
												 
												 block(_contacts, nil);
											 }
										 }];
}

- (void)setContactCount:(NSNumber *)cCount
{
	if ([cCount integerValue] > 200) {
		_contactPageLimit = @200;
	}
	
	if ([cCount integerValue] < 1) {
		_contactPageLimit = @1;
	}
	
	_contactPageLimit = cCount;
}

- (NSArray *)getAllContacts
{
	if (_contacts) {
		return _contacts;
	}
	else {
		[[BSContactsService sharedService] getAllContactsWithCompletionBlock:^(NSArray *contacts, NSArray *errors) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchContacts"];
			
			if (errors && errors.count>0) {
				_contacts = nil;
			}
			else {
				_contacts = contacts;
			}
			
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchContacts"];
		
		return _contacts;
	}
}

- (void)addMultipleContacts:(NSArray *)contacts onCompletion:(void(^)(NSArray *response, NSArray *errors))block
{
	if (!contacts || contacts.count < 1) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"No contacts to add", @"")];
		block(nil, @[error]);
	
		return;
	}
	
	BOOL nonContactObjectFound = NO;
	for (id object in contacts) {
		if (![object isKindOfClass:[BSContact class]]) {
			nonContactObjectFound = YES;
		}
	}
	if (nonContactObjectFound) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Only contact objects can be added", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSContactsService sharedService] addContacts:contacts withCompletionBlock:^(NSArray *cts, NSArray *errors) {
		
		if (errors && errors.count>0) {
			block(nil, errors);
		}
		else {
			block(cts, nil);
		}
	}];
}

- (void)searchContactsWithQuery:(NSString *)query inGroup:(BSGroup *)group limit:(NSNumber *)limit onCompletion:(void(^)(NSArray *results, NSArray *errors))block
{
	if ([limit integerValue] < 1) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Limit must be positive number", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	if ([BSHelper isNilOrEmpty:query]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Enter query for search", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSContactsService sharedService] searchContact:query inGroup:group limit:limit.integerValue withCompletionBlock:^(NSArray *results, NSArray *errors) {
		
		if (errors && errors.count>0) {
			block(nil, errors);
		}
		else {
			block(results, nil);
		}
	}];
}

- (void)getAllGroupsForNextPage:(BOOL)nextPage onCompletion:(void(^)(NSArray *groups, NSArray *errors))block
{
	NSString *maxID = nil;
	if (_groups) {
		maxID = [_groups lastObject] ? [[_groups lastObject] objectID] : nil;
	}
	
	if (!nextPage) {
		_groups = @[];
	}
	
	[[BSGroupsService sharedService] getAllGroupsSinceID:nil
												   maxID:nextPage ? maxID : nil
												   count:_groupPageLimit
									 withCompletionBlock:^(NSArray *groups, NSArray *errors) {
										 
										 if (errors && errors.count > 0) {
											 block(nil, errors);
										 }
										 else {
											 NSMutableArray *mArr = [NSMutableArray arrayWithArray:_groups];
											 if (!errors || errors.count==0) {
												 [mArr removeLastObject];
												 _groups = [mArr arrayByAddingObjectsFromArray:groups];
											 }
											 
											 block(_groups, nil);
										 }
									 }];
}

- (void)setGroupCount:(NSNumber *)gCount
{
	if ([gCount integerValue] > 200) {
		_groupPageLimit = @200;
	}
	
	if ([gCount integerValue] < 1) {
		_groupPageLimit = @1;
	}
	
	_groupPageLimit = gCount;
}

- (NSArray *)getAllGroups
{
	if (_groups) {
		return _groups;
	}
	else {
		[[BSGroupsService sharedService] getAllGroupsWithCompletionBlock:^(NSArray *groups, NSArray *errors) {
			[[BSTestSemaphor sharedInstance] lift:@"FetchGroups"];
			
			if (errors && errors.count>0) {
				_groups = nil;
			}
			else {
				_groups = groups;
			}
			
		}];
		[[BSTestSemaphor sharedInstance] waitForKey:@"FetchGroups"];
		
		return _groups;
	}
}

- (void)getGroupDetails:(NSString *)groupID onCompletion:(void(^)(BSGroup *group, NSArray *errors))block
{
	if ([BSHelper isNilOrEmpty:groupID]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Must specify group ID", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSGroupsService sharedService] getDetailsForGroupID:groupID withCompletionBlock:^(BSGroup *group, NSArray *errors) {
		
		if (errors && errors.count>0) {
			block(nil, errors);
		}
		else {
			block(group, nil);
		}
		
	}];
}

- (void)searchGroupsWithQuery:(NSString *)query limit:(NSNumber *)limit onCompletion:(void(^)(NSArray *results, NSArray *errors))block
{
	if ([limit integerValue] < 1) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Limit must be positive number", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	if ([BSHelper isNilOrEmpty:query]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Enter query for search", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSGroupsService sharedService] searchContactGroups:query limit:limit.integerValue withCompletionBlock:^(NSArray *results, NSArray *errors) {
		
		if (errors && errors.count>0) {
			block(nil, errors);
		}
		else {
			block(results, nil);
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
	
	[[BSAnalyticsService sharedService] getAnalyticsSummaryFromDate:startDate toDate:endDate usingConnection:nil withCompletionBlock:^(NSArray *statistics, NSArray *errors) {
		
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
	
	[[BSAnalyticsService sharedService] getNetworkDetailsFromDate:startDate toDate:endDate mccmnc:mccmnc usingConnection:nil withCompletionBlock:^(NSArray *networkDetails, NSArray *errors) {
		
		if (errors && errors.count>0) {
			block(nil, errors);
		}
		else {
			block(networkDetails, nil);
		}
	}];
}

- (void)getRecipientNumbersOnCompletion:(void(^)(NSArray *numbers, NSArray *errors))block
{
	[[BSConnectionsService sharedService] getRecipientNumbersOnCompletion:^(NSArray *recipientNumbers, NSArray *errors) {
		
		if (errors && errors.count>0) {
			block(nil, errors);
		}
		else {
			block(recipientNumbers, nil);
		}
		
	}];
}

@end
