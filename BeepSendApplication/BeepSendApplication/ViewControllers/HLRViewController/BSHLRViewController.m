//
//  BSHLRViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/23/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSHLRViewController.h"

#import "BSHLRView.h"

@interface BSHLRViewController ()

@property (nonatomic, strong) BSConnection *connection;

@property (nonatomic, weak) UITextField *textFieldNumberToCheck;
@property (nonatomic, weak) UIButton *buttonPerformHLR;
@property (nonatomic, weak) UIButton *buttonValidateHLR;

@property (nonatomic, weak) UIButton *buttonBack;

@property (nonatomic, weak) UIButton *buttonDone;

- (void)setupTitles;

- (void)buttonValidateHLRClicked:(UIButton *)sender;
- (void)buttonPerformHLRClicked:(UIButton *)sender;
- (void)buttonBackClicked:(UIButton *)sender;
- (void)buttonDoneClicked:(UIButton *)sender;

@end

@implementation BSHLRViewController

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BSHLRViewController *)initWithConnection:(BSConnection *)connection
{
	self = [super init];
    if (self) {
        // Custom initialization
		
		_connection = connection;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)loadView
{
	BSHLRView *hlrView = [[BSHLRView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	_textFieldNumberToCheck = hlrView.textFieldNumberToCheck;
	
	_buttonValidateHLR = hlrView.buttonValidateHLR;
	[_buttonValidateHLR addTarget:self action:@selector(buttonValidateHLRClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_buttonPerformHLR = hlrView.buttonPerformHLR;
	[_buttonPerformHLR addTarget:self action:@selector(buttonPerformHLRClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_buttonBack = hlrView.buttonBack;
	[_buttonBack addTarget:self action:@selector(buttonBackClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_buttonDone = hlrView.buttonDone;
	[_buttonDone addTarget:self action:@selector(buttonDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	self.view = hlrView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self setupTitles];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)setupTitles
{
	_textFieldNumberToCheck.placeholder = NSLocalizedString(@"Number to check", @"");
	
	[_buttonValidateHLR setTitle:NSLocalizedString(@"Validate HLR", @"") forState:UIControlStateNormal];
	[_buttonPerformHLR setTitle:NSLocalizedString(@"Perform HLR", @"") forState:UIControlStateNormal];
}

- (void)buttonValidateHLRClicked:(UIButton *)sender
{
	if ([Helper isNilOrEmpty:_textFieldNumberToCheck.text]) {
		return; //You must enter number
	}
	
	__block UIView *viewLoader = [[UIView alloc] initWithFrame:self.view.bounds];
	[viewLoader setBackgroundColor:[UIColor blackColor]];
	viewLoader.alpha = 0.6;
	__block UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.center = self.view.center;
	[activityIndicator startAnimating];
	[self.view addSubview:viewLoader];
	[self.view addSubview:activityIndicator];
	
	[_textFieldNumberToCheck resignFirstResponder];
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[_connection validateHLRForNumber:_textFieldNumberToCheck.text onCompletion:^(BSHLR *hlr, NSArray *errors) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		
		[viewLoader removeFromSuperview];
		[activityIndicator stopAnimating];
		[activityIndicator removeFromSuperview];
		
		if (errors && errors.count>0 ) {
			
			NSString *errorMessages = @"";
			for (BSError *error in errors) {
				errorMessages = [[errorMessages stringByAppendingString:error.errorDescription] stringByAppendingString:@"\n"];
			}
			
			[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error!", @"") message:errorMessages delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
		}
		else {
			[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success", @"") message:NSLocalizedString(@"HLR validation performed successfully", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
		}
		
	}];
}

- (void)buttonPerformHLRClicked:(UIButton *)sender
{
	if ([Helper isNilOrEmpty:_textFieldNumberToCheck.text]) {
		return; //You must enter number
	}
	
	__block UIView *viewLoader = [[UIView alloc] initWithFrame:self.view.bounds];
	[viewLoader setBackgroundColor:[UIColor blackColor]];
	viewLoader.alpha = 0.6;
	__block UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.center = self.view.center;
	[activityIndicator startAnimating];
	[self.view addSubview:viewLoader];
	[self.view addSubview:activityIndicator];
	
	[_textFieldNumberToCheck resignFirstResponder];
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[_connection immediateHLRForNumber:_textFieldNumberToCheck.text onCompletion:^(BSHLR *hlr, NSArray *errors) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		
		[viewLoader removeFromSuperview];
		[activityIndicator stopAnimating];
		[activityIndicator removeFromSuperview];
		
		if (errors && errors.count>0 ) {
			
			NSString *errorMessages = @"";
			for (BSError *error in errors) {
				errorMessages = [[errorMessages stringByAppendingString:error.errorDescription] stringByAppendingString:@"\n"];
			}
			
			[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error!", @"") message:errorMessages delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
		}
		else {
			[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success", @"") message:NSLocalizedString(@"HLR performed successfully", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
		}
		
	}];
}

- (void)buttonBackClicked:(UIButton *)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonDoneClicked:(UIButton *)sender
{
	[_textFieldNumberToCheck resignFirstResponder];
}

@end
