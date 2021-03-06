//
//  BSWalletModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSWallet.h"

#import "BSWalletService.h"

#define kDefaultCount @100

@interface BSWallet ()

@property (nonatomic, strong, readwrite) NSString *walletID;
@property (nonatomic, strong, readwrite) NSNumber *balance;
@property (nonatomic, strong, readwrite) NSArray *connections;
@property (nonatomic, strong, readwrite) NSArray *users;

@property (nonatomic, strong) BSWallet *currentWallet;

@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSArray *log;

@end

@implementation BSWallet

#pragma mark - Properties

- (NSString *)walletID
{
	return [BSHelper isNilOrEmpty:_walletID] ? @"0" : [_walletID isKindOfClass:[NSNumber class]] ? [(NSNumber *)_walletID stringValue] : _walletID;
}

- (NSNumber *)balance
{
	return _balance ? _balance : @0;
}

- (NSArray *)connections
{
	return _connections ? _connections : @[];
}

- (NSArray *)users
{
	return _users ? _users : @[];
}

- (NSString *)name {
	return _name;
}

- (NSNumber *)minimumBalanceForNotification {
	return  _minimumBalanceForNotification;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular wallet"]) {
		_walletID = @"-1";
	}
	return self;
}

- (BSWallet *)initWalletWithID:(NSString *)wID
						 named:(NSString *)wName
					   balance:(NSNumber *)wBalance
				minimumBalance:(NSNumber *)wMinBalance
				   connections:(NSArray *)wConnections
						 users:(NSArray *)wUsers
{
	if (self = [super initWithID:wID andTitle:wName]) {
		_walletID = wID;
		_name = wName;
		_balance = wBalance;
		_minimumBalanceForNotification = wMinBalance;
		_connections = wConnections;
		_users = wUsers;
		_count = kDefaultCount;
	}
	return self;
}

- (BSWallet *)initWalletWithID:(NSString *)wID
						  name:(NSString *)wName
					   balance:(NSNumber *)wBalance
{
	if (self = [super initWithID:wID andTitle:wName]) {
		_walletID = wID;
		_name = wName;
		_balance = wBalance;
		_count = kDefaultCount;
	}
	return self;
}

- (BSWallet *)initWalletWithName:(NSString *)wName
						   limit:(NSNumber *)wLimit
{
	if (self = [super initWithID:@"0" andTitle:wName]) {
		_walletID = @"0";
		_name = wName;
		_minimumBalanceForNotification = wLimit;
		_count = kDefaultCount;
	}
	return self;
}

#pragma mark - Public methods

- (void)updateWalletOnCompletion:(void (^)(BSWallet *, NSArray *))block
{
	[[BSWalletService sharedService] updateWallet:self
										 withName:![_currentWallet.name isEqualToString:_name]?_name:nil
									  notifyLimit:![_currentWallet.minimumBalanceForNotification isEqualToNumber:_minimumBalanceForNotification]?_minimumBalanceForNotification:nil
							  withCompletionBlock:^(BSWallet *wallet, NSArray *errors) {
								  
								  if (errors && errors.count > 0) {
									  block(nil, errors);
								  }
								  else {
									  _currentWallet = wallet;
									  
									  _name = _currentWallet.name;
									  _minimumBalanceForNotification = _currentWallet.minimumBalanceForNotification;
									  
									  block(_currentWallet, nil);
								  }
							  }];
}

- (void)getTransactionLogForNextPage:(BOOL)nextPage onCompletion:(void(^)(NSArray *log, NSArray *errors))block
{
	NSString *maxID = nil;
	if (_log) {
		maxID = [_log lastObject] ? [[_log lastObject] logID] : nil;
	}
	
	if (!nextPage) {
		_log = @[];
	}
	
	[[BSWalletService sharedService] getTransactionLogForWallet:self since:nil max:nextPage ? maxID : nil count:nextPage ? [NSNumber numberWithInteger:([_count integerValue]+1)] : _count withCompletionBlock:^(NSArray *log, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
			NSMutableArray *mArr = [NSMutableArray arrayWithArray:_log];
			[mArr removeLastObject];
			_log = [mArr arrayByAddingObjectsFromArray:log];
			
			block(_log, nil);
		}
	}];
}

- (void)setMaximumLogCount:(NSNumber *)logCount
{
	if ([logCount integerValue] > 200) {
		_count = @200;
	}
	
	if ([logCount integerValue] < 1) {
		_count = @1;
	}
	
	_count = logCount;
}

- (void)transferFunds:(NSNumber *)funds toWallet:(BSWallet *)wallet onCompletion:(void (^)(BSTransfer *, NSArray *))block
{
	if (!wallet || [BSHelper isNilOrEmpty:wallet.walletID]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Target wallet missing!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	if ([funds doubleValue] <= 0.0) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Funds for transfer must be grater than 0.0!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSWalletService sharedService] transferFunds:funds fromWallet:self toWallet:wallet withCompletionBlock:^(BSTransfer *transfer, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
			block(transfer, nil);
		}
	}];
}

- (void)transferFunds:(NSNumber *)funds fromWallet:(BSWallet *)wallet onCompletion:(void (^)(BSTransfer *, NSArray *))block
{
	if (!wallet || [BSHelper isNilOrEmpty:wallet.walletID]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Source wallet missing!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	if ([funds doubleValue] <= 0.0) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Funds for transfer must be grater than 0.0!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSWalletService sharedService] transferFunds:funds fromWallet:wallet toWallet:self withCompletionBlock:^(BSTransfer *transfer, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
			block(transfer, nil);
		}
	}];
}

- (void)getEmailsOnCompletion:(void(^)(NSArray *emails, NSArray *errors))block
{
	[[BSWalletService sharedService] getEmailsForWallet:self withCompletionBlock:^(NSArray *emails, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
			block(emails, nil);
		}
	}];
}

- (void)getEmailWithID:(NSString *)emailID onCompletion:(void(^)(BSEmail *email, NSArray *errors))block
{
	[[BSWalletService sharedService] getEmailForWallet:self andEmailID:emailID withCompletionBlock:^(BSEmail *email, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
			block(email, nil);
		}
		
	}];
}

- (void)addEmail:(NSString *)email onCompletion:(void (^)(BSEmail *email, NSArray *errors))block
{
	if ([BSHelper isNilOrEmpty:email]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Enter email address!", @"")];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSWalletService sharedService] addEmail:email toWallet:self withCompletionBlock:^(BSEmail *email, NSArray *errors) {
		
		if (errors && errors.count > 0) {
			block(nil, errors);
		}
		else {
			block(email, nil);
		}
	}];
}

- (void)removeEmail:(BSEmail *)email onCompletion:(void (^)(BOOL success, NSArray *errors))block
{
	if (!email || [BSHelper isNilOrEmpty:email.emailID]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:NSLocalizedString(@"Enter valid email!", @"")];
		block(NO, @[error]);
		
		return;
	}
	
	[[BSWalletService sharedService] deleteEmailInWallet:self email:email withCompletionBlock:^(BOOL success, NSArray *errors) {
		if (errors && errors.count > 0) {
			block(NO, errors);
		}
		else {
			block(YES, nil);
		}
	}];
}

@end
