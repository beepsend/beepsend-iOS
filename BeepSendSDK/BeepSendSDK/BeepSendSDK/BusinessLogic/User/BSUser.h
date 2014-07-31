//
//  BSUser.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSWallet.h"
#import "BSVerified.h"
#import "BSCustomer.h"
#import "BSGroup.h"
#import "BSContact.h"
#import	"BSMCCMNC.h"
#import "BSError.h"

@class BSConnection;

/*!
 @class BSUser
 @discussion As a user you can perform administrative tasks like, for example,
 transferring funds between your connections. 
 Using a connection you can send SMS and HLR requests.
 */
@interface BSUser : BSGeneralModel

/*! User ID
 */
@property (nonatomic, strong, readonly) NSString *userID;

/*! Name to recognise your User by.
 */
@property (nonatomic, strong) NSString *name;

/*! User email.
 */
@property (nonatomic, strong) NSString *email;

/*! User phone number.
 */
@property (nonatomic, strong) NSString *phone;

/*! Users default connection
 */
@property (nonatomic, strong) BSConnection *defaultConnection;

/*! What customer the user is associated with.
 */
@property (nonatomic, strong, readonly) NSString *customerName;

/*! API Token belonging to this User.
 */
@property (nonatomic, strong, readonly) NSString *apiToken;

/*! List of types that applies to this user.
 */
@property (nonatomic, strong) NSArray *userTypes;

/*! Simple permission model. Allows access to all version 2 endpoints.
 */
@property (nonatomic, strong, readonly) NSNumber *maxLevel;

/*! Users password
 */
@property (nonatomic, strong, readonly) NSString *password;

/*! New password. Used when user wants to change password.
 */
@property (nonatomic, strong, readonly) NSString *theNewPassword;

/*! Is user verified
 */
@property (nonatomic, strong, readonly) BSVerified *verified;

/*!	What customer the user is associated with.
	Accessible only if customer details are enquired
 */
@property (nonatomic, strong, readonly) BSCustomer *customer;

/*! Create User object
 Used when confirmation from user is necessary with password
 
 @param uEmail - Users email
 @param uPassword - Users password
 
 @return Returns User object
 */
- (BSUser *)initUserWithEmail:(NSString *)uEmail
				  andPassword:(NSString *)uPassword;

/*! Create User object
 Used when user is changing password
 
 @param uPassword - Users password
 @param uNewPassword - Users new password
 
 @return Returns User object
 */
- (BSUser *)initUserWithPassword:(NSString *)uPassword
				  andNewPassword:(NSString *)uNewPassword;

/*! Create User object
 Used for initializing user object with object received from server
 
 @param uName - Users name
 @param uPhone - Users phone
 @param uConnection - Users connection
 @param uTypes - User types
 @param uVerified - Users verification
 
 @return Returns User object
 */
- (BSUser *)initWithName:(NSString *)uName
				   phone:(NSString *)uPhone
	   defaultConnection:(BSConnection *)uConnection
			   userTypes:(NSArray *)uTypes
				verified:(BSVerified *)uVerified;

/*! Create User object
 Used for initializing user object with object received from server
 
 @param uID - Users ID
 @param uName - Users name
 @param uEmail - Users email
 @param uPhone - Users phone
 @param uCustomer - Customer
 @param uAPIToken - Users name
 @param uConnection - Users API token
 @param uUserTypes - User types
 @param uMaxLevel - Users max level
 @param uVerified - Users verification
 
 @return Returns User object
 */
- (BSUser *)initUserWithID:(NSString *)uID
					  name:(NSString *)uName
					 email:(NSString *)uEmail
					 phone:(NSString *)uPhone
				  customer:(NSString *)uCustomer
				  apiToken:(NSString *)uAPIToken
		 defaultConnection:(BSConnection *)uConnection
				 userTypes:(NSArray *)uUserTypes
				  maxLevel:(NSNumber *)uMaxLevel
				  verified:(BSVerified *)uVerified;

/*! Create User object
 Used when only users id is known
 
 @param uID - Users ID
 
 @return Returns User object
 */
