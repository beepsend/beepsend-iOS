//
//  BSCustomerView.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSCustomerView.h"

@implementation BSCustomerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		////////////////////////////////////////////////////////////////////////
		//Main view
		self.backgroundColor = [UIColor clearColor];
		
		UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:frame
														  byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
																cornerRadii:CGSizeMake(kDefaultButtonCornerRadius, kDefaultButtonCornerRadius)];
		CAShapeLayer *maskLayer = [CAShapeLayer layer];
		maskLayer.frame = frame;
		maskLayer.path = [roundedPath CGPath];
		maskLayer.fillColor = [UIColor darkGrayColor].CGColor;
		maskLayer.lineWidth = kDefaultBorderWidth;
		maskLayer.strokeColor = [[UIColor orangeColor] CGColor];
		
		[self.layer addSublayer:maskLayer];
		
		////////////////////////////////////////////////////////////////////////
		//Labels and text fields for name, email and phone
		_labelNameStatic = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, kViewDefaultBorderInset, kDefaultTitleLabelWidth, kDefaultTitleLabelHeight)];
		_labelNameStatic.backgroundColor = [UIColor clearColor];
		_labelNameStatic.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelNameStatic.textColor = [UIColor blackColor];
		_labelNameStatic.textAlignment = NSTextAlignmentRight;
		
		_labelName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelNameStatic.frame)+kSeparatorDefaultSpacing, CGRectGetMinY(_labelNameStatic.frame), frame.size.width - _labelNameStatic.frame.size.width - 2*kViewDefaultBorderInset - kSeparatorDefaultSpacing, kDefaultTitleLabelHeight)];
		_labelName.backgroundColor = [UIColor clearColor];
		_labelName.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelName.textColor = [UIColor whiteColor];
		_labelName.textAlignment = NSTextAlignmentLeft;
		
		[self addSubview:_labelNameStatic];
		[self addSubview:_labelName];
		
		////////////////////////////////////////////////////////////////////////
		
		_labelPhoneStatic = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelNameStatic.frame) + kSeparatorDefaultSpacing, kDefaultTitleLabelWidth, kDefaultTitleLabelHeight)];
		_labelPhoneStatic.backgroundColor = [UIColor clearColor];
		_labelPhoneStatic.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelPhoneStatic.textColor = [UIColor blackColor];
		_labelPhoneStatic.textAlignment = NSTextAlignmentRight;
		
		_labelPhone = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelPhoneStatic.frame)+kSeparatorDefaultSpacing, CGRectGetMinY(_labelPhoneStatic.frame), frame.size.width - _labelPhoneStatic.frame.size.width - 2*kViewDefaultBorderInset - kSeparatorDefaultSpacing, kDefaultTitleLabelHeight)];
		_labelPhone.backgroundColor = [UIColor clearColor];
		_labelPhone.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelPhone.textColor = [UIColor whiteColor];
		_labelPhone.textAlignment = NSTextAlignmentLeft;
		
		[self addSubview:_labelPhoneStatic];
		[self addSubview:_labelPhone];
		
		////////////////////////////////////////////////////////////////////////

		_labelAddressStatic = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelPhoneStatic.frame) + kSeparatorDefaultSpacing, kDefaultTitleLabelWidth, kDefaultTitleLabelHeight)];
		_labelAddressStatic.backgroundColor = [UIColor clearColor];
		_labelAddressStatic.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelAddressStatic.textColor = [UIColor blackColor];
		_labelAddressStatic.textAlignment = NSTextAlignmentRight;
		
		_labelAddress = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelAddressStatic.frame)+kSeparatorDefaultSpacing, CGRectGetMinY(_labelAddressStatic.frame), frame.size.width - _labelAddressStatic.frame.size.width - 2*kViewDefaultBorderInset - kSeparatorDefaultSpacing, kDefaultTitleLabelHeight)];
		_labelAddress.backgroundColor = [UIColor clearColor];
		_labelAddress.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelAddress.textColor = [UIColor whiteColor];
		_labelAddress.textAlignment = NSTextAlignmentLeft;
		_labelAddress.minimumScaleFactor = 10.0/kTextFieldDefaultTextSize;
		_labelAddress.adjustsFontSizeToFitWidth = YES;
		
		[self addSubview:_labelAddressStatic];
		[self addSubview:_labelAddress];

		////////////////////////////////////////////////////////////////////////

		_labelCityStatic = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelAddressStatic.frame) + kSeparatorDefaultSpacing, kDefaultTitleLabelWidth, kDefaultTitleLabelHeight)];
		_labelCityStatic.backgroundColor = [UIColor clearColor];
		_labelCityStatic.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelCityStatic.textColor = [UIColor blackColor];
		_labelCityStatic.textAlignment = NSTextAlignmentRight;
		
		_labelCity = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelCityStatic.frame)+kSeparatorDefaultSpacing, CGRectGetMinY(_labelCityStatic.frame), frame.size.width - _labelCityStatic.frame.size.width - 2*kViewDefaultBorderInset - kSeparatorDefaultSpacing, kDefaultTitleLabelHeight)];
		_labelCity.backgroundColor = [UIColor clearColor];
		_labelCity.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelCity.textColor = [UIColor whiteColor];
		_labelCity.textAlignment = NSTextAlignmentLeft;
		
		[self addSubview:_labelCityStatic];
		[self addSubview:_labelAddress];
		
		////////////////////////////////////////////////////////////////////////
		
		_labelPostBoxStatic = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelCityStatic.frame) + kSeparatorDefaultSpacing, kDefaultTitleLabelWidth, kDefaultTitleLabelHeight)];
		_labelPostBoxStatic.backgroundColor = [UIColor clearColor];
		_labelPostBoxStatic.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelPostBoxStatic.textColor = [UIColor blackColor];
		_labelPostBoxStatic.textAlignment = NSTextAlignmentRight;
		
		_labelPostBox = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelPostBoxStatic.frame)+kSeparatorDefaultSpacing, CGRectGetMinY(_labelPostBoxStatic.frame), frame.size.width - _labelPostBoxStatic.frame.size.width - 2*kViewDefaultBorderInset - kSeparatorDefaultSpacing, kDefaultTitleLabelHeight)];
		_labelPostBox.backgroundColor = [UIColor clearColor];
		_labelPostBox.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelPostBox.textColor = [UIColor whiteColor];
		_labelPostBox.textAlignment = NSTextAlignmentLeft;
		
		[self addSubview:_labelPostBoxStatic];
		[self addSubview:_labelPostBox];
		
		////////////////////////////////////////////////////////////////////////
		
		_labelCountryStatic = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelPostBoxStatic.frame) + kSeparatorDefaultSpacing, kDefaultTitleLabelWidth, kDefaultTitleLabelHeight)];
		_labelCountryStatic.backgroundColor = [UIColor clearColor];
		_labelCountryStatic.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelCountryStatic.textColor = [UIColor blackColor];
		_labelCountryStatic.textAlignment = NSTextAlignmentRight;
		
		_labelCountry = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelCountryStatic.frame)+kSeparatorDefaultSpacing, CGRectGetMinY(_labelCountryStatic.frame), frame.size.width - _labelCountryStatic.frame.size.width - 2*kViewDefaultBorderInset - kSeparatorDefaultSpacing, kDefaultTitleLabelHeight)];
		_labelCountry.backgroundColor = [UIColor clearColor];
		_labelCountry.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelCountry.textColor = [UIColor whiteColor];
		_labelCountry.textAlignment = NSTextAlignmentLeft;
		
		[self addSubview:_labelCountryStatic];
		[self addSubview:_labelCountry];
		
		////////////////////////////////////////////////////////////////////////

		_labelVatStatic = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelCountryStatic.frame) + kSeparatorDefaultSpacing, kDefaultTitleLabelWidth, kDefaultTitleLabelHeight)];
		_labelVatStatic.backgroundColor = [UIColor clearColor];
		_labelVatStatic.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelVatStatic.textColor = [UIColor blackColor];
		_labelVatStatic.textAlignment = NSTextAlignmentRight;
		
		_labelVat = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelVatStatic.frame)+kSeparatorDefaultSpacing, CGRectGetMinY(_labelVatStatic.frame), frame.size.width - _labelVatStatic.frame.size.width - 2*kViewDefaultBorderInset - kSeparatorDefaultSpacing, kDefaultTitleLabelHeight)];
		_labelVat.backgroundColor = [UIColor clearColor];
		_labelVat.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelVat.textColor = [UIColor whiteColor];
		_labelVat.textAlignment = NSTextAlignmentLeft;
		
		[self addSubview:_labelVatStatic];
		[self addSubview:_labelVat];
		
		////////////////////////////////////////////////////////////////////////

		_labelEmailStatic = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelVatStatic.frame) + kSeparatorDefaultSpacing, kDefaultTitleLabelWidth, kDefaultTitleLabelHeight)];
		_labelEmailStatic.backgroundColor = [UIColor clearColor];
		_labelEmailStatic.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelEmailStatic.textColor = [UIColor blackColor];
		_labelEmailStatic.textAlignment = NSTextAlignmentRight;
		
		_labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelEmailStatic.frame)+kSeparatorDefaultSpacing, CGRectGetMinY(_labelEmailStatic.frame), frame.size.width - _labelEmailStatic.frame.size.width - 2*kViewDefaultBorderInset - kSeparatorDefaultSpacing, kDefaultTitleLabelHeight)];
		_labelEmail.backgroundColor = [UIColor clearColor];
		_labelEmail.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelEmail.textColor = [UIColor whiteColor];
		_labelEmail.textAlignment = NSTextAlignmentLeft;
		
		[self addSubview:_labelEmailStatic];
		[self addSubview:_labelEmail];
		
		//////////////////////////////////////////////////////////////////////// 
		
		_labelInvoiceTypeStatic = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelEmailStatic.frame) + kSeparatorDefaultSpacing, kDefaultTitleLabelWidth, kDefaultTitleLabelHeight)];
		_labelInvoiceTypeStatic.backgroundColor = [UIColor clearColor];
		_labelInvoiceTypeStatic.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelInvoiceTypeStatic.textColor = [UIColor blackColor];
		_labelInvoiceTypeStatic.textAlignment = NSTextAlignmentRight;
		
		_labelInvoiceType = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelInvoiceTypeStatic.frame)+kSeparatorDefaultSpacing, CGRectGetMinY(_labelInvoiceTypeStatic.frame), frame.size.width - _labelInvoiceTypeStatic.frame.size.width - 2*kViewDefaultBorderInset - kSeparatorDefaultSpacing, kDefaultTitleLabelHeight)];
		_labelInvoiceType.backgroundColor = [UIColor clearColor];
		_labelInvoiceType.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelInvoiceType.textColor = [UIColor whiteColor];
		_labelInvoiceType.textAlignment = NSTextAlignmentLeft;
		
		[self addSubview:_labelInvoiceTypeStatic];
		[self addSubview:_labelInvoiceType];
		
		////////////////////////////////////////////////////////////////////////
		
		_labelAccountManagerStatic = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelInvoiceTypeStatic.frame) + kSeparatorDefaultSpacing, frame.size.width - 2*kViewDefaultBorderInset, kDefaultTitleLabelHeight)];
		_labelAccountManagerStatic.backgroundColor = [UIColor clearColor];
		_labelAccountManagerStatic.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelAccountManagerStatic.textColor = [UIColor blackColor];
		_labelAccountManagerStatic.textAlignment = NSTextAlignmentCenter;
		
		[self addSubview:_labelAccountManagerStatic];
		
		_labelAccountManagerName = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelAccountManagerStatic.frame), frame.size.width - 2*kViewDefaultBorderInset, kDefaultTitleLabelHeight)];
		_labelAccountManagerName.backgroundColor = [UIColor clearColor];
		_labelAccountManagerName.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelAccountManagerName.textColor = [UIColor whiteColor];
		_labelAccountManagerName.textAlignment = NSTextAlignmentLeft;
		
		[self addSubview:_labelAccountManagerName];
		
		_labelAccountManagerEmail = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelAccountManagerName.frame), frame.size.width - 2*kViewDefaultBorderInset, kDefaultTitleLabelHeight)];
		_labelAccountManagerEmail.backgroundColor = [UIColor clearColor];
		_labelAccountManagerEmail.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelAccountManagerEmail.textColor = [UIColor whiteColor];
		_labelAccountManagerEmail.textAlignment = NSTextAlignmentLeft;
		
		[self addSubview:_labelAccountManagerEmail];
    }
    return self;
}

@end
