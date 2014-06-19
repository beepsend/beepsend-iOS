//
//  BSCustomerModel.m
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSCustomerModel.h"

@interface BSCustomerModel ()

@property (nonatomic, strong, readwrite) NSString *customerName;
@property (nonatomic, strong, readwrite) NSString *customerPhoneNumber;
@property (nonatomic, strong, readwrite) NSString *customerAddress;
@property (nonatomic, strong, readwrite) NSString *customerCity;
@property (nonatomic, strong, readwrite) NSString *customerPostBox;
@property (nonatomic, strong, readwrite) NSString *customerCountry;
@property (nonatomic, strong, readwrite) NSString *customerVAT;
@property (nonatomic, strong, readwrite) NSString *customerEmail;
@property (nonatomic, strong, readwrite) NSString *customerInvoiceType;

@property (nonatomic, strong, readwrite) BSAccountManagerModel *customerAccountManager;

@property (nonatomic, strong, readwrite) BSCustomerPriceListModel *customerPriceListDetails;

@end

@implementation BSCustomerModel

#pragma mark - Initialization

- (instancetype)initWithID:(NSString *)objectID andTitle:(NSString *)title
{
	if (self = [super initWithID:@"-1" andTitle:@"Irregular customer"]) {
		
	}
	return self;
}

- (BSCustomerModel *)initCustomerWithID:(NSString *)cID
								   name:(NSString *)cName
								  phone:(NSString *)cPhone
								address:(NSString *)cAddress
								   city:(NSString *)cCity
								postBox:(NSString *)cPostBox
								country:(NSString *)cCountry
									vat:(NSString *)cVat
								  email:(NSString *)cEmail
							invoiceType:(NSString *)cInvoiceType
						 accountManager:(BSAccountManagerModel *)cAccountManager
					   priceListDetails:(BSCustomerPriceListModel *)cPriceListModel
{
	if (self = [super initWithID:cID andTitle:cName]) {
		_customerName = cName;
		_customerPhoneNumber = cPhone;
		_customerAddress = cAddress;
		_customerCity = cCity;
		_customerPostBox = cPostBox;
		_customerCountry = cCountry;
		_customerVAT = cVat;
		_customerEmail = cEmail;
		_customerInvoiceType = cInvoiceType;
		
		_customerAccountManager = cAccountManager;
		
		_customerPriceListDetails = cPriceListModel;
	}
	return self;
}

@end
