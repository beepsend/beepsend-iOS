//
//  BSCustomerModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSAccountManager.h"
#import "BSPriceListDetails.h"

@interface BSCustomer : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *customerID;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *phoneNumber;
@property (nonatomic, strong, readonly) NSString *address;
@property (nonatomic, strong, readonly) NSString *city;
@property (nonatomic, strong, readonly) NSString *postBox;
@property (nonatomic, strong, readonly) NSString *country;
@property (nonatomic, strong, readonly) NSString *vat;
@property (nonatomic, strong, readonly) NSString *email;
@property (nonatomic, strong, readonly) NSString *type;

@property (nonatomic, strong, readonly) BSAccountManager *accountManager;

@property (nonatomic, strong, readonly) BSPriceListDetails *priceListDetails;

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
				  priceListDetails:(BSPriceListDetails *)cPriceListModel;

@end
