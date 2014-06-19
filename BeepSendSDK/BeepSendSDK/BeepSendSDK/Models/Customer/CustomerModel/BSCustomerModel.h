//
//  BSCustomerModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSAccountManagerModel.h"
#import "BSPriceListDetailsModel.h"

@interface BSCustomerModel : BSGeneralModel

@property (nonatomic, strong, readonly) NSString *customerName;
@property (nonatomic, strong, readonly) NSString *customerPhoneNumber;
@property (nonatomic, strong, readonly) NSString *customerAddress;
@property (nonatomic, strong, readonly) NSString *customerCity;
@property (nonatomic, strong, readonly) NSString *customerPostBox;
@property (nonatomic, strong, readonly) NSString *customerCountry;
@property (nonatomic, strong, readonly) NSString *customerVAT;
@property (nonatomic, strong, readonly) NSString *customerEmail;
@property (nonatomic, strong, readonly) NSString *customerInvoiceType;

@property (nonatomic, strong, readonly) BSAccountManagerModel *customerAccountManager;

@property (nonatomic, strong, readonly) BSPriceListDetailsModel *customerPriceListDetails;

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
					   priceListDetails:(BSPriceListDetailsModel *)cPriceListModel;

@end
