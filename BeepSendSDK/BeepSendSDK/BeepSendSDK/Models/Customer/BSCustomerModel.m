//
//  BSCustomerModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSCustomerModel.h"

@implementation BSCustomerModel

#pragma mark - Initialization

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	if (self = [super initWithDictionary:dictionary]) {
		
	}
	return self;
}
//{
//    "id": 1,
//    "phone": "46406007500",
//    "name": "Beepsend AB",
//    "address": "Gustav Adolfs Torg 12",
//    "city": "Malmö",
//    "post_box": "21139",
//    "country": "Sweden",
//    "vat": "",
//    "email": "beepsend@beepsend.se",
//    "invoice_type": "pre-pay",
//    "account_manager": {
//        "name": "Account Manager",
//        "email": "account.manager@beepsend.se"
//    },
//    "pricelist_type": 1,
//    "pricelist_delimiter": null,
//    "pricelist_schedule": {
//        "id": 1,
//        "name": "Immediately"
//    },
//    "pricelist_fields": []
//}
@end
