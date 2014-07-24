//
//  BSCustomerModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSPriceListDetails.h"
#import "BSAccountManager.h"

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

/** Init Customer with ID, name, phone, address, city, post box, country, vat,
	email, invoice type, account manager, pricelist model
 
 @param cID - Customer ID
 @param cName - Name
 @param cPhone - Phone
 @param cAddress - Address
 @param cCity - City
 @param cPostBox - Post box
 @param cCountry - Country
 @param cVat - VAT
 @param cEmail - Email
 @param cInvoiceType - Invoice type
 @param cAccountManager - Account manager
 @param cPriceListModel - Pricelist model
 
 @return Returns Customer object
 */
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
