//
//  BSAPCustomer.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/18/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSAPCustomer.h"

@implementation BSAPCustomer

#pragma mark - Inherited methods

+ (id)classFromDict:(NSDictionary *)dictionary
{
	//We need to register all classes before load
	[BSAPCAccountManager class];
	[BSAPCPriceListSchedule class];
	
	return [super classFromDict:dictionary];
}

#pragma mark - Public methods

- (BSCustomerModel *)convertToCustomerModel
{
	
	BSPriceListScheduleModel *pricelistSchedule = [[BSPriceListScheduleModel alloc] initPricelistScheduleWithID:_pricelist_schedule.id
																										andName:_pricelist_schedule.name];
	
	BSPriceListDetailsModel *customerPricelistDetails = [[BSPriceListDetailsModel alloc] initPricelistDetailsWithType:_pricelist_type
																											delimiter:_pricelist_delimiter
																									pricelistSchedule:pricelistSchedule
																											   fields:_pricelist_fields];
	
	BSAccountManagerModel *accountManager = [[BSAccountManagerModel alloc] initAccountManagerWithName:_account_manager.name
																							 andEmail:_account_manager.email];
	
	BSCustomerModel *customer = [[BSCustomerModel alloc] initCustomerWithID:_id
																	   name:_name
																	  phone:_phone
																	address:_address
																	   city:_city
																	postBox:_post_box
																	country:_country
																		vat:_vat
																	  email:_email
																invoiceType:_invoice_type
															 accountManager:accountManager
														   priceListDetails:customerPricelistDetails];
		
	return customer;
}

@end
