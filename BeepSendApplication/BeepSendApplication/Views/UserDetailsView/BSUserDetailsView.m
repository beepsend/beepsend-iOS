//
//  BSUserDetailsView.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/15/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSUserDetailsView.h"

@implementation BSUserDetailsView

#pragma mark - Initialization

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
		//Scroll view
		_scrollViewContainer = [[UIScrollView alloc] initWithFrame:frame];
		_scrollViewContainer.backgroundColor = [UIColor clearColor];
		_scrollViewContainer.contentSize = frame.size;
		_scrollViewContainer.clipsToBounds = YES;
		
		[self addSubview:_scrollViewContainer];
		
		////////////////////////////////////////////////////////////////////////
		//Labels and text fields for name, email and phone
		_labelName = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, kViewDefaultBorderInset, kDefaultTitleLabelWidth, kTextFieldDefaultHeight)];
		_labelName.backgroundColor = [UIColor clearColor];
		_labelName.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelName.textColor = [UIColor blackColor];
		_labelName.textAlignment = NSTextAlignmentRight;
		
		[_scrollViewContainer addSubview:_labelName];
		
		_textFieldName = [[BSTextFieldCustomTextInset alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelName.frame) + kSeparatorDefaultSpacing, CGRectGetMinY(_labelName.frame), frame.size.width - CGRectGetWidth(_labelName.frame) - kSeparatorDefaultSpacing - 2*kViewDefaultBorderInset, kTextFieldDefaultHeight)];
		_textFieldName.backgroundColor = [UIColor whiteColor];
		_textFieldName.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_textFieldName.textColor = [UIColor blackColor];
		_textFieldName.textAlignment = NSTextAlignmentNatural;
		_textFieldName.keyboardAppearance = UIKeyboardAppearanceDark;
		_textFieldName.keyboardType = UIKeyboardTypeAlphabet;
		_textFieldName.returnKeyType = UIReturnKeyDone;
		_textFieldName.clearButtonMode = UITextFieldViewModeWhileEditing;
		_textFieldName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@""
																			   attributes:@{
																							NSForegroundColorAttributeName:[UIColor lightGrayColor],
																							NSFontAttributeName:[UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultPlaceholderSize]
																							}];
		
		
		_textFieldName.layer.borderColor = [UIColor orangeColor].CGColor;
		_textFieldName.layer.borderWidth = kDefaultBorderWidth;
		_textFieldName.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		
		[_scrollViewContainer addSubview:_textFieldName];
		
		_labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelName.frame) + kSeparatorDefaultSpacing, kDefaultTitleLabelWidth, kTextFieldDefaultHeight)];
		_labelEmail.backgroundColor = [UIColor clearColor];
		_labelEmail.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelEmail.textColor = [UIColor blackColor];
		_labelEmail.textAlignment = NSTextAlignmentRight;
		
		[_scrollViewContainer addSubview:_labelEmail];
		
		_textFieldEmail = [[BSTextFieldCustomTextInset alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelEmail.frame) + kSeparatorDefaultSpacing, CGRectGetMinY(_labelEmail.frame), frame.size.width - CGRectGetWidth(_labelEmail.frame) - kSeparatorDefaultSpacing - 2*kViewDefaultBorderInset, kTextFieldDefaultHeight)];
		_textFieldEmail.backgroundColor = [UIColor whiteColor];
		_textFieldEmail.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_textFieldEmail.textColor = [UIColor blackColor];
		_textFieldEmail.textAlignment = NSTextAlignmentNatural;
		_textFieldEmail.keyboardAppearance = UIKeyboardAppearanceDark;
		_textFieldEmail.keyboardType = UIKeyboardTypeAlphabet;
		_textFieldEmail.returnKeyType = UIReturnKeyDone;
		_textFieldEmail.clearButtonMode = UITextFieldViewModeWhileEditing;
		_textFieldEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@""
																				attributes:@{
																							 NSForegroundColorAttributeName:[UIColor lightGrayColor],
																							 NSFontAttributeName:[UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultPlaceholderSize]
																							 }];
		
		
		_textFieldEmail.layer.borderColor = [UIColor orangeColor].CGColor;
		_textFieldEmail.layer.borderWidth = kDefaultBorderWidth;
		_textFieldEmail.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		
		[_scrollViewContainer addSubview:_textFieldEmail];
		
		_labelPhone = [[UILabel alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelEmail.frame) + kSeparatorDefaultSpacing, kDefaultTitleLabelWidth, kTextFieldDefaultHeight)];
		_labelPhone.backgroundColor = [UIColor clearColor];
		_labelPhone.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_labelPhone.textColor = [UIColor blackColor];
		_labelPhone.textAlignment = NSTextAlignmentRight;
		
		[_scrollViewContainer addSubview:_labelPhone];
		
		_textFieldPhone = [[BSTextFieldCustomTextInset alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelPhone.frame) + kSeparatorDefaultSpacing, CGRectGetMinY(_labelPhone.frame), frame.size.width - CGRectGetWidth(_labelPhone.frame) - kSeparatorDefaultSpacing - 2*kViewDefaultBorderInset, kTextFieldDefaultHeight)];
		_textFieldPhone.backgroundColor = [UIColor whiteColor];
		_textFieldPhone.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize];
		_textFieldPhone.textColor = [UIColor blackColor];
		_textFieldPhone.textAlignment = NSTextAlignmentNatural;
		_textFieldPhone.keyboardAppearance = UIKeyboardAppearanceDark;
		_textFieldPhone.keyboardType = UIKeyboardTypeAlphabet;
		_textFieldPhone.returnKeyType = UIReturnKeyDone;
		_textFieldPhone.clearButtonMode = UITextFieldViewModeWhileEditing;
		_textFieldPhone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@""
																				attributes:@{
																							 NSForegroundColorAttributeName:[UIColor lightGrayColor],
																							 NSFontAttributeName:[UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultPlaceholderSize]
																							 }];
		
		
		_textFieldPhone.layer.borderColor = [UIColor orangeColor].CGColor;
		_textFieldPhone.layer.borderWidth = kDefaultBorderWidth;
		_textFieldPhone.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		
		[_scrollViewContainer addSubview:_textFieldPhone];
		
		////////////////////////////////////////////////////////////////////////
		//User types table view
		_tableViewUserTypes = [[UITableView alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_labelPhone.frame) + kSeparatorDefaultSpacing, frame.size.width/2 - 3*kViewDefaultBorderInset, 2.0*kDefaultTableViewCellHeight)];
		[_tableViewUserTypes setBackgroundColor:[UIColor whiteColor]];
		[_tableViewUserTypes setSeparatorColor:[UIColor darkGrayColor]];
		[_tableViewUserTypes setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		[_tableViewUserTypes setRowHeight:kTextFieldDefaultHeight/2.0];
		[_tableViewUserTypes setShowsHorizontalScrollIndicator:NO];
		[_tableViewUserTypes setShowsVerticalScrollIndicator:NO];
		[_tableViewUserTypes setScrollEnabled:NO];
		
		_tableViewUserTypes.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		_tableViewUserTypes.layer.borderWidth = kDefaultBorderWidth;
		_tableViewUserTypes.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[_scrollViewContainer addSubview:_tableViewUserTypes];
		
		////////////////////////////////////////////////////////////////////////
		//Buttons customer and default connection
		_buttonCustomer = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_tableViewUserTypes.frame) + kSeparatorDefaultSpacing, CGRectGetMinY(_tableViewUserTypes.frame), CGRectGetWidth(_tableViewUserTypes.frame), CGRectGetHeight(_tableViewUserTypes.frame)/2.0 - kSeparatorDefaultSpacing)];
		
		_buttonCustomer.backgroundColor = [UIColor lightGrayColor];
		_buttonCustomer.showsTouchWhenHighlighted = YES;
		_buttonCustomer.clipsToBounds = YES;
		[_buttonCustomer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonCustomer setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		_buttonCustomer.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize/1.6];
		
		_buttonCustomer.layer.cornerRadius = kDefaultButtonCornerRadius;
		_buttonCustomer.layer.borderWidth = kDefaultBorderWidth;
		_buttonCustomer.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[_scrollViewContainer addSubview:_buttonCustomer];
		
		_buttonDefaultConnection = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_buttonCustomer.frame), CGRectGetMaxY(_buttonCustomer.frame) + 2*kSeparatorDefaultSpacing, CGRectGetWidth(_buttonCustomer.frame), CGRectGetHeight(_buttonCustomer.frame))];
		
		_buttonDefaultConnection.backgroundColor = [UIColor lightGrayColor];
		_buttonDefaultConnection.showsTouchWhenHighlighted = YES;
		_buttonDefaultConnection.clipsToBounds = YES;
		[_buttonDefaultConnection setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonDefaultConnection setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		_buttonDefaultConnection.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize/1.6];
		
		_buttonDefaultConnection.layer.cornerRadius = kDefaultButtonCornerRadius;
		_buttonDefaultConnection.layer.borderWidth = kDefaultBorderWidth;
		_buttonDefaultConnection.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[_scrollViewContainer addSubview:_buttonDefaultConnection];
		
		////////////////////////////////////////////////////////////////////////
		//User types table view
		_tableViewConnections = [[UITableView alloc] initWithFrame:CGRectMake(kViewDefaultBorderInset, CGRectGetMaxY(_tableViewUserTypes.frame) + kSeparatorDefaultSpacing, frame.size.width - 2*kViewDefaultBorderInset, frame.size.height - CGRectGetMaxY(_tableViewUserTypes.frame) - kViewDefaultBorderInset)];
		[_tableViewConnections setBackgroundColor:[UIColor whiteColor]];
		[_tableViewConnections setSeparatorColor:[UIColor darkGrayColor]];
		[_tableViewConnections setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
		[_tableViewConnections setRowHeight:kTextFieldDefaultHeight];
		[_tableViewConnections setShowsHorizontalScrollIndicator:NO];
		[_tableViewConnections setShowsVerticalScrollIndicator:NO];
		
		_tableViewConnections.layer.cornerRadius = kTextFieldDefaultHeight/2.0;
		_tableViewConnections.layer.borderWidth = kDefaultBorderWidth;
		_tableViewConnections.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[_scrollViewContainer addSubview:_tableViewConnections];
		
		//		@property (nonatomic, strong) UIButton *buttonVerifiedTerms;
		//		@property (nonatomic, strong) UIButton *buttonVerifiedPhone;
		//		@property (nonatomic, strong) UIButton *buttonVerifiedEmail;
		
		////////////////////////////////////////////////////////////////////////
		//Contacts button
		_buttonContacts = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_buttonCustomer.frame) + kSeparatorDefaultSpacing, CGRectGetMinY(_buttonCustomer.frame), frame.size.width - 2*kSeparatorDefaultSpacing - CGRectGetWidth(_buttonCustomer.frame) - CGRectGetWidth(_tableViewUserTypes.frame) - 2*kViewDefaultBorderInset, CGRectGetHeight(_tableViewUserTypes.frame))];
		
		_buttonContacts.backgroundColor = [UIColor lightGrayColor];
		_buttonContacts.showsTouchWhenHighlighted = YES;
		_buttonContacts.clipsToBounds = YES;
		[_buttonContacts setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[_buttonContacts setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		_buttonContacts.titleLabel.font = [UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize/1.6];
		
		_buttonContacts.layer.cornerRadius = kDefaultButtonCornerRadius;
		_buttonContacts.layer.borderWidth = kDefaultBorderWidth;
		_buttonContacts.layer.borderColor = [UIColor orangeColor].CGColor;
		
		[_scrollViewContainer addSubview:_buttonContacts];
		
    }
    return self;
}

@end
