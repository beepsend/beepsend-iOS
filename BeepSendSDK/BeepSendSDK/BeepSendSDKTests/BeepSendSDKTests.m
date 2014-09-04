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
@property (nonatomic, strong) BSWallet *wallet1;
@property (nonatomic, strong) BSWallet *wallet2;

@property (nonatomic, strong) BSContact *contact;
@property (nonatomic, strong) BSGroup *group;

@end

@implementation BeepSendSDKTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
	
	_user = [BSUser currentUser];
	_connection = [BSConnection currentConnection];
	
	NSArray *wallets = [_user getAvailableWallets];
	_wallet1 = wallets[0];
	_wallet2 = wallets[1];
	
	_contact = [[BSContact alloc] initContactWithID:@"123" firstName:@"First" lastName:@"Last" phoneNumber:@"123456789000" group:nil errors:nil];
	[_contact saveContactOnCompletion:^(BSContact *contact, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"contactsave"];
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"contactsave"];
	
	_group = [[BSGroup alloc] initGroupWithID:@"1234" name:@"Group name" contacts:@0];
	[_group saveGroupOnCompletion:^(BSGroup *group, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"groupsave"];
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"groupsave"];
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

- (void)testGetAllConnections
{
	[_user getAvailableConnectionsOnCompletion:^(NSArray *connections, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetAllConnections"];
		
		NSAssert(connections!=nil, @"Connections not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSConnection *connection in connections) {
				
				BSDLog(@"\nConnection ID: %@", connection.connectionID);
				BSDLog(@"\nConnection type: %@", connection.type==BSConnectionTypeSMS?@"SMS":@"HLR");
				BSDLog(@"\nConnection users: %@", connection.users);
				BSDLog(@"\nConnection wallet: %@", connection.wallet);
				BSDLog(@"\nConnection label: %@", connection.label);
				BSDLog(@"\nConnection description: %@", connection.description);
				BSDLog(@"\nConnection system ID: %@", connection.systemID);
				BSDLog(@"\nConnection API token: %@", connection.apiToken);
				BSDLog(@"\nConnection customer: %@", connection.customer);
				BSDLog(@"\nConnection is default: %@", connection.defaultConnection?@"YES":@"NO");
				BSDLog(@"\nConnection Tag-Length-Value field for returning mcc and mnc in DLR: %@", connection.TLVForMCCAndMNC);
				BSDLog(@"\nConnection callbacks: DLR: %@; MO: %@; Method: %@;", connection.callbackURLs.DLR, connection.callbackURLs.MO, connection.callbackURLs.method);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
			
				BSDLog(@"\n------------------------\n");
			}
		}
		
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetAllConnections"];

}

- (void)testGetCustomer
{
	[_user getCustomerDetailsOnCompletion:^(BSCustomer *customer, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetCustomer"];
		
		NSAssert(customer!=nil, @"Customer not fetched!");
		
		if (!errors || errors.count == 0) {

			BSDLog(@"\nCustomer ID: %@", customer.customerID);
			BSDLog(@"\nCustomer name: %@", customer.name);
			BSDLog(@"\nCustomer phone: %@", customer.phoneNumber);
			BSDLog(@"\nCustomer address: %@", customer.address);
			BSDLog(@"\nCustomer city: %@", customer.city);
			BSDLog(@"\nCustomer post box: %@", customer.postBox);
			BSDLog(@"\nCustomer country: %@", customer.country);
			BSDLog(@"\nCustomer vat: %@", customer.vat);
			BSDLog(@"\nCustomer email: %@", customer.email);
			BSDLog(@"\nCustomer type: %@", customer.type);
			BSDLog(@"\nCustomer Account manager: Name: %@; Email: %@;", customer.accountManager.name, customer.accountManager.email);
			BSDLog(@"\nCustomer price list details: Type: %@; Delimiter: %@, Fields: %@", customer.priceListDetails.type, customer.priceListDetails.delimiter, customer.priceListDetails.fields);
			
			BSDLog(@"\n------------------------\n");
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetCustomer"];

}

- (void)testUpdateData
{
	_user.name = @"New name";
	_user.phone = @"123456789";
	
	[_user updateUserOnCompletion:^(NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testUpdateData"];
		
		if (!errors || errors.count == 0) {
			
			BSDLog(@"\nUser name: %@", _user.name);
			BSDLog(@"\nUser phone: %@", _user.phone);
			
			BSDLog(@"\n------------------------\n");
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testUpdateData"];
}

- (void)testUpdateUserEmail
{
	_user.email = @"newemail@mail.com";
	
	[_user updateUserEmailWithPassword:@"password" onCompletion:^(NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testUpdateUserEmail"];
		
		if (!errors || errors.count == 0) {
			
			BSDLog(@"\nUser email: %@", _user.email);
			
			BSDLog(@"\n------------------------\n");
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testUpdateUserEmail"];
}

- (void)testUpdateUserPassword
{
	[_user changePassword:@"password" withNewPassword:@"newpassword" onCompletion:^(NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testUpdateUserPassword"];
		
		if (!errors || errors.count == 0) {
			
			BSDLog(@"\nUser password: %@", _user.password);
			
			BSDLog(@"\n------------------------\n");
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testUpdateUserPassword"];
}

- (void)testResetUserToken
{
	[_user resetUserTokenWithPassword:@"newpassword" onCompletion:^(NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testResetUserToken"];
		
		if (!errors || errors.count == 0) {
			
			BSDLog(@"\nUser API token: %@", _user.apiToken);
			
			BSDLog(@"\n------------------------\n");
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testResetUserToken"];
}

- (void)testGetAllWallets
{
	[_user getAvailableWalletsOnCompletion:^(NSArray *wallets, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetAllWallets"];
		
		NSAssert(wallets!=nil, @"Wallets not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSWallet *wallet in wallets) {

				BSDLog(@"\nWallet ID: %@", wallet.walletID);
				BSDLog(@"\nWallet name: %@", wallet.name);
				BSDLog(@"\nWallet balance: %@", wallet.balance);
				BSDLog(@"\nWallet minimum balance: %@", wallet.minimumBalanceForNotification);
				BSDLog(@"\nWallet users: %@", wallet.users);
				BSDLog(@"\nWallet connections: %@", wallet.connections);
				
				BSDLog(@"\n------------------------\n");
			}
			
			if (wallets.count >= 2) {
				_wallet1 = wallets[0];
				_wallet2 = wallets[1];
			}
			else if (wallets.count == 1) {
				_wallet1 = wallets[0];
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetAllWallets"];
}

- (void)testGetContacts
{
	[_user getAllContactsfromGroup:nil sorted:nil forNextPage:NO onCompletion:^(NSArray *contacts, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetContacts"];
		
		NSAssert(contacts!=nil, @"Contacts not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSContact *contact in contacts) {
				
				if (contact.errors && contact.errors.count > 0) {
					
					for (BSError *error in contact.errors) {
						
						BSDLog(@"%@ - %@", [error code], [error errorDescription]);
						
						BSDLog(@"\n------------------------\n");
					}
				}
				else {
					BSDLog(@"\nContact ID: %@", contact.contactID);
					BSDLog(@"\nContact first name: %@", contact.firstName);
					BSDLog(@"\nContact last name: %@", contact.lastName);
					BSDLog(@"\nContact phone number: %@", contact.phoneNumber);
					BSDLog(@"\nContact group: %@", contact.group.name);
					
					BSDLog(@"\n------------------------\n");
				}
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetContacts"];
}

- (void)testAddContacts
{
	BSContact *c1 = [[BSContact alloc] initContactWithPhoneNumber:@"111111" firstName:@"C1" lastName:@"C1" group:nil];
	BSContact *c2 = [[BSContact alloc] initContactWithPhoneNumber:@"222222" firstName:@"C2" lastName:@"C2" group:nil];
	BSContact *c3 = [[BSContact alloc] initContactWithPhoneNumber:@"333333" firstName:@"C3" lastName:@"C3" group:nil];
	
	[_user addMultipleContacts:@[c1, c2, c3] onCompletion:^(NSArray *response, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testAddContacts"];
		
		NSAssert(response!=nil, @"Contacts not added!");
		
		if (!errors || errors.count == 0) {
			
			for (BSContact *contact in response) {
				
				if (contact.errors && contact.errors.count > 0) {
					
					for (BSError *error in contact.errors) {
						
						BSDLog(@"%@ - %@", [error code], [error errorDescription]);
						
						BSDLog(@"\n------------------------\n");
					}
				}
				else {
					BSDLog(@"\nContact ID: %@", contact.contactID);
					BSDLog(@"\nContact first name: %@", contact.firstName);
					BSDLog(@"\nContact last name: %@", contact.lastName);
					BSDLog(@"\nContact phone number: %@", contact.phoneNumber);
					BSDLog(@"\nContact group: %@", contact.group.name);
					
					BSDLog(@"\n------------------------\n");
				}
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testAddContacts"];
}

- (void)testSearchContacts
{
	[_user searchContactsWithQuery:@"some" inGroup:nil limit:@100 onCompletion:^(NSArray *results, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testSearchContacts"];
		
		NSAssert(results!=nil, @"Contacts not found!");
		
		if (!errors || errors.count == 0) {
			
			for (BSContact *contact in results) {
				
				if (contact.errors && contact.errors.count > 0) {
					
					for (BSError *error in contact.errors) {
						
						BSDLog(@"%@ - %@", [error code], [error errorDescription]);
						
						BSDLog(@"\n------------------------\n");
					}
				}
				else {
					BSDLog(@"\nContact ID: %@", contact.contactID);
					BSDLog(@"\nContact first name: %@", contact.firstName);
					BSDLog(@"\nContact last name: %@", contact.lastName);
					BSDLog(@"\nContact phone number: %@", contact.phoneNumber);
					BSDLog(@"\nContact group: %@", contact.group.name);
					
					BSDLog(@"\n------------------------\n");
				}
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testSearchContacts"];
}

- (void)testGetAllGroups
{
	[_user getAllGroupsForNextPage:NO onCompletion:^(NSArray *groups, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetAllGroups"];
		
		NSAssert(groups!=nil, @"Groups not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSGroup *group in groups) {
				
				BSDLog(@"\nGroup ID: %@", group.groupID);
				BSDLog(@"\nGroup name: %@", group.name);
				BSDLog(@"\nGroup contacts count: %@", group.contactsCount);
				BSDLog(@"\nGroup processing: %@", group.processing);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetAllGroups"];
}

- (void)testGetContactsInGroup
{
	[_user getAllGroupsForNextPage:NO onCompletion:^(NSArray *groups, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetContactsInGroupGROUP"];
		
		NSAssert(groups!=nil, @"Groups not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSGroup *group in groups) {
				
				[_user getAllContactsfromGroup:group sorted:nil forNextPage:NO onCompletion:^(NSArray *contacts, NSArray *errors) {
					[[BSTestSemaphor sharedInstance] lift:@"testGetContactsInGroup"];
					
					NSAssert(contacts!=nil, @"Contacts not fetched!");
					
					if (!errors || errors.count == 0) {
						
						for (BSContact *contact in contacts) {
							
							if (contact.errors && contact.errors.count > 0) {
								
								for (BSError *error in contact.errors) {
									
									BSDLog(@"%@ - %@", [error code], [error errorDescription]);
									
									BSDLog(@"\n------------------------\n");
								}
							}
							else {
								BSDLog(@"\nContact ID: %@", contact.contactID);
								BSDLog(@"\nContact first name: %@", contact.firstName);
								BSDLog(@"\nContact last name: %@", contact.lastName);
								BSDLog(@"\nContact phone number: %@", contact.phoneNumber);
								BSDLog(@"\nContact group: %@", contact.group.name);
								
								BSDLog(@"\n------------------------\n");
							}
						}
					}
					else {
						
						for (BSError *error in errors) {
							
							BSDLog(@"%@ - %@", [error code], [error errorDescription]);
							
							BSDLog(@"\n------------------------\n");
						}
					}
				}];
				[[BSTestSemaphor sharedInstance] waitForKey:@"testGetContactsInGroup"];
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetContactsInGroupGROUP"];
}

- (void)testSearchGroups
{
	[_user searchGroupsWithQuery:@"group" limit:@100 onCompletion:^(NSArray *results, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testSearchGroups"];
		
		NSAssert(results!=nil, @"Groups not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSGroup *group in results) {
				
				BSDLog(@"\nGroup ID: %@", group.groupID);
				BSDLog(@"\nGroup name: %@", group.name);
				BSDLog(@"\nGroup contacts count: %@", group.contactsCount);
				BSDLog(@"\nGroup processing: %@", group.processing);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testSearchGroups"];
}

- (void)testAnalyticSummary
{
	[_user getAnalyticsSummaryFromDate:[NSDate date] toDate:[NSDate date] withCompletionBlock:^(NSArray *statistics, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testAnalyticSummary"];
		
		NSAssert(statistics!=nil, @"Statistic not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSAccumulatedStatistics *acStat in statistics) {
				
				BSDLog(@"\nAccumulated statistics account: %@", acStat.account);
				BSDLog(@"\nAccumulated statistics count: %@", acStat.count);
				BSDLog(@"\nAccumulated statistics price: %@", acStat.price);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testAnalyticSummary"];
}

- (void)testNetworkDetails
{
	[_user getNetworkDetailsFromDate:[NSDate date] toDate:[NSDate date] mccmnc:nil withCompletionBlock:^(NSArray *networkDetails, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testNetworkDetails"];
		
		NSAssert(networkDetails!=nil, @"Network details not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSNetworkDetails *nDetails in networkDetails) {
				
				BSDLog(@"\nNetwork details MCC MNC: MCC: %@; MNC: %@;", nDetails.mccmnc.mcc, nDetails.mccmnc.mnc);
				BSDLog(@"\nNetwork details statistic: Delivered: %@; Incoming: %@; Expired: %@; FailedNoError: %@; Rejected: %@; Failed: %@; InProcess: %@;", nDetails.statistics.deliveredMessages, nDetails.statistics.incomingMessagesFromOperator, nDetails.statistics.expiredMessages, nDetails.statistics.failedMessagesWithoutError, nDetails.statistics.rejectedMessagesByOperator, nDetails.statistics.failedMessagesWithError, nDetails.statistics.messagesInProcessOfSending);
				BSDLog(@"\nNetwork details total: %@", nDetails.total);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testNetworkDetails"];
}

-(void)testUpdateConnection
{
	_connection.label = @"New label";
	_connection.description = @"New description";
	_connection.systemID = @"New system ID";
	
	[_connection updateConnectionOnCompletion:^(NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testUpdateConnection"];
		
		if (!errors || errors.count == 0) {
			
			BSDLog(@"\nConnection label: %@", _connection.label);
			BSDLog(@"\nConnection description: %@", _connection.description);
			BSDLog(@"\nConnection system ID: %@", _connection.systemID);
			
			BSDLog(@"\n------------------------\n");
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testUpdateConnection"];
}

- (void)testResetConnectionToken
{
	[_connection resetConnectionTokenOnCompletion:^(NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testResetConnectionPassword"];
		
		if (!errors || errors.count == 0) {
			
			BSDLog(@"\nConnection API token: %@", _connection.apiToken);
			
			BSDLog(@"\n------------------------\n");
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testResetConnectionPassword"];
}

- (void)testGetCurrentPricelists
{
	[_connection getCurrentPricelistOnCompletion:^(BSPricelist *pricelist, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetCurrentPricelists"];
		
		NSAssert(pricelist!=nil, @"Pricelist not fetched!");
		
		if (!errors || errors.count == 0) {
			
			BSDLog(@"\nPricelist ID: %@", pricelist.pricelistID);
			BSDLog(@"\nPricelist networks: %@", pricelist.networks);
			BSDLog(@"\nPricelist networks count: %@", pricelist.networkCount);
			BSDLog(@"\nPricelist saved: %@", pricelist.saved);
			BSDLog(@"\nPricelist active: %@", pricelist.active);
			BSDLog(@"\nPricelist first viewed: %@", pricelist.firstViewed);
			
			BSDLog(@"\n------------------------\n");
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetCurrentPricelists"];
}

- (void)testGetPricelists
{
	[_connection getPricelistsOnCompletion:^(NSArray *pricelists, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetPricelists"];
		
		NSAssert(pricelists!=nil, @"Pricelists not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSPricelist *pricelist in pricelists) {
	
				BSDLog(@"\nPricelist ID: %@", pricelist.pricelistID);
				BSDLog(@"\nPricelist networks: %@", pricelist.networks);
				BSDLog(@"\nPricelist networks count: %@", pricelist.networkCount);
				BSDLog(@"\nPricelist saved: %@", pricelist.saved);
				BSDLog(@"\nPricelist active: %@", pricelist.active);
				BSDLog(@"\nPricelist first viewed: %@", pricelist.firstViewed);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetPricelists"];
}

- (void)testSendMessage
{
	BSMessage *sms = [BSMessage messageWithBody:@"Message body" from:@"Vladica" to:@"123456789012"];
	
	[_user getAvailableConnectionsOnCompletion:^(NSArray *connections, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetAllConnectionsSENDMESSAGE"];
		
		NSAssert(connections!=nil, @"Connections not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSConnection *connection in connections) {
				
				if (connection.type == BSConnectionTypeSMS) {
					
					[connection sendSMS:sms withCompletionBlock:^(BSMessage *message, NSArray *errors) {
						[[BSTestSemaphor sharedInstance] lift:@"testSendMessage"];
						
						NSAssert(message!=nil, @"Message not sent!");
						
						if (!errors || errors.count == 0) {
							
							BSDLog(@"\nMessage sender: %@", message.sender);
							BSDLog(@"\nMessage body: %@", message.message);
							BSDLog(@"\nMessage recipient: %@", message.recipient);
							BSDLog(@"\nMessage message type: %@", message.messageType);
							BSDLog(@"\nMessage used encoding: %@", message.usedEncoding);
							
							BSDLog(@"\n------------------------\n");
						}
						else {
							
							for (BSError *error in errors) {
								
								BSDLog(@"%@ - %@", [error code], [error errorDescription]);
								
								BSDLog(@"\n------------------------\n");
							}
						}
					}];
					[[BSTestSemaphor sharedInstance] waitForKey:@"testSendMessage"];
				}
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetAllConnectionsSENDMESSAGE"];
	
}

- (void)testSendMessages
{
	BSMessage *sms1 = [BSMessage messageWithBody:@"Message body 1" from:@"Vladica 1" to:@"123456789011"];
	BSMessage *sms2 = [BSMessage messageWithBody:@"Message body 2" from:@"Vladica 2" to:@"123456789012"];
	BSMessage *sms3 = [BSMessage messageWithBody:@"Message body 3" from:@"Vladica 3" to:@"123456789013"];
	BSMessage *sms4 = [BSMessage messageWithBody:@"Message body 4" from:@"Vladica 4" to:@"123456789014"];
		
	[_user getAvailableConnectionsOnCompletion:^(NSArray *connections, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetAllConnectionsSENDMESSAGES"];
		
		NSAssert(connections!=nil, @"Connections not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSConnection *connection in connections) {
				
				if (connection.type == BSConnectionTypeSMS) {
					
					[connection sendMultipleSMS:@[sms1, sms2, sms3, sms4] withCompletionBlock:^(NSArray *messages, NSArray *errors) {
						[[BSTestSemaphor sharedInstance] lift:@"testSendMessages"];
						
						NSAssert(messages!=nil, @"Messages not sent!");
						
						if (!errors || errors.count == 0) {
							
							for (BSMessage *message in messages) {
							
								if (message.errors && message.errors.count > 0) {
									
									for (BSError *error in message.errors) {
										
										BSDLog(@"%@ - %@", [error code], [error errorDescription]);
										
										BSDLog(@"\n------------------------\n");
									}
								}
								else {
									BSDLog(@"\nMessage sender: %@", message.sender);
									BSDLog(@"\nMessage body: %@", message.message);
									BSDLog(@"\nMessage recipient: %@", message.recipient);
									BSDLog(@"\nMessage message type: %@", message.messageType);
									BSDLog(@"\nMessage used encoding: %@", message.usedEncoding);
									
									BSDLog(@"\n------------------------\n");
								}
							}
						}
						else {
							
							for (BSError *error in errors) {
								
								BSDLog(@"%@ - %@", [error code], [error errorDescription]);
								
								BSDLog(@"\n------------------------\n");
							}
						}
					}];
					[[BSTestSemaphor sharedInstance] waitForKey:@"testSendMessages"];
				}
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetAllConnectionsSENDMESSAGES"];
}

- (void)testValidateMessage
{
	BSMessage *sms = [BSMessage messageWithBody:@"Message body" from:@"Vladica" to:@"123456789012"];
	
	[_user getAvailableConnectionsOnCompletion:^(NSArray *connections, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetAllConnectionsVALIDATE"];
		
		NSAssert(connections!=nil, @"Connections not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSConnection *connection in connections) {
				
				if (connection.type == BSConnectionTypeSMS) {
					
					[connection validateSMS:sms onCompletion:^(BSMessage *message, NSArray *errors) {
						[[BSTestSemaphor sharedInstance] lift:@"testValidateMessage"];
						
						NSAssert(message!=nil, @"Message not sent!");
						
						if (!errors || errors.count == 0) {
							
							BSDLog(@"\nMessage sender: %@", message.sender);
							BSDLog(@"\nMessage body: %@", message.message);
							BSDLog(@"\nMessage recipient: %@", message.recipient);
							BSDLog(@"\nMessage message type: %@", message.messageType);
							BSDLog(@"\nMessage used encoding: %@", message.usedEncoding);
							
							BSDLog(@"\n------------------------\n");
						}
						else {
							
							for (BSError *error in errors) {
								
								BSDLog(@"%@ - %@", [error code], [error errorDescription]);
								
								BSDLog(@"\n------------------------\n");
							}
						}
					}];
					[[BSTestSemaphor sharedInstance] waitForKey:@"testValidateMessage"];
				}
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetAllConnectionsVALIDATE"];
}

- (void)testGetMessageDetails
{
	BSMessage *sms = [BSMessage messageWithBody:@"Message body" from:@"Vladica" to:@"123456789012"];
	
	[_user getAvailableConnectionsOnCompletion:^(NSArray *connections, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetAllConnectionsLOOKUP"];
		
		NSAssert(connections!=nil, @"Connections not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSConnection *connection in connections) {
				
				if (connection.type == BSConnectionTypeSMS) {
					
					[connection sendSMS:sms withCompletionBlock:^(BSMessage *message, NSArray *errors) {
						[[BSTestSemaphor sharedInstance] lift:@"testSendMessageLOOKUP"];
						
						NSAssert(message!=nil, @"Message not sent!");
						
						if (!errors || errors.count == 0) {
							
							[connection getDetailsForSMS:message onCompletion:^(BSLookup *lookup, NSArray *errors) {
								[[BSTestSemaphor sharedInstance] lift:@"getMessageDetails"];
								
								NSAssert(lookup!=nil, @"Lookup not fetched!");
								
								if (!errors || errors.count == 0) {
									
									BSDLog(@"\nLookup ID: %@", lookup.lookupID);
									BSDLog(@"\nLookup batch: %@", lookup.batch.label);
									BSDLog(@"\nLookup message body: %@", lookup.messageBody);
									BSDLog(@"\nLookup used connection: %@", lookup.usedConnection.label);
									BSDLog(@"\nLookup data coding: %@", lookup.dataCoding);
									BSDLog(@"\nLookup sender: %@", lookup.sender.destinationNumber);
									BSDLog(@"\nLookup price: %@", lookup.price);
									BSDLog(@"\nLookup recipient: %@", lookup.recipient.destinationNumber);
									BSDLog(@"\nLookup valid to: %@", lookup.validTo);
									
									BSDLog(@"\n------------------------\n");
								}
								else {
									
									for (BSError *error in errors) {
										
										BSDLog(@"%@ - %@", [error code], [error errorDescription]);
										
										BSDLog(@"\n------------------------\n");
									}
								}
							}];
							[[BSTestSemaphor sharedInstance] waitForKey:@"getMessageDetails"];
						}
						else {
							
							for (BSError *error in errors) {
								
								BSDLog(@"%@ - %@", [error code], [error errorDescription]);
								
								BSDLog(@"\n------------------------\n");
							}
						}
					}];
					[[BSTestSemaphor sharedInstance] waitForKey:@"testSendMessageLOOKUP"];
				}
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetAllConnectionsLOOKUP"];
}

- (void)testGetBatchDetails
{
	[_connection getPreviousBatchesOnCompletion:^(NSArray *batches, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetBatchesDETAILS"];
		
		NSAssert(batches!=nil, @"Batches not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSBatch *batch in batches) {
				
				[_connection getDetailsForBatch:batch onCompletion:^(BSBatch *batch, NSArray *errors) {
					[[BSTestSemaphor sharedInstance] lift:@"testGetBatchDetails"];
					
					NSAssert(batch!=nil, @"Batch not fetched!");
					
					if (!errors || errors.count == 0) {
						
						BSDLog(@"\nBatch ID: %@", batch.batchID);
						BSDLog(@"\nBatch label: %@", batch.label);
							
						BSDLog(@"\n------------------------\n");
					}
					else {
						
						for (BSError *error in errors) {
							
							BSDLog(@"%@ - %@", [error code], [error errorDescription]);
							
							BSDLog(@"\n------------------------\n");
						}
					}
				}];
				[[BSTestSemaphor sharedInstance] waitForKey:@"testGetBatchDetails"];
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetBatchesDETAILS"];
}

- (void)testGetBatches
{
	[_connection getPreviousBatchesOnCompletion:^(NSArray *batches, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetBatches"];
		
		NSAssert(batches!=nil, @"Batches not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSBatch *batch in batches) {
				
				BSDLog(@"\nBatch ID: %@", batch.batchID);
				BSDLog(@"\nBatch label: %@", batch.label);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetBatches"];
}

- (void)testEstimateMessageCost
{
	BSMessage *sms = [BSMessage messageWithBody:@"Message body" from:@"Vladica" to:@"123456789012"];
	
	[_user getAvailableConnectionsOnCompletion:^(NSArray *connections, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetAllConnectionsESTIMATE"];
		
		NSAssert(connections!=nil, @"Connections not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSConnection *connection in connections) {
				
				if (connection.type == BSConnectionTypeSMS) {
					
					[connection estimateSMSCostForMessages:@[sms] onCompletion:^(NSArray *cost, NSArray *errors) {
						[[BSTestSemaphor sharedInstance] lift:@"testEstimateMessageCost"];
						
						NSAssert(cost!=nil, @"Message cost not fetched!");
						
						if (!errors || errors.count == 0) {
							
							for (BSEstimateCost *eCost in cost) {
								
								BSDLog(@"\nRecipients: %@", eCost.recipients);
								BSDLog(@"\nTotal cost: %@", eCost.totalCost);
								
								BSDLog(@"\n------------------------\n");
							}
						}
						else {
							
							for (BSError *error in errors) {
								
								BSDLog(@"%@ - %@", [error code], [error errorDescription]);
								
								BSDLog(@"\n------------------------\n");
							}
						}
					}];
					[[BSTestSemaphor sharedInstance] waitForKey:@"testEstimateMessageCost"];
				}
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetAllConnectionsESTIMATE"];
}

- (void)testImmediateHLR
{
	[_user getAvailableConnectionsOnCompletion:^(NSArray *connections, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetAllConnectionsHLR"];
		
		NSAssert(connections!=nil, @"Connections not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSConnection *connection in connections) {
				
				if (connection.type == BSConnectionTypeHLR) {
					
					[connection immediateHLRForNumber:@"123456789012" onCompletion:^(BSHLR *hlr, NSArray *errors) {
						[[BSTestSemaphor sharedInstance] lift:@"testImmediateHLR"];
						
						NSAssert(hlr!=nil, @"HLR not performed!");
						
						if (!errors || errors.count == 0) {
							
							BSDLog(@"\nHLR ID: %@", hlr.hlrID);
							BSDLog(@"\nHLR imsi: %@", hlr.imsi);
							BSDLog(@"\nHLR phone number: %@", hlr.phoneNumber);
							
							BSDLog(@"\n------------------------\n");
						}
						else {
							
							for (BSError *error in errors) {
								
								BSDLog(@"%@ - %@", [error code], [error errorDescription]);
								
								BSDLog(@"\n------------------------\n");
							}
						}
					}];
					[[BSTestSemaphor sharedInstance] waitForKey:@"testImmediateHLR"];
				}
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetAllConnectionsHLR"];
}

- (void)testBulkHLR
{
	[_user getAvailableConnectionsOnCompletion:^(NSArray *connections, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testBulkHLRConnections"];
		
		NSAssert(connections!=nil, @"Connections not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSConnection *connection in connections) {
				
				if (connection.type == BSConnectionTypeHLR) {
					
					[connection bulkHLRForNumbers:@[@"123456789012",@"123456789013"] onCompletion:^(NSArray *hlrs, NSArray *errors) {
						[[BSTestSemaphor sharedInstance] lift:@"testBulkHLR"];
						
						NSAssert(hlrs!=nil, @"HLR not performed!");
						
						if (!errors || errors.count == 0) {
							
							for (BSHLR *hlr in hlrs) {
								
								BSDLog(@"\nHLR ID: %@", hlr.hlrID);
								BSDLog(@"\nHLR imsi: %@", hlr.imsi);
								BSDLog(@"\nHLR phone number: %@", hlr.phoneNumber);
								
								BSDLog(@"\n------------------------\n");
							}
						
							BSDLog(@"\n------------------------\n");
						}
						else {
							
							for (BSError *error in errors) {
								
								BSDLog(@"%@ - %@", [error code], [error errorDescription]);
								
								BSDLog(@"\n------------------------\n");
							}
						}
					}];
					[[BSTestSemaphor sharedInstance] waitForKey:@"testBulkHLR"];
				}
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testBulkHLRConnections"];
}

- (void)testTwoWayBatch
{
	[_connection getTwoWayBatchForID:@"1234" onCompletion:^(NSArray *batches, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testTwoWayBatch"];
		
		NSAssert(batches!=nil, @"Batches not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSTwoWayBatch *batch in batches) {
				
				BSDLog(@"\nBatch MO body: %@", batch.moBody);
				BSDLog(@"\nBatch MT body: %@", batch.mtBody);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testTwoWayBatch"];
}

- (void)testPricelistAsCSV
{
	[_connection getPricelistsAsCsvOnCompletion:^(NSString *pricelist, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testPricelistAsCSV"];
		
		NSAssert(pricelist!=nil, @"Pricelist not fetched!");
		
		if (!errors || errors.count == 0) {
			
			BSDLog(@"%@", pricelist);
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testPricelistAsCSV"];
}

- (void)testPricelistDiffAsCSV
{
	BSPricelist *p1 = [[BSPricelist alloc] initPricelistWithID:@"1234" networks:nil networkCount:nil timeOfSave:nil active:nil timeOfFirstView:nil];
	BSPricelist *p2 = [[BSPricelist alloc] initPricelistWithID:@"1235" networks:nil networkCount:nil timeOfSave:nil active:nil timeOfFirstView:nil];
	
	[_connection getPricelistsDiffAsCsvForPricelist:p1 andPricelist:p2 onCompletion:^(NSString *pricelist, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testPricelistDiffAsCSV"];
		
		NSAssert(pricelist!=nil, @"Pricelist diff not fetched!");
		
		if (!errors || errors.count == 0) {
			
			BSDLog(@"%@", pricelist);
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testPricelistDiffAsCSV"];
}

- (void)testPricelistDiff
{
	BSPricelist *p1 = [[BSPricelist alloc] initPricelistWithID:@"1234" networks:nil networkCount:nil timeOfSave:nil active:nil timeOfFirstView:nil];
	BSPricelist *p2 = [[BSPricelist alloc] initPricelistWithID:@"1235" networks:nil networkCount:nil timeOfSave:nil active:nil timeOfFirstView:nil];
	
	[_connection getPricelistsDiffForPricelist:p1 andPricelist:p2 onCompletion:^(BSNetwork *pricelistDiff, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testPricelistDiff"];
		
		NSAssert(pricelistDiff!=nil, @"Pricelist diff not fetched!");
		
		if (!errors || errors.count == 0) {
			
			BSDLog(@"\nBatch MO body: %@", pricelistDiff.comment);
			BSDLog(@"\nBatch MT body: %@", pricelistDiff.country);
				
			BSDLog(@"\n------------------------\n");

		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testPricelistDiff"];
}

- (void)testValidateHLR
{
	[_user getAvailableConnectionsOnCompletion:^(NSArray *connections, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetAllConnectionsHLRVALIDATE"];
		
		NSAssert(connections!=nil, @"Connections not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSConnection *connection in connections) {
				
				if (connection.type == BSConnectionTypeHLR) {
					
					[connection validateHLRForNumber:@"123456789012" onCompletion:^(BSHLR *hlr, NSArray *errors) {
						
						[[BSTestSemaphor sharedInstance] lift:@"testValidateHLR"];
						
						NSAssert(hlr!=nil, @"HLR not performed!");
						
						if (!errors || errors.count == 0) {
							
							BSDLog(@"\nHLR ID: %@", hlr.hlrID);
							BSDLog(@"\nHLR imsi: %@", hlr.imsi);
							BSDLog(@"\nHLR phone number: %@", hlr.phoneNumber);
							
							BSDLog(@"\n------------------------\n");
						}
						else {
							
							for (BSError *error in errors) {
								
								BSDLog(@"%@ - %@", [error code], [error errorDescription]);
								
								BSDLog(@"\n------------------------\n");
							}
						}
					}];
					[[BSTestSemaphor sharedInstance] waitForKey:@"testValidateHLR"];
				}
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetAllConnectionsHLRVALIDATE"];
}

- (void)testConnectionAnalyticSummary
{
	[_connection getAnalyticsSummaryFromDate:[NSDate date] toDate:[NSDate date] withCompletionBlock:^(NSArray *statistics, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testConnectionAnalyticSummary"];
		
		NSAssert(statistics!=nil, @"Statistic not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSAccumulatedStatistics *acStat in statistics) {
				
				BSDLog(@"\nAccumulated statistics account: %@", acStat.account);
				BSDLog(@"\nAccumulated statistics count: %@", acStat.count);
				BSDLog(@"\nAccumulated statistics price: %@", acStat.price);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testConnectionAnalyticSummary"];
}

- (void)testConnectionNetworkDetails
{
	[_connection getNetworkDetailsFromDate:[NSDate date] toDate:[NSDate date] mccmnc:nil withCompletionBlock:^(NSArray *networkDetails, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testConnectionNetworkDetails"];
		
		NSAssert(networkDetails!=nil, @"Network details not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSNetworkDetails *nDetails in networkDetails) {
				
				BSDLog(@"\nNetwork details MCC MNC: MCC: %@; MNC: %@;", nDetails.mccmnc.mcc, nDetails.mccmnc.mnc);
				BSDLog(@"\nNetwork details statistic: Delivered: %@; Incoming: %@; Expired: %@; FailedNoError: %@; Rejected: %@; Failed: %@; InProcess: %@;", nDetails.statistics.deliveredMessages, nDetails.statistics.incomingMessagesFromOperator, nDetails.statistics.expiredMessages, nDetails.statistics.failedMessagesWithoutError, nDetails.statistics.rejectedMessagesByOperator, nDetails.statistics.failedMessagesWithError, nDetails.statistics.messagesInProcessOfSending);
				BSDLog(@"\nNetwork details total: %@", nDetails.total);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testConnectionNetworkDetails"];
}

- (void)testGetDeliveryStatistics
{
	[_connection getPreviousBatchesOnCompletion:^(NSArray *batches, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetBatchesDeliveryStatistics"];
		
		NSAssert(batches!=nil, @"Batches not fetched!");
		
		if (!errors || errors.count == 0) {
			
			for (BSBatch *batch in batches) {
				
				[batch getDeliveryStatisticsWithCompletionBlock:^(NSArray *statistics, NSArray *errors) {
					[[BSTestSemaphor sharedInstance] lift:@"testGetDeliveryStatistics"];
					
					NSAssert(statistics!=nil, @"Delivery statistics not fetched!");
					
					if (!errors || errors.count == 0) {
						
						for (BSAnalyticsBatch *analytic in statistics) {
							
							BSDLog(@"\nAnalytic batch ID: %@", analytic.batchID);
							BSDLog(@"\nAnalytic batch label: %@", analytic.label);
							BSDLog(@"\nAnalytic batch total: %@", analytic.total);
							BSDLog(@"\nAnalytic batch detail statistic: Delivered: %@; Incoming: %@; Expired: %@; FailedNoError: %@; Rejected: %@; Failed: %@; InProcess: %@;", analytic.statistic.deliveredMessages, analytic.statistic.incomingMessagesFromOperator, analytic.statistic.expiredMessages, analytic.statistic.failedMessagesWithoutError, analytic.statistic.rejectedMessagesByOperator, analytic.statistic.failedMessagesWithError, analytic.statistic.messagesInProcessOfSending);
							
							BSDLog(@"\n------------------------\n");
							
						}
					}
					else {
						
						for (BSError *error in errors) {
							
							BSDLog(@"%@ - %@", [error code], [error errorDescription]);
							
							BSDLog(@"\n------------------------\n");
						}
					}
				}];
				[[BSTestSemaphor sharedInstance] waitForKey:@"testGetDeliveryStatistics"];
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetBatchesDeliveryStatistics"];
}

- (void)testUpdateWallet
{
	NSAssert(_wallet1!=nil, @"Wallet not set");
	
	_wallet1.name = @"New wallet name";
	_wallet1.minimumBalanceForNotification = @3;
	
	[_wallet1 updateWalletOnCompletion:^(BSWallet *wallet, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testUpdateWallet"];
		
		NSAssert(wallet!=nil, @"Wallet not updated");
		
		if (!errors || errors.count == 0) {

			BSDLog(@"\nWallet ID: %@", wallet.walletID);
			BSDLog(@"\nWallet name: %@", wallet.name);
			BSDLog(@"\nWallet minimum balance: %@", wallet.minimumBalanceForNotification);
			BSDLog(@"\nWallet balance: %@;", wallet.balance);
			
			BSDLog(@"\n------------------------\n");

		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testUpdateWallet"];
}

- (void)testGetTransactionLog
{
	NSAssert(_wallet1!=nil, @"Wallet not set");
	
	[_wallet1 getTransactionLogForNextPage:NO onCompletion:^(NSArray *log, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetTransactionLog"];
		
		NSAssert(log!=nil, @"Transaction log not fetched");
		
		if (!errors || errors.count == 0) {
			
			for (BSLog *tLog in log) {
			
				BSDLog(@"\nLog ID: %@", tLog.logID);
				BSDLog(@"\nLog comment: %@", tLog.comment);
				BSDLog(@"\nLog change: %@", tLog.change);
				BSDLog(@"\nLog balance after transaction: %@;", tLog.balanceAfterTransaction);
				BSDLog(@"\nLog transaction time: %@;", tLog.timeOfTransaction);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetTransactionLog"];
}

- (void)testTransferFunds
{
	NSAssert(_wallet1!=nil, @"Wallet 1 not set");
	NSAssert(_wallet2!=nil, @"Wallet 2 not set");
	
	[_wallet1 transferFunds:@10 fromWallet:_wallet2 onCompletion:^(BSTransfer *transfer, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testTransferFunds"];
		
		NSAssert(transfer!=nil, @"Transfer failed");
		
		if (!errors || errors.count == 0) {

			BSDLog(@"\nSource wallet: ID: %@; Name: %@; Balance: %@;", transfer.source.walletID, transfer.source.name, transfer.source.balance);
			BSDLog(@"\nTarget wallet: ID: %@; Name: %@; Balance: %@;", transfer.target.walletID, transfer.target.name, transfer.target.balance);
			BSDLog(@"\nAmount: %@", transfer.amount);
			
			BSDLog(@"\n------------------------\n");
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testTransferFunds"];
}

- (void)testGetEmails
{
	NSAssert(_wallet1!=nil, @"Wallet 1 not set");
	
	[_wallet1 getEmailsOnCompletion:^(NSArray *emails, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetEmails"];
		
		NSAssert(emails!=nil, @"Emails failed to fetch");
		
		if (!errors || errors.count == 0) {
			
			for (BSEmail *email in emails) {
				
				BSDLog(@"\nEmail ID: %@", email.emailID);
				BSDLog(@"\nEmail address: %@", email.address);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetEmails"];
}

- (void)testAddEmail
{
	NSAssert(_wallet1!=nil, @"Wallet 1 not set");
	
	[_wallet1 addEmail:@"mail@email.com" onCompletion:^(BSEmail *email, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testAddEmail"];
		
		NSAssert(email!=nil, @"Email failed to add");
		
		if (!errors || errors.count == 0) {
			
			BSDLog(@"\nEmail ID: %@", email.emailID);
			BSDLog(@"\nEmail address: %@", email.address);
				
			BSDLog(@"\n------------------------\n");
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testAddEmail"];
}

- (void)testGetEmail
{
	NSAssert(_wallet1!=nil, @"Wallet 1 not set");
	
	[_wallet1 addEmail:@"mail@email.com" onCompletion:^(BSEmail *email, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testGetEmailAdd"];
	
		NSAssert(email!=nil, @"Email failed to add");
		
		if (!errors || errors.count == 0) {
			
			[_wallet1 getEmailWithID:email.emailID onCompletion:^(BSEmail *eml, NSArray *err) {
				[[BSTestSemaphor sharedInstance] lift:@"testGetEmail"];
				
				if (err && err.count > 0) {
					
					for (BSError *error in err) {
						
						BSDLog(@"%@ - %@", [error code], [error errorDescription]);
						
						BSDLog(@"\n------------------------\n");
					}
				}
				else {
					BSDLog(@"\nEmail ID: %@", eml.emailID);
					BSDLog(@"\nEmail address: %@", eml.address);
					
					BSDLog(@"\n------------------------\n");
				}
				
			}];
			[[BSTestSemaphor sharedInstance] waitForKey:@"testGetEmail"];
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testGetEmailAdd"];
}

- (void)testRemoveEmail
{
	NSAssert(_wallet1!=nil, @"Wallet 1 not set");
	
	[_wallet1 addEmail:@"mail@email.com" onCompletion:^(BSEmail *email, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testAddEmailRemove"];
		
		NSAssert(email!=nil, @"Email failed to add");
		
		if (!errors || errors.count == 0) {
			
			[_wallet1 removeEmail:email onCompletion:^(BOOL success, NSArray *errors) {
				[[BSTestSemaphor sharedInstance] lift:@"testRemoveEmail"];
				
				if (errors && errors.count > 0) {
					
					for (BSError *error in errors) {
						
						BSDLog(@"%@ - %@", [error code], [error errorDescription]);
						
						BSDLog(@"\n------------------------\n");
					}
				}
			}];
			[[BSTestSemaphor sharedInstance] waitForKey:@"testRemoveEmail"];
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
		
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testAddEmailRemove"];
}

- (void)testSaveContact
{
	BSContact *c1 = [[BSContact alloc] initContactWithPhoneNumber:@"111111" firstName:@"C1" lastName:@"C1" group:nil];
	
	[c1 saveContactOnCompletion:^(BSContact *contact, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testSaveContact"];
		
		NSAssert(contact!=nil, @"Contact not saved!");
		
		if (!errors || errors.count == 0) {
			
			
			if (contact.errors && contact.errors.count > 0) {
				
				for (BSError *error in contact.errors) {
					
					BSDLog(@"%@ - %@", [error code], [error errorDescription]);
					
					BSDLog(@"\n------------------------\n");
				}
			}
			else {
				BSDLog(@"\nContact ID: %@", contact.contactID);
				BSDLog(@"\nContact first name: %@", contact.firstName);
				BSDLog(@"\nContact last name: %@", contact.lastName);
				BSDLog(@"\nContact phone number: %@", contact.phoneNumber);
				BSDLog(@"\nContact group: %@", contact.group.name);
				
				BSDLog(@"\n------------------------\n");
				
				_contact = contact;
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testSaveContact"];
}

- (void)testUpdateContact
{
	NSAssert(_contact!=nil, @"Contact not set");
	
	_contact.firstName = @"Contact first name";
	_contact.lastName = @"Contact last name";
	
	[_contact updateContactOnCompletion:^(BSContact *contact, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testUpdateContact"];
		
		NSAssert(contact!=nil, @"Contact not updated!");
		
		if (!errors || errors.count == 0) {
			
			
			if (contact.errors && contact.errors.count > 0) {
				
				for (BSError *error in contact.errors) {
					
					BSDLog(@"%@ - %@", [error code], [error errorDescription]);
					
					BSDLog(@"\n------------------------\n");
				}
			}
			else {
				BSDLog(@"\nContact ID: %@", contact.contactID);
				BSDLog(@"\nContact first name: %@", contact.firstName);
				BSDLog(@"\nContact last name: %@", contact.lastName);
				BSDLog(@"\nContact phone number: %@", contact.phoneNumber);
				BSDLog(@"\nContact group: %@", contact.group.name);
				
				BSDLog(@"\n------------------------\n");
				
				_contact = contact;
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testUpdateContact"];
}

- (void)testSaveGroup
{
	BSGroup *g1 = [[BSGroup alloc] initGroupWithName:@"Group name"];
	
	[g1 saveGroupOnCompletion:^(BSGroup *group, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testSaveGroup"];
		
		NSAssert(group!=nil, @"Group not saved!");
		
		if (!errors || errors.count == 0) {
			
			BSDLog(@"\nGroup ID: %@", group.groupID);
			BSDLog(@"\nGroup name: %@", group.name);
			BSDLog(@"\nGroup contact count: %@", group.contactsCount);
				
			BSDLog(@"\n------------------------\n");
				
			_group = group;

		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}

	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testSaveGroup"];
}

- (void)testUpdateGroup
{
	NSAssert(_group!=nil, @"Group not set");
	
	_group.name = @"Group name new";
	
	[_group updateGroupOnCompletion:^(BSGroup *group, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testUpdateGroup"];
		
		NSAssert(group!=nil, @"Group not updated!");
		
		if (!errors || errors.count == 0) {
			
			BSDLog(@"\nGroup ID: %@", group.groupID);
			BSDLog(@"\nGroup name: %@", group.name);
			BSDLog(@"\nGroup contact count: %@", group.contactsCount);
			
			BSDLog(@"\n------------------------\n");
			
			_group = group;
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testUpdateGroup"];
}

- (void)testAddContactToGroup
{
	NSAssert(_contact!=nil, @"Contact not set");
	NSAssert(_group!=nil, @"Contact not set");
	
	[_group addContact:_contact onCompletion:^(BSContact *contact, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testAddContactToGroup"];
		
		NSAssert(contact!=nil, @"Contact not added to group!");
		
		if (!errors || errors.count == 0) {
			
			if (contact.errors && contact.errors.count > 0) {
				
				for (BSError *error in contact.errors) {
					
					BSDLog(@"%@ - %@", [error code], [error errorDescription]);
					
					BSDLog(@"\n------------------------\n");
				}
			}
			else {
				BSDLog(@"\nContact ID: %@", contact.contactID);
				BSDLog(@"\nContact first name: %@", contact.firstName);
				BSDLog(@"\nContact last name: %@", contact.lastName);
				BSDLog(@"\nContact phone number: %@", contact.phoneNumber);
				BSDLog(@"\nContact group: %@", contact.group.name);
				
				BSDLog(@"\n------------------------\n");
				
				_contact = contact;
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testAddContactToGroup"];
}

- (void)testAddContactsToGroup
{
	NSAssert(_contact!=nil, @"Contact not set");
	NSAssert(_group!=nil, @"Contact not set");
	
	BSContact *c1 = [[BSContact alloc] initContactWithPhoneNumber:@"111111" firstName:@"C1" lastName:@"C1" group:nil];
	BSContact *c2 = [[BSContact alloc] initContactWithPhoneNumber:@"222222" firstName:@"C2" lastName:@"C2" group:nil];
	BSContact *c3 = [[BSContact alloc] initContactWithPhoneNumber:@"333333" firstName:@"C3" lastName:@"C3" group:nil];
	
	[_group addContacts:@[c1, c2, c3] onCompletion:^(NSArray *contacts, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testAddContactsToGroup"];
		
		NSAssert(contacts!=nil, @"Contacts not added to group!");
		
		if (!errors || errors.count == 0) {
			
			for (BSContact *contact in contacts) {
				
				if (contact.errors && contact.errors.count > 0) {
					
					for (BSError *error in contact.errors) {
						
						BSDLog(@"%@ - %@", [error code], [error errorDescription]);
						
						BSDLog(@"\n------------------------\n");
					}
				}
				else {
					BSDLog(@"\nContact ID: %@", contact.contactID);
					BSDLog(@"\nContact first name: %@", contact.firstName);
					BSDLog(@"\nContact last name: %@", contact.lastName);
					BSDLog(@"\nContact phone number: %@", contact.phoneNumber);
					BSDLog(@"\nContact group: %@", contact.group.name);
					
					BSDLog(@"\n------------------------\n");
					
					_contact = contact;
				}
			}
		}
		else {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testAddContactsToGroup"];
}

- (void)testRemoveContactFromGroup
{
	NSAssert(_contact!=nil, @"Contact not set");
	NSAssert(_group!=nil, @"Contact not set");
	
	[_group removeContact:_contact onCompletion:^(BOOL success, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testRemoveContactFromGroup"];
		
		if (errors && errors.count > 0) {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testRemoveContactFromGroup"];
}

- (void)testRemoveContactsFromGroup
{
	NSAssert(_contact!=nil, @"Contact not set");
	NSAssert(_group!=nil, @"Contact not set");
	
	BSContact *c1 = [[BSContact alloc] initContactWithID:@"12345" firstName:@"C1" lastName:@"C1" phoneNumber:@"1234567890" group:nil errors:nil];
	BSContact *c2 = [[BSContact alloc] initContactWithID:@"12346" firstName:@"C2" lastName:@"C2" phoneNumber:@"1234567891" group:nil errors:nil];
	BSContact *c3 = [[BSContact alloc] initContactWithID:@"12347" firstName:@"C3" lastName:@"C3" phoneNumber:@"1234567892" group:nil errors:nil];
	
	[_group removeContacts:@[c1, c2, c3] onCompletion:^(BOOL success, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testRemoveContactsFromGroup"];
		
		if (errors && errors.count > 0) {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testRemoveContactsFromGroup"];
}

- (void)testRemoveContact
{
	NSAssert(_contact!=nil, @"Contact not set");
	
	[_contact removeContactOnCompletion:^(BOOL success, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testRemoveContact"];
		
		if (errors && errors.count > 0) {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testRemoveContact"];
}

- (void)testRemoveGroup
{
	NSAssert(_group!=nil, @"Group not set");
	
	[_group removeGroupOnCompletion:^(BOOL success, NSArray *errors) {
		[[BSTestSemaphor sharedInstance] lift:@"testRemoveGroup"];
		
		if (errors && errors.count > 0) {
			
			for (BSError *error in errors) {
				
				BSDLog(@"%@ - %@", [error code], [error errorDescription]);
				
				BSDLog(@"\n------------------------\n");
			}
		}
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"testRemoveGroup"];
}

@end
