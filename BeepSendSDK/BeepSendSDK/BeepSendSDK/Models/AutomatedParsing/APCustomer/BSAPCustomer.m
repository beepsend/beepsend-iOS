//
//  BSAPCustomer.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/18/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPCustomer.h"

#import "BSCustomerModel.h"

@implementation BSAPCustomer

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	//We need to register all classes before load
	[BSAPCAccountManager class];
	[BSAPCPriceListSchedule class];
	
	return [super classFromDict:dictionary];
}

- (id)convertToModel
{
	BSPriceListDetailsModel *customerPricelistDetails =
	[[BSPriceListDetailsModel alloc] initPricelistDetailsWithType:_pricelist_type
														delimiter:_pricelist_delimiter
												pricelistSchedule:[_pricelist_schedule convertToModel]
														   fields:_pricelist_fields];
	
	return [[BSCustomerModel alloc] initCustomerWithID:_id name:_name phone:_phone address:_address city:_city postBox:_post_box country:_country vat:_vat email:_email invoiceType:_invoice_type accountManager:[_account_manager convertToModel] priceListDetails:customerPricelistDetails];
}

#pragma mark - Public methods

@end
