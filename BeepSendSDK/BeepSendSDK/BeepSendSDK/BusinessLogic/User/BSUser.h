//
//  BSUser.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 7/8/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSCustomer;
@class BSVerified;
@class BSConnection;
@class BSGroup;

@interface BSUser : BSGeneralModel

/** User ID
 */
@property (nonatomic, strong, readonly) NSString *userID;

/** Name to recognise your User by.
 */
@property (nonatomic, strong) NSString *name;

/** User email.
 */
@property (nonatomic, strong) NSString *email;

/** User phone number.
 */
@property (nonatomic, strong) NSString *phone;

/** Users default connection
 */
@property (nonatomic, strong) BSConnection *defaultConnection;

/** What customer the user is associated with.
 */
@property (nonatomic, strong, readonly) NSString *customerName;

/** API Token belonging to this User.
 */
@property (nonatomic, strong, readonly) NSString *apiToken;

/** List of types that applies to this user.
 */
@property (nonatomic, strong) NSArray *userTypes;

/** Simple permission model. Allows access to all version 2 endpoints.
 */
@property (nonatomic, strong, readonly) NSNumber *maxLevel;

/** Users password
 */
@property (nonatomic, strong, readonly) NSString *password;

/** New password. Used when user wants to change password.
 */
@property (nonatomic, strong, readonly) NSString *theNewPassword;

/** Is user verified
 */
@property (nonatomic, strong, readonly) BSVerified *verified;

/**	What customer the user is associated with.
	Accessible only if customer details are enquired
 */
@property (nonatomic, strong, readonly) BSCustomer *customer;

- (BSUser *)initUserWithID:(NSString *)uID
					  name:(NSString *)uName
					 email:(NSString *)uEmail;

- (BSUser *)initUserWithEmail:(NSString *)uEmail
				  andPassword:(NSString *)uPassword;

- (BSUser *)initUserWithPassword:(NSString *)uPassword
				  andNewPassword:(NSString *)uNewPassword;

- (BSUser *)initWithName:(NSString *)uName
				   phone:(NSString *)uPhone
	   defaultConnection:(BSConnection *)uConnection
			   userTypes:(NSArray *)uTypes
				verified:(BSVerified *)uVerified;

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

//Create user object with ID
- (BSUser *)initWithUserID:(NSString *)uID;

/** Returns User associated with entered API token
 */
+ (BSUser *)currentUser;

/** If changes were made to user use update method to save changes.
	Available properties to update: name, phone or defaultConnection
 */
- (void)updateUser;

/** For updateing email address user needs to enter password
 
 @param password - Users password
 */
- (void)updateUserEmailWithPassword:(NSString *)password;

/** Method for changing password
 
 @param currentPassword - Current users password
 @param newPassword - New user password
 */
- (void)changePassword:(NSString *)currentPassword withNewPassword:(NSString *)newPassword;

/** If API token is compromised use this method for token reset
 
 @param password - Users password
 */
- (void)resetUserTokenWithPassword:(NSString *)password;

/** Async method for retrieving all user connections
 
 @param block - Returns array of user connections
 */
- (void)getAvailableConnectionsOnCompletion:(void(^)(NSArray *connections))block;

/** Sync method for retrieving all user connections
 */
- (NSArray *)getAvailableConnections;

/** Method for retrieving customer details
 
 @param block - Returns customer details
 */
- (void)getCustomerDetailsOnCompletion:(void(^)(BSCustomer *customer, id error))block;

/** Async method for retrieving all available wallets
 
 @param block - Returns array of user wallets
 */
- (void)getAvailableWalletsOnCompletion:(void(^)(NSArray *wallets, id error))block;

/** Sync method for retrieving all user wallets
 */
- (NSArray *)getAvailableWallets;

/** Async method for retrieving user contacts
 
 @param block - Returns array of user contacts
 */
- (void)getAllContactsOnCompletion:(void(^)(NSArray *contacts, id error))block;

/** Sync method for retrieving user contacts
 */
- (NSArray *)getAllContacts;

/** Add list of contacts 
 
 @param contacts - Array of contacts to add
 @param block - Returns added list of contacts or error if add failed
 */
- (void)addMultipleContacts:(NSArray *)contacts onCompletion:(void(^)(NSArray *response, id error))block;

/** Search contacts
 
 @param query - Will search entries matching on id, msisdn, firstname and lastname.
 @param group - Specify which group to search in.
 @param limit - Limit the amount of search results.
 @param block - Returns array of results
 */
- (void)searchContactsWithQuery:(NSString *)query
						inGroup:(BSGroup *)group
						  limit:(NSNumber *)limit
				   onCompletion:(void(^)(NSArray *results, id error))block;

/** Async method for retrieving user groups
 
 @param block - Returns array of user groups
 */
- (void)getAllGroupsOnCompletion:(void(^)(NSArray *groups, id error))block;

/** Sync method for retrieving user groups
 */
- (NSArray *)getAllGroups;

/** Search groups
 
 @param query - Will search entries with matching name.
 @param limit - Limit the amount of search results.
 @param block - Returns array of results
 */
- (void)searchGroupsWithQuery:(NSString *)query
						limit:(NSNumber *)limit
				 onCompletion:(void(^)(NSArray *results, id error))block;

@end
