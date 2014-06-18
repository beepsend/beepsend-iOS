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
#import "BSConnectionsService.h"

@interface BeepSendSDKTests : XCTestCase

@end

@implementation BeepSendSDKTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Test methods

- (void)testConnectionsMe
{
	[[BSConnectionsService sharedService] getConnectionOnCompletion:^(id response, id error) {
		BSLog(@"%@", response);
		[[BSTestSemaphor sharedInstance] lift:@"GetConnectionsOnCompletion"];
	}];
	[[BSTestSemaphor sharedInstance] waitForKey:@"GetConnectionsOnCompletion"];
}

@end
