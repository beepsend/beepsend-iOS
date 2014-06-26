//
//  BSAPGroup.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPGroup.h"

@implementation BSAPGroup

#pragma mark - Public methods

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array
{
	NSMutableArray *results = [@[] mutableCopy];
	for (id object in array) {
		[results addObject:[BSAPGroup classFromDict:object]];
	}
	return [NSArray arrayWithArray:results];
}

- (BSGroupModel *)convertToGroupModel
{
	BSGroupModel *group = [[BSGroupModel alloc] initGroupWithID:_id
														   name:_name
													   contacts:_contacts_count
													 processing:_processing];
	
	return group;
}

+ (BSAPGroup *)groupFromGroupModel:(BSGroupModel *)groupModel
{
	BSAPGroup *group = [[BSAPGroup alloc] init];
	
	if ([groupModel.objectID isEqualToString:@"-1"]) {
		return group;
	}
	
	group.id = [groupModel.objectID isEqualToString:@"0"] ? nil : groupModel.objectID;
	group.name = groupModel.name;
	group.contacts_count = groupModel.contactsCount;
	group.processing = groupModel.processing;
	
	return group;
}

@end
