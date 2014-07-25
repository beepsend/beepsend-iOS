//
//  BSWalletModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/4/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSWallet.h"

#import "BSWalletService.h"
#import "BSEmail.h"

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
	return _currentWallet ? _currentWallet.name : _name;
}

- (NSNumber *)minimumBalanceForNotification {
	return _currentWallet ? _currentWallet.minimumBalanceForNotification : _minimumBalanceForNotification;
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

- (void)updateWallet
{
	if (!_currentWallet) {
		return;
	}
	
	[[BSWalletService sharedService] updateWallet:self
										 withName:![_currentWallet.name isEqualToString:_name]?_name:nil
									  notifyLimit:![_currentWallet.minimumBalanceForNotification isEqualToNumber:_minimumBalanceForNotification]?_minimumBalanceForNotification:nil
							  withCompletionBlock:^(BSWallet *wallet, NSArray *errors) {
								  
								  _currentWallet = wallet;
								  
								  _name = _currentWallet.name;
								  _minimumBalanceForNotification = _currentWallet.minimumBalanceForNotification;
								  
							  }];
}

- (void)getTransactionLogForNextPage:(BOOL)nextPage onCompletion:(void(^)(NSArray *log))block
{
	NSString *maxID = nil;
	if (_log) {
		maxID = [_log lastObject] ? [[_log lastObject] logID] : nil;
	}
	
	if (!nextPage) {
		_log = @[];
	}
	
	[[BSWalletService sharedService] getTransactionLogForWallet:self since:nil max:nextPage ? maxID : nil count:nextPage ? [NSNumber numberWithInteger:([_count integerValue]+1)] : _count withCompletionBlock:^(NSArray *log, NSArray *errors) {
		
		NSMutableArray *mArr = [NSMutableArray arrayWithArray:_log];
		[mArr removeLastObject];
		_log = [mArr arrayByAddingObjectsFromArray:log];
		
		block(_log);
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

- (void)transferFunds:(NSNumber *)funds toWallet:(BSWallet *)wallet
{
	[[BSWalletService sharedService] transferFunds:funds fromWallet:self toWallet:wallet withCompletionBlock:^(BSTransfer *transfer, NSArray *errors) {
		
	}];
}

- (void)transferFunds:(NSNumber *)funds fromWallet:(BSWallet *)wallet
{
	[[BSWalletService sharedService] transferFunds:funds fromWallet:wallet toWallet:self withCompletionBlock:^(BSTransfer *transfer, NSArray *errors) {
		
	}];
}

- (void)getEmailsOnCompletion:(void(^)(NSArray *emails))block
{
	[[BSWalletService sharedService] getEmailsForWallet:self withCompletionBlock:^(NSArray *emails, NSArray *errors) {
		block(emails);
	}];
}

- (void)addEmail:(NSString *)email
{
	[[BSWalletService sharedService] addEmail:email toWallet:self withCompletionBlock:^(BSEmail *email, NSArray *errors) {
		
	}];
}

- (void)removeEmail:(BSEmail *)email
{
	[[BSWalletService sharedService] deleteEmailInWallet:self email:email withCompletionBlock:^(BOOL success, NSArray *errors) {
		
	}];
}

@end
