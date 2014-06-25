//
//  ContactsService.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSContactsService.h"

#import "BSAPIConfiguration.h"

#import "BSAPContact.h"

@implementation BSContactsService

#pragma mark - Initialization

+ (instancetype)sharedService
{
	static id singleton;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		singleton = [[[self class] alloc] init];
	});
	return singleton;
}

#pragma mark - Public methods

- (void)getAllContactsWithCompletionBlock:(void(^)(NSArray *contacts, id error))block
{
	[super executeGETForMethod:[BSAPIConfiguration contacts]
				withParameters:@{}
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  NSMutableArray *mArr = [@[] mutableCopy];
						  for (BSAPContact *con in [BSAPContact arrayOfObjectsFromArrayOfDictionaries:response]) {
							  [mArr addObject:[con convertToContactModel]];
						  }
						  block([NSArray arrayWithArray:mArr], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}

- (void)addContact:(BSContactModel *)contact withCompletionBlock:(void(^)(BSContactModel *contact, id error))block
{
	NSDictionary *contactToAdd = [[BSAPContact contactFromContactModel:contact] dictFromClass];
	
	[super executePOSTForMethod:[BSAPIConfiguration contacts]
				withParameters:contactToAdd
				  onCompletion:^(id response, id error) {
					  
					  if (!error) {
						  
						  block([[BSAPContact classFromDict:response] convertToContactModel], error);
					  }
					  else {
						  //TODO: Create error handling
						  block(nil, response);
					  }
				  }];
}
/*
- (void)addContacts:(NSArray *)contacts withCompletionBlock:(void(^)(id response, id error))block
{
	NSMutableArray *mArr = [@[] mutableCopy];
	for (BSContactModel *model in contacts) {
		[mArr addObject:[[BSAPContact contactFromContactModel:model] dictFromClass]];
	}
	
	[super executePOSTForMethod:[BSAPIConfiguration contacts]
				 withParameters:mArr
				   onCompletion:^(id response, id error) {
					   
					   if (!error) {
						   
						   block(response, error);
					   }
					   else {
						   //TODO: Create error handling
						   block(nil, response);
					   }
				   }];
}
*/
@end
