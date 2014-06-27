//
//  BSAPCustomer.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/18/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSerializableObject.h"

#import "BSAPCAccountManager.h"
#import "BSAPCPriceListSchedule.h"

@interface BSAPCustomer : BSSerializableObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *post_box;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *vat;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *invoice_type;
@property (nonatomic, strong) BSAPCAccountManager *account_manager;
@property (nonatomic, strong) NSNumber *pricelist_type;
@property (nonatomic, strong) NSString *pricelist_delimiter;
@property (nonatomic, strong) BSAPCPriceListSchedule *pricelist_schedule;
@property (nonatomic, strong) NSArray *pricelist_fields;

@end
