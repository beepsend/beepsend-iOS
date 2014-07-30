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

@end

@implementation BeepSendSDKTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
	_user = [BSUser currentUser];
	
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Test methods

- (void)testUpdateUserWithConnectionsFetch
{
	[_user getCustomerDetailsOnCompletion:^(BSCustomer *customer, NSArray *errors) {
		
	}];
}

/*
+ (BSUser *)currentUser;
- (void)updateUserOnCompletion:(void(^)(NSArray *errors))block;
- (void)updateUserEmailWithPassword:(NSString *)password
					   onCompletion:(void(^)(NSArray *errors))block;
- (void)changePassword:(NSString *)currentPassword
	   withNewPassword:(NSString *)newPassword
		  onCompletion:(void(^)(NSArray *errors))block;
- (void)resetUserTokenWithPassword:(NSString *)password
					  onCompletion:(void(^)(NSArray *errors))block;
- (void)getAvailableConnectionsOnCompletion:(void(^)(NSArray *connections, NSArray *errors))block;
- (NSArray *)getAvailableConnections;
- (void)getCustomerDetailsOnCompletion:(void(^)(BSCustomer *customer, NSArray *errors))block;
*/

- (void)testConnectionsMe
{

}

@end
