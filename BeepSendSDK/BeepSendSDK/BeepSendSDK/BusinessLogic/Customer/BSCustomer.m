//
//  BSCustomerModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSCustomer.h"

@interface BSCustomer ()

@property (nonatomic, strong, readwrite) NSString *customerID;
@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, strong, readwrite) NSString *phoneNumber;
@property (nonatomic, strong, readwrite) NSString *address;
@property (nonatomic, strong, readwrite) NSString *city;
@property (nonatomic, strong, readwrite) NSString *postBox;
@property (nonatomic, strong, readwrite) NSString *country;
@property (nonatomic, strong, readwrite) NSString *vat;
@property (nonatomic, strong, readwrite) NSString *email;
@property (nonatomic, strong, readwrite) NSString *type;

@property (nonatomic, strong, readwrite) BSAccountManager *accountManager;

@property (nonatomic, strong, readwrite) BSPriceListDetails *priceListDetails;

@end

@implementation BSCustomer

- (NSString *)customerID
{
	return [_customerID isEqual:[NSNull null]]||_customerID==nil?@"":_customerID;
}

- (NSString *)name
{
	return [_name isEqual:[NSNull null]]||_name==nil?@"":_name;
}

- (NSString *)phoneNumber
{
	return [_phoneNumber isEqual:[NSNull null]]||_phoneNumber==nil?@"":_phoneNumber;
}

- (NSString *)address
{
	return [_address isEqual:[NSNull null]]||_address==nil?@"":_address;
}

- (NSString *)city
{
	return [_city isEqual:[NSNull null]]||_city==nil?@"":_city;
}

- (NSString *)postBox
{
	return [_postBox isEqual:[NSNull null]]||_postBox==nil?@"":_postBox;
}

- (NSString *)country
{
	return [_country isEqual:[NSNull null]]||_country==nil?@"":_country;
}

- (NSString *)vat
{
	return [_vat isEqual:[NSNull null]]||_vat==nil?@"":_vat;
}

- (NSString *)email
{
	return [_email isEqual:[NSNull null]]||_email==nil?@"":_email;
}

- (NSString *)type
{
	return [_type isEqual:[NSNull null]]||_type==nil?@"":_type;
}

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular customer"]) {
		_customerID = @"-1";
	}
	return self;
}

- (BSCustomer *)initCustomerWithID:(NSString *)cID
							  name:(NSString *)cName
							 phone:(NSString *)cPhone
						   address:(NSString *)cAddress
							  city:(NSString *)cCity
						   postBox:(NSString *)cPostBox
						   country:(NSString *)cCountry
							   vat:(NSString *)cVat
							 email:(NSString *)cEmail
					   invoiceType:(NSString *)cInvoiceType
					accountManager:(BSAccountManager *)cAccountManager
				  priceListDetails:(BSPriceListDetails *)cPriceListModel
{
	if (self = [super initWithID:cID andTitle:cName]) {
		_customerID = cID;
		_name = cName;
		_phoneNumber = cPhone;
		_address = cAddress;
		_city = cCity;
		_postBox = cPostBox;
		_country = cCountry;
		_vat = cVat;
		_email = cEmail;
		_type = cInvoiceType;
		
		_accountManager = cAccountManager;
		
		_priceListDetails = cPriceListModel;
	}
	return self;
}

@end
