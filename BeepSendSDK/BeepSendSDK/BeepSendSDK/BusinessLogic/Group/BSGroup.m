//
//  BSGroupModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGroup.h"

#import "BSGroupsService.h"

@interface BSGroup ()

@property (nonatomic, strong) NSString *oldName;

@property (nonatomic, strong, readwrite) NSString *groupID;
@property (nonatomic, strong, readwrite) NSNumber *contactsCount;
@property (nonatomic, strong, readwrite) NSNumber *processing;

@property (atomic, assign) NSInteger errorCount;
@property (atomic, strong) NSMutableArray *errors;
@property (atomic, strong) NSMutableArray *contactsToAdd;

@property (atomic, assign) BOOL processingContacts;

@end

@implementation BSGroup

#pragma mark - Properties

- (NSString *)groupID
{
	return [BSHelper isNilOrEmpty:_groupID] ? @"0" : [_groupID isKindOfClass:[NSNumber class]] ? [(NSNumber *)_groupID stringValue] : _groupID;
}

- (NSString *)name
{
	return [BSHelper isNilOrEmpty:_name] ? @"" : _name;
}

- (NSNumber *)contactsCount
{
	return _contactsCount ? _contactsCount : @0;
}

- (NSNumber *)processing
{
	return _processing ? _processing : @0;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular group"]) {
		
	}
	return self;
}

- (BSGroup *)initGroupWithID:(NSString *)gID
							 name:(NSString *)gName
						 contacts:(NSNumber *)gContactsCount
					   processing:(NSNumber *)gProcessing
{
	if (self = [super initWithID:gID andTitle:gName]) {
		_groupID = gID;
		_name = gName;
		_oldName = gName;
		_contactsCount = gContactsCount;
		_processing = gProcessing;
	}
	return self;
}

- (BSGroup *)initGroupWithName:(NSString *)gName
{
	if (self = [super initWithID:@"0" andTitle:gName]) {
		_groupID = @"0";
		_name = gName;
		_oldName = gName;
	}
	return self;
}

- (BSGroup *)initGroupWithID:(NSString *)gID
							 name:(NSString *)gName
						 contacts:(NSNumber *)gContactsCount
{
	if (self = [super initWithID:gID andTitle:gName]) {
		_groupID = gID;
		_name = gName;
		_oldName = gName;
		_contactsCount = gContactsCount;
	}
	return self;
}

#pragma mark - Public methods

- (void)updateGroupOnCompletion:(void (^)(BSGroup *, NSArray *))block
{
	if (!_groupID || [_groupID isEqualToString:@"0"]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:@"Group needs to be saved first!"];
		block(nil, @[error]);
				
		return; //Group needs to be saved first
	}
	
	if ([_name isEqualToString:_oldName]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:@"No changes were made!"];
		block(nil, @[error]);
		
		return; //No changes were made
	}
	
	[[BSGroupsService sharedService] updateName:_name
										inGroup:self
							withCompletionBlock:^(BSGroup *group, NSArray *errors) {
								
								if (!errors || errors.count==0) {
									_oldName = group.name;
									
									block(group, nil);
								}
								else {
									_name = _oldName;
									block(nil, errors);
								}
	}];
}

- (void)saveGroupOnCompletion:(void (^)(BSGroup *, NSArray *))block
{
	if (_groupID && ![_groupID isEqualToString:@"0"]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:@"Group already exist!"];
		block(nil, @[error]);
		
		return; //Group already exists
	}
	
	if ([BSHelper isNilOrEmpty:_name]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:@"Enter group name!"];
		block(nil, @[error]);
		
		return;
	}
	
	[[BSGroupsService sharedService] addGroupNamed:_name
							   withCompletionBlock:^(BSGroup *group, NSArray *errors) {
		
								   if (!errors || errors.count==0) {
									   _groupID = group.groupID;
									   
									   block(group, nil);
								   }
								   else {
									   block(nil, errors);
								   }
	}];
}

- (void)removeGroupOnCompletion:(void (^)(BOOL, NSArray *))block
{
	if (!_groupID || [_groupID isEqualToString:@"0"]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:@"Group doesn't exist!"];
		block(NO, @[error]);
		
		return; //Group needs to be saved first
	}
	
	[[BSGroupsService sharedService] deleteGroup:self
							 withCompletionBlock:^(BOOL success, NSArray *errors) {
		
								 if (!errors || errors.count==0) {
									 _groupID = @"0";
									 
									 block(YES, nil);
								 }
								 else {
									 block(NO, errors);
								 }
	}];
}

