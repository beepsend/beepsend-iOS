//
//  BSNumber.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 9/1/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@class BSConnection;
@class BSCountry;

@interface BSNumber : BSGeneralModel

@property (nonatomic, strong, readonly) BSConnection *connection;
@property (nonatomic, strong, readonly) BSCountry *country;
@property (nonatomic, strong, readonly) NSString *numberID;
@property (nonatomic, strong, readonly) NSNumber *recipientNumber;

- (BSNumber *)initWithID:(NSString *)nID
				 country:(BSCountry *)nCountry
			  connection:(BSConnection *)nConnection
	  andRecipientNumber:(NSNumber *)nNumber;

@end
