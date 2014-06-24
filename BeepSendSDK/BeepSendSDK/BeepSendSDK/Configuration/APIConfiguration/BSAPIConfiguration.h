//
//  BSAPIConfiguration.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/13/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

/*
 
	BSAPIConfiguration class will contain base url and 
	all methods available on backend
 
 
	Detailed documentation for RESTfull API can be found at:
	http://api.beepsend.com/docs.html
 
 
 */

#import <Foundation/Foundation.h>

@interface BSAPIConfiguration : NSObject

/*
	Host
 */
+ (NSString *)baseURL;

/*
	Add your API token as a parameter in the query string and append 
	to the URL you are trying to reach.
	@"?api_token=abc123"];
 */
+ (NSString *)urlAPIToken;

/*
	User can choose if authorization will be using Query String or HTTP header
	We will use authorization header in this SDK
 
 
	If you prefer keeping the URL untouched, 
	you can use an HTTP header in your request instead.
	In your request, add the Authorization HTTP header
	with your API token as value.
 
	Authorization: Token abc123
 */
+ (NSDictionary *)authorizationHeader;

#pragma mark -
#pragma mark - Methods

#pragma mark - Customer

/*
	As a user you belong to a customer. A customer is where your address,
	pay and pricelist information is stored.
 */
+ (NSString *)customer;

#pragma mark - Connections

/*
	To fetch a list of all available connections and 
	their corresponding information.
 */
+ (NSString *)connections;

/*
	For both Connection and User tokens a short-hand tag is available 
	which serves as alias for the connection ID. The label is called "me".
 */
+ (NSString *)connectionsMe;

/*
	Any property of the connection object can be manipulated once authenticated 
	either as that Connection using a Connection token or by authenticating 
	using a User token with read/write access to the Connection.
 */
+ (NSString *)connectionsWithID:(NSString *)connectionID;

/*
	If you think that the connection token used for authenticating with 
	the Beepsend API has been compromised you can use this method 
	(with a user token) to reset the connection token.
 */
+ (NSString *)connectionResetForID:(NSString *)connectionID;

/*
	If you wish to use our legacy HTTP API, you need to supply your connection
	username as well as password for each request. If you don't have your 
	connection password, you can request a new one with this endpoint.
 
	NOTE: A connection token and password are two separate things. 
	A connection password is only used for HTTP API and SMPP.
 */
+ (NSString *)connectionPasswordResetForID:(NSString *)connectionID;

#pragma mark - Pricelist

/*
	The API offers the ability to see every revision made of price lists for 
	each connection. When specifying a revision ID one can fetch the detailed 
	price list at that point in time. If authenticated using a User token, 
	a connection ID needs to be provided too.
 */
+ (NSString *)pricelistCurrentWithID:(NSString *)connectionID;

/*
	For simplicity the tag "me" can be used to select the default assigned 
	connection for the User.
 */
+ (NSString *)pricelistCurrentMe;

/*
	Receive all price lists revisions for a specific connection related to
	the authenticated user.
 */
+ (NSString *)pricelistAllForID:(NSString *)connectionID;

/*
	A connection ID or alias tag "me" must be provided as reference.
 */
+ (NSString *)pricelistAllMe;

/*
	Receive price list (.csv) for given connection.
 */
+ (NSString *)pricelistCSVForID:(NSString *)connectionID;

#pragma mark - Users

/*
	Get details regarding your user.
 */
+ (NSString *)userMe;

/*
	Update email for your user.
 */
+ (NSString *)updateUserEmail;

/*
	Update user password.
 */
+ (NSString *)updateUserPassword;

/*
	If you have forgotten or in other ways lost control over your password, 
	you can issue a reset. When doing so, Beepsend will send an email with 
	a link to where you can get your new password.
 */
+ (NSString *)resetPassword;
+ (NSString *)setNewPasswordWithHash:(NSString *)hash;

/*
	If you think that the user token used for authenticating with the 
	Beepsend API has been compromised you can use this method (with your 
	current user token and password) to reset the user token.
 */
+ (NSString *)resetTokenMe;
+ (NSString *)resetTokenForID:(NSString *)userID;

#pragma mark - Send SMS

/*
	A message can carry 160 characters if in the Latin alphabet and 
	70 if content is Unicode. The Beepsend Gateway will automatically split up 
	the message if the content exceeds the maximum character limit based on 
	the content encoding. When sending UTF-8 or Unicode encoding 
	the Beepsend Gateway will try and convert to GSM7 if possible 
	to avoid splitting at 70 characters.
 */
+ (NSString *)sms;

#pragma mark - HLR

/*
	If you have an HLR connection set up with Beepsend this can be used
	to make HLR queries. You still need to identify which connection to use
	as HLR connection for submissions, either by setting the Connection ID or
	by using the "me" alias if your HLR connection is the default connection 
	for the User token.
 */
+ (NSString *)hlrForNumber:(NSString *)number;

#pragma mark - Estimate SMS cost

/*
	Each estimation require a token either assigned to a Connection or a User 
	that has a default connection set up. By specifying a label of a different
	Connection belonging to your Company this will instead be used, granted 
	the User has access-rights to this Connection. If authenticated by
	User token and no Connection is specified, the default assigned Connection
	will be used.
 */
+ (NSString *)smsCostEstimate;

@end
