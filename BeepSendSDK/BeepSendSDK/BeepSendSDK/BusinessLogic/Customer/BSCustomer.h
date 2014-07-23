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

/** ID.
 */
@property (nonatomic, strong, readonly) NSString *customerID;

/** Name.
 */
@property (nonatomic, strong, readonly) NSString *name;

/** Phone number.
 */
@property (nonatomic, strong, readonly) NSString *phoneNumber;

/** Street address.
 */
@property (nonatomic, strong, readonly) NSString *address;

/** City.
 */
@property (nonatomic, strong, readonly) NSString *city;

/** Post code.
 */
@property (nonatomic, strong, readonly) NSString *postBox;

/** Country.
 */
@property (nonatomic, strong, readonly) NSString *country;

/** VAT number.
 */
@property (nonatomic, strong, readonly) NSString *vat;

/** Email.
 */
@property (nonatomic, strong, readonly) NSString *email;

/** pre-pay or post-pay.
 */
@property (nonatomic, strong, readonly) NSString *type;

/** Customer account manager
 */
@property (nonatomic, strong, readonly) BSAccountManager *accountManager;

/** Pricelist details
 */
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
