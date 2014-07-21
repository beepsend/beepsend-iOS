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

- (void)updateGroup
{
	if (!_groupID || [_groupID isEqualToString:@"0"]) {
		return; //Group needs to be saved first
	}
	
	if ([_name isEqualToString:_oldName]) {
		return; //No changes were made
	}
	
	[[BSGroupsService sharedService] updateName:_name
										inGroup:self
							withCompletionBlock:^(BSGroup *group, id error) {
								
								if (!error) {
									_oldName = group.name;
								}
								else {
									_name = _oldName;
								}
	}];
}

- (void)saveGroup
{
	if (_groupID && ![_groupID isEqualToString:@"0"]) {
		return; //Group already exists
	}
	
	[[BSGroupsService sharedService] addGroupNamed:_name
							   withCompletionBlock:^(BSGroup *group, id error) {
		
								   if (!error) {
									   _groupID = group.groupID;
								   }
	}];
}

- (void)removeGroup
{
	if (!_groupID || [_groupID isEqualToString:@"0"]) {
		return; //Group needs to be saved first
	}
	
	[[BSGroupsService sharedService] deleteGroup:self
							 withCompletionBlock:^(BOOL success, id error) {
		
								 if (!error) {
									 _groupID = @"0";
								 }
	}];
}

- (void)addContact:(BSContact *)contact
{
	contact.group = self;
	[contact updateContact];
	
	_contactsCount = [NSNumber numberWithInteger:(_contactsCount.integerValue+1)];
}

- (void)addContacts:(NSArray *)contacts
{
	for (BSContact *contact in contacts) {
		contact.group = self;
		[contact updateContact];
	}
	
	_contactsCount = [NSNumber numberWithInteger:(_contactsCount.integerValue+contacts.count)];
}

- (void)removeContact:(BSContact *)contact
{
	contact.group = nil;
	[contact updateContact];
	
	_contactsCount = [NSNumber numberWithInteger:(_contactsCount.integerValue+1)];
}

- (void)removeContacts:(NSArray *)contacts
{
	for (BSContact *contact in contacts) {
		contact.group = nil;
		[contact updateContact];
	}
	
	_contactsCount = [NSNumber numberWithInteger:(_contactsCount.integerValue+contacts.count)];
}

@end
