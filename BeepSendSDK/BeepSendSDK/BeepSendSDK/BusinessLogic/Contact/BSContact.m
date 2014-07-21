//
//  BSContactModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/25/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSContact.h"

#import "BSContactsService.h"

@interface BSContact ()

@property (nonatomic, strong) NSString *oldPhoneNumber;
@property (nonatomic, strong) NSString *oldFirstName;
@property (nonatomic, strong) NSString *oldLastName;
@property (nonatomic, strong) BSGroup *oldGroup;

@property (nonatomic, strong, readwrite) NSString *contactID;
@property (nonatomic, strong, readwrite) NSArray *errors;

@end

@implementation BSContact

#pragma mark - Properties

- (NSString *)contactID
{
	return [BSHelper isNilOrEmpty:_contactID] ? @"0" : [_contactID isKindOfClass:[NSNumber class]] ? [(NSNumber *)_contactID stringValue] : _contactID;
}

- (NSArray *)errors
{
	return _errors ? _errors : @[];
}

- (NSString *)firstName
{
	return [BSHelper isNilOrEmpty:_firstName] ? @"" : _firstName;
}

- (NSString *)lastName
{
	return [BSHelper isNilOrEmpty:_lastName] ? @"" : _lastName;
}

- (NSString *)phoneNumber
{
	return [BSHelper isNilOrEmpty:_phoneNumber] ? @"" : _phoneNumber;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular contact"]) {
		
	}
	return self;
}

- (BSContact *)initContactWithID:(NSString *)cID
					   firstName:(NSString *)firstName
						lastName:(NSString *)lastName
					 phoneNumber:(NSString *)phoneNumber
						   group:(BSGroup *)group
						  errors:(NSArray *)errors
{
	if (self = [super initWithID:cID andTitle:firstName]) {
		_contactID = cID;
		_firstName = firstName;
		_lastName = lastName;
		_phoneNumber = phoneNumber;
		_group = group;
		_errors = errors;
		
		_oldFirstName = firstName;
		_oldLastName = lastName;
		_oldPhoneNumber = phoneNumber;
		_oldGroup = group;
	}
	return self;
}

- (BSContact *)initContactWithPhoneNumber:(NSString *)phoneNumber
								firstName:(NSString *)firstName
								 lastName:(NSString *)lastName
									group:(BSGroup *)group
{
	if (self = [super initWithID:@"0" andTitle:firstName]) {
		_contactID = @"0";
		_firstName = firstName;
		_lastName = lastName;
		_phoneNumber = phoneNumber;
		_group = group;
		
		_oldFirstName = firstName;
		_oldLastName = lastName;
		_oldPhoneNumber = phoneNumber;
		_oldGroup = group;
	}
	return self;
}

#pragma mark - Public methods

- (void)updateContact
{
	if (!_contactID || [_contactID isEqualToString:@"0"]) {
		return; //Group needs to be saved first
	}
	
	if ([_phoneNumber isEqualToString:_phoneNumber] &&
		[_firstName isEqualToString:_oldFirstName] &&
		[_lastName isEqualToString:_oldLastName] &&
		[_group.groupID isEqualToString:_oldGroup.groupID]) {
		return; //No changes were made
	}
	
	[[BSContactsService sharedService] updateContact:self
										  withNumber:_phoneNumber
										   firstName:_firstName
											lastName:_lastName
											 groupID:_group.groupID
								 withCompletionBlock:^(BSContact *contact, id error) {
									 
									 if (error) {
										 _phoneNumber = _oldPhoneNumber;
										 _firstName = _oldFirstName;
										 _lastName = _oldLastName;
										 _group = _oldGroup;
									 }
									 else {
										 _oldGroup = _group;
										 _oldFirstName = _firstName;
										 _oldLastName = _lastName;
										 _oldPhoneNumber = _phoneNumber;
									 }
	}];
}

- (void)saveContact
{
	if (_contactID && ![_contactID isEqualToString:@"0"]) {
		return; //Contact already exists
	}
	
	[[BSContactsService sharedService] addContact:self withCompletionBlock:^(BSContact *contact, id error) {
		if (!error) {
			_contactID = contact.contactID;
		}
	}];
}

- (void)removeContact
{
	if (!_contactID	|| [_contactID isEqualToString:@"0"]) {
		return; //Contact needs to be saved first
	}
	
	[[BSContactsService sharedService] deleteContact:self withCompletionBlock:^(BOOL success, id error) {
		if (!error) {
			_contactID = @"0";
		}
	}];
}

@end