- (BSUser *)initWithUserID:(NSString *)uID;

/*! User associated with entered API token
 
 @return Returns User object
 */
+ (BSUser *)currentUser;

/*! If changes were made to user use update method to save changes.
	Available properties to update: name, phone or defaultConnection
 
 @param block - Returns error if update failed
 */
- (void)updateUserOnCompletion:(void(^)(NSArray *errors))block;

/*! For updateing email address user needs to enter password
 
 @param password - Users password
 @param block - Returns error if update failed
 */
- (void)updateUserEmailWithPassword:(NSString *)password
					   onCompletion:(void(^)(NSArray *errors))block;

/*! Method for changing password
 
 @param currentPassword - Current users password
 @param newPassword - New user password
 @param block - Returns error if update failed
 */
- (void)changePassword:(NSString *)currentPassword
	   withNewPassword:(NSString *)newPassword
		  onCompletion:(void(^)(NSArray *errors))block;

/*! If API token is compromised use this method for token reset
 
 @param password - Users password
 @param block - Returns error if update failed
 */
- (void)resetUserTokenWithPassword:(NSString *)password
					  onCompletion:(void(^)(NSArray *errors))block;

/*! Async method for retrieving all user connections
 
 @param block - Returns array of user connections or errors if any
 */
- (void)getAvailableConnectionsOnCompletion:(void(^)(NSArray *connections, NSArray *errors))block;

/*! Sync method for retrieving all user connections
 
 @return Returns avilable connections
 */
- (NSArray *)getAvailableConnections;

/*! Method for retrieving customer details
 
 @param block - Returns customer details
 */
- (void)getCustomerDetailsOnCompletion:(void(^)(BSCustomer *customer, NSArray *errors))block;

/*! Async method for retrieving all available wallets
 
 @param block - Returns array of user wallets
 */
- (void)getAvailableWalletsOnCompletion:(void(^)(NSArray *wallets, NSArray *errors))block;

/*! Sync method for retrieving all user wallets
 
 @return Returns available wallets
 */
- (NSArray *)getAvailableWallets;

/*! Async method for retrieving user contacts
 
 @param block - Returns array of user contacts
 */
- (void)getAllContactsOnCompletion:(void(^)(NSArray *contacts, NSArray *errors))block;

/*! Sync method for retrieving user contacts
 
 @return Returns all contacts
 */
- (NSArray *)getAllContacts;

/*! Add list of contacts 
 
 @param contacts - Array of contacts to add
 @param block - Returns added list of contacts or error if add failed
 */
- (void)addMultipleContacts:(NSArray *)contacts
			   onCompletion:(void(^)(NSArray *response, NSArray *errors))block;

/*! Search contacts
 
 @param query - Will search entries matching on id, msisdn, firstname and lastname.
 @param group - Specify which group to search in.
 @param limit - Limit the amount of search results.
 @param block - Returns array of results
 */
- (void)searchContactsWithQuery:(NSString *)query
						inGroup:(BSGroup *)group
						  limit:(NSNumber *)limit
				   onCompletion:(void(^)(NSArray *results, NSArray *errors))block;

/*! Async method for retrieving user contacts from one group
 
 @param group - Group from which are contacts retrieved
 @param block - Returns array of user contacts
 */
- (void)getContactsInGroup:(BSGroup *)group
			  onCompletion:(void(^)(NSArray *results, NSArray *errors))block;

/*! Async method for retrieving user groups
 
 @param block - Returns array of user groups
 */
- (void)getAllGroupsOnCompletion:(void(^)(NSArray *groups, NSArray *errors))block;

/*! Sync method for retrieving user groups
 
 @return Returns all groups
 */
- (NSArray *)getAllGroups;

/*! Search groups
 
 @param query - Will search entries with matching name.
 @param limit - Limit the amount of search results.
 @param block - Returns array of results
 */
- (void)searchGroupsWithQuery:(NSString *)query
						limit:(NSNumber *)limit
				 onCompletion:(void(^)(NSArray *results, NSArray *errors))block;

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
