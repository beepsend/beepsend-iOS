//
//  BSAPGroup.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/26/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSGroupModel.h"

@interface BSAPGroup : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *contacts_count;
@property (nonatomic, strong) NSNumber *processing;

+ (NSArray *)arrayOfObjectsFromArrayOfDictionaries:(NSArray *)array;

- (BSGroupModel *)convertToGroupModel;
+ (BSAPGroup *)groupFromGroupModel:(BSGroupModel *)groupModel;

@end
