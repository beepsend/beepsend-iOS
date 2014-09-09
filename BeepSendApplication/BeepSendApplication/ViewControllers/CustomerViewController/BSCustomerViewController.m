//
//  BSCustomerViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/17/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSCustomerViewController.h"

#import "BSCustomerView.h"

@interface BSCustomerViewController ()

@property (nonatomic, weak) UILabel *labelName;
@property (nonatomic, weak) UILabel *labelNameStatic;

@property (nonatomic, weak) UILabel *labelPhone;
@property (nonatomic, weak) UILabel *labelPhoneStatic;

@property (nonatomic, weak) UILabel *labelAddress;
@property (nonatomic, weak) UILabel *labelAddressStatic;

@property (nonatomic, weak) UILabel *labelCity;
@property (nonatomic, weak) UILabel *labelCityStatic;

@property (nonatomic, weak) UILabel *labelPostBox;
@property (nonatomic, weak) UILabel *labelPostBoxStatic;

@property (nonatomic, weak) UILabel *labelCountry;
@property (nonatomic, weak) UILabel *labelCountryStatic;

@property (nonatomic, weak) UILabel *labelVat;
@property (nonatomic, weak) UILabel *labelVatStatic;

@property (nonatomic, weak) UILabel *labelEmail;
@property (nonatomic, weak) UILabel *labelEmailStatic;

@property (nonatomic, weak) UILabel *labelInvoiceType;
@property (nonatomic, weak) UILabel *labelInvoiceTypeStatic;

@property (nonatomic, weak) UILabel *labelAccountManagerStatic;

@property (nonatomic, weak) UILabel *labelAccountManagerName;
@property (nonatomic, weak) UILabel *labelAccountManagerEmail;

- (void)setupTitles;

- (void)viewTapped:(UIGestureRecognizer *)gRecognizer;

@end

@implementation BSCustomerViewController

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

- (void)loadView
{
	BSCustomerView *customerView = [[BSCustomerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	_labelName = customerView.labelName;
	_labelNameStatic = customerView.labelNameStatic;
	
	_labelPhone = customerView.labelPhone;
	_labelPhoneStatic = customerView.labelPhoneStatic;
	
	_labelAddress = customerView.labelAddress;
	_labelAddressStatic = customerView.labelAddressStatic;
	
	_labelCity = customerView.labelCity;
	_labelCityStatic = customerView.labelCityStatic;
	
	_labelPostBox = customerView.labelPostBox;
	_labelPostBoxStatic = customerView.labelPostBoxStatic;
	
	_labelCountry = customerView.labelCountry;
	_labelCountryStatic = customerView.labelCountryStatic;
	
	_labelVat = customerView.labelVat;
	_labelVatStatic = customerView.labelVatStatic;
	
	_labelEmail = customerView.labelEmail;
	_labelEmailStatic = customerView.labelEmailStatic;
	
	_labelInvoiceType = customerView.labelInvoiceType;
	_labelInvoiceTypeStatic = customerView.labelInvoiceTypeStatic;
	
	_labelAccountManagerStatic = customerView.labelAccountManagerStatic;
	
	_labelAccountManagerName = customerView.labelAccountManagerName;
	_labelAccountManagerEmail = customerView.labelAccountManagerEmail;
	
	self.view = customerView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.title = NSLocalizedString(@"Customer", @"");
	
	[self setupTitles];
	
	__block UIView *viewLoader = [[UIView alloc] initWithFrame:self.view.bounds];
	[viewLoader setBackgroundColor:[UIColor blackColor]];
	viewLoader.alpha = 0.6;
	__block UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.center = self.view.center;
	[activityIndicator startAnimating];
	[self.view addSubview:viewLoader];
	[self.view addSubview:activityIndicator];
	
	[[BSUser currentUser] getCustomerDetailsOnCompletion:^(BSCustomer *customer, NSArray *errors) {
		
		if (errors && errors.count>0 ) {
			
			NSString *errorMessages = @"";
			for (BSError *error in errors) {
				errorMessages = [[errorMessages stringByAppendingString:error.errorDescription] stringByAppendingString:@"\n"];
			}
			
			[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error!", @"") message:errorMessages delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
		}
		else {
			_labelName.text = customer.name;
			_labelPhone.text = customer.phoneNumber;
			
			_labelAddress.text = customer.address;
			
			_labelCity.text = customer.city;
			
			_labelPostBox.text = customer.postBox;
			
			_labelCountry.text = customer.country;
			
			_labelVat.text = customer.vat;
			
			_labelEmail.text = customer.email;
			
			_labelInvoiceType.text = customer.type;
			
			_labelAccountManagerName.text = customer.accountManager.name;
			_labelAccountManagerEmail.text = customer.accountManager.email;
		}
		
		[viewLoader removeFromSuperview];
		[activityIndicator stopAnimating];
		[activityIndicator removeFromSuperview];
	}];
	
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
	[tapRecognizer setNumberOfTapsRequired:1];
	[self.view addGestureRecognizer:tapRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)setupTitles
{
	_labelNameStatic.text = NSLocalizedString(@"Name:", @"");
	_labelPhoneStatic.text = NSLocalizedString(@"Phone:", @"");
	_labelAddressStatic.text = NSLocalizedString(@"Address:", @"");
	_labelCityStatic.text = NSLocalizedString(@"City:", @"");
	_labelPostBoxStatic.text = NSLocalizedString(@"PostBox:", @"");
	_labelCountryStatic.text = NSLocalizedString(@"Country:", @"");
	_labelVatStatic.text = NSLocalizedString(@"VAT:", @"");
	_labelEmailStatic.text = NSLocalizedString(@"Email:", @"");
	_labelInvoiceTypeStatic.text = NSLocalizedString(@"Type:", @"");
	_labelAccountManagerStatic.text = NSLocalizedString(@"Account Manager:", @"");
}

- (void)viewTapped:(UIGestureRecognizer *)gRecognizer
{
	if (gRecognizer.state == UIGestureRecognizerStateRecognized) {
		[self.navigationController popViewControllerAnimated:YES];
	}
}

@end
