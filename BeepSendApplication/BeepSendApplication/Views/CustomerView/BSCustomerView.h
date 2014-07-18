//
//  BSCustomerView.h
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSCustomerView : UIView

@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelNameStatic;

@property (nonatomic, strong) UILabel *labelPhone;
@property (nonatomic, strong) UILabel *labelPhoneStatic;

@property (nonatomic, strong) UILabel *labelAddress;
@property (nonatomic, strong) UILabel *labelAddressStatic;

@property (nonatomic, strong) UILabel *labelCity;
@property (nonatomic, strong) UILabel *labelCityStatic;

@property (nonatomic, strong) UILabel *labelPostBox;
@property (nonatomic, strong) UILabel *labelPostBoxStatic;

@property (nonatomic, strong) UILabel *labelCountry;
@property (nonatomic, strong) UILabel *labelCountryStatic;

@property (nonatomic, strong) UILabel *labelVat;
@property (nonatomic, strong) UILabel *labelVatStatic;

@property (nonatomic, strong) UILabel *labelEmail;
@property (nonatomic, strong) UILabel *labelEmailStatic;

@property (nonatomic, strong) UILabel *labelInvoiceType;
@property (nonatomic, strong) UILabel *labelInvoiceTypeStatic;

@property (nonatomic, strong) UILabel *labelAccountManagerStatic;

@property (nonatomic, strong) UILabel *labelAccountManagerName;
@property (nonatomic, strong) UILabel *labelAccountManagerEmail;

@end