- (void)addContact:(BSContact *)contact onCompletion:(void (^)(BSContact *, NSArray *))block
{
	if (!contact) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:@"Contact missing!"];
		block(nil, @[error]);
		
		return;
	}
	
	contact.group = self;
	[contact updateContactOnCompletion:^(BSContact *contact, NSArray *errors) {
		
		if (!errors || errors.count==0) {
			block(contact, nil);
		}
		else {
			block(nil, errors);
		}
	}];
	
	_contactsCount = [NSNumber numberWithInteger:(_contactsCount.integerValue+1)];
}

- (void)addContacts:(NSArray *)contacts onCompletion:(void (^)(NSArray *, NSArray *))block
{
	if (!contacts || contacts.count <= 0) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:@"Contacts missing!"];
		block(nil, @[error]);
		
		return;
	}
	
	BOOL nonContactObject = NO;
	for (id object in contacts) {
		if (!([object isKindOfClass:[BSContact class]])) {
			nonContactObject = YES;
		}
	}
	if (nonContactObject) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:@"Only contact objects can be added!"];
		block(nil, @[error]);
		
		return;
	}
	
	if (_processingContacts) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:@"Processing contacts..."];
		block(nil, @[error]);
		
		return;
	}
	
	_processingContacts = YES;
	
	_contactsToAdd = [@[] mutableCopy];
	_errorCount = 0;
	_errors = [@[] mutableCopy];
	
	for (BSContact *contact in contacts) {
		contact.group = self;
		[contact updateContactOnCompletion:^(BSContact *contact, NSArray *errors) {
			
			if (errors && errors.count > 0) {
				_errorCount++;
				[_errors addObjectsFromArray:errors];
			}
			else {
				[_contactsToAdd addObject:contact];
			}
			
			if (contacts.count == _contactsToAdd.count+_errorCount) {
				
				block(_contactsToAdd, _errors);
				
				_processingContacts = NO;
			}
		}];
	}
	
	_contactsCount = [NSNumber numberWithInteger:(_contactsCount.integerValue+contacts.count)];
}

- (void)removeContact:(BSContact *)contact onCompletion:(void (^)(BOOL, NSArray *))block
{
	if (!contact || [contact.contactID isEqualToString:@"0"] || [contact.contactID isEqualToString:@"-1"]) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:@"Contacts missing!"];
		block(NO, @[error]);
		
		return;
	}
	
	contact.group = nil;
	[contact updateContactOnCompletion:^(BSContact *contact, NSArray *errors) {
		if (errors && errors.count>0) {
			block(NO, errors);
		}
		else {
			block(YES, nil);
		}
	}];
	
	_contactsCount = [NSNumber numberWithInteger:(_contactsCount.integerValue+1)];
}

- (void)removeContacts:(NSArray *)contacts onCompletion:(void (^)(BOOL, NSArray *))block
{
	if (!contacts || contacts.count <= 0) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:@"Contacts missing!"];
		block(NO, @[error]);
		
		return;
	}
	
	BOOL nonContactObject = NO;
	for (id object in contacts) {
		if (!([object isKindOfClass:[BSContact class]])) {
			nonContactObject = YES;
		}
	}
	if (nonContactObject) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:@"Only contact objects can be deleted!"];
		block(NO, @[error]);
		
		return;
	}
	
	
	if (_processingContacts) {
		
		BSError *error = [[BSError alloc] initWithCode:@0 andDescription:@"Processing contacts..."];
		block(NO, @[error]);

		return;
	}
	
	_errorCount = 0;
	_errors = [@[] mutableCopy];
	
	for (BSContact *contact in contacts) {
		contact.group = nil;
		[contact updateContactOnCompletion:^(BSContact *contact, NSArray *errors) {
			
			if (errors && errors.count > 0) {
				_errorCount++;
				[_errors addObjectsFromArray:errors];
			}
			
			if (_errors.count > 0) {
				block(NO, _errors);
			}
			else {
				block(YES, nil);
			}
			_processingContacts = NO;
		}];
	}
	
	_contactsCount = [NSNumber numberWithInteger:(_contactsCount.integerValue+contacts.count)];
}

@end
