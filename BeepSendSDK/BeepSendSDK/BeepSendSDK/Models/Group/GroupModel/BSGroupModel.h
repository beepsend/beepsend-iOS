//
//  BSGroupModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

@interface BSGroupModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSNumber *contactsCount;
@property (nonatomic, strong, readonly) NSNumber *processing;

- (BSGroupModel *)initGroupWithID:(NSString *)gID
							 name:(NSString *)gName
						 contacts:(NSNumber *)gContactsCount
					   processing:(NSNumber *)gProcessing;

- (BSGroupModel *)initGroupWithName:(NSString *)gName;

- (BSGroupModel *)initGroupWithID:(NSString *)gID
							 name:(NSString *)gName
						 contacts:(NSNumber *)gContactsCount;

@end
