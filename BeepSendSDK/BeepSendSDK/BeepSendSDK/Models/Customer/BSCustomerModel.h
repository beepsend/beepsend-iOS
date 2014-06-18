//
//  BSCustomerModel.h
//  BeepSendSDK
//
//  Created by Vladica Pesic on 6/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGeneralModel.h"

#import "BSAccountManagerModel.h"
#import "BSCustomerPriceListModel.h"

@interface BSCustomerModel : BSGeneralModel

@property (nonatomic, strong) NSString *customerName;
@property (nonatomic, strong) NSString *customerPhoneNumber;
@property (nonatomic, strong) NSString *customerAddress;
@property (nonatomic, strong) NSString *customerCity;
@property (nonatomic, strong) NSString *customerPostBox;
@property (nonatomic, strong) NSString *customerCountry;
@property (nonatomic, strong) NSString *customerVAT;
@property (nonatomic, strong) NSString *customerEmail;
@property (nonatomic, strong) NSString *customerInvoiceType;

@property (nonatomic, strong) BSAccountManagerModel *customerAccountManager;

@property (nonatomic, strong) BSCustomerPriceListModel *customerPriceListDetails;

@end
