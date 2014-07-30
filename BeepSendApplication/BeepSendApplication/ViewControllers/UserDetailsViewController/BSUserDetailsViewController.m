//
//  BSUserDetailsViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/15/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSUserDetailsViewController.h"

#import "BSUserDetailsView.h"

#import "BSUserTypeTableViewCell.h"
#import "BSConnectionTableViewCell.h"

#import "BSCustomerViewController.h"
#import "BSSendMessageViewController.h"
#import "BSContactsViewController.h"
#import "BSHLRViewController.h"

@interface BSUserDetailsViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UILabel *labelName;
@property (nonatomic, weak) UILabel *labelEmail;
@property (nonatomic, weak) UILabel *labelPhone;

@property (nonatomic, weak) UITextField *textFieldName;
@property (nonatomic, weak) UITextField *textFieldEmail;
@property (nonatomic, weak) UITextField *textFieldPhone;

@property (nonatomic, weak) UITableView *tableViewUserTypes;

@property (nonatomic, weak) UIButton *buttonDefaultConnection;
@property (nonatomic, weak) UIButton *buttonCustomer;

@property (nonatomic, weak) UIButton *buttonVerifiedTerms;
@property (nonatomic, weak) UIButton *buttonVerifiedPhone;
@property (nonatomic, weak) UIButton *buttonVerifiedEmail;

@property (nonatomic, weak) UITableView *tableViewConnections;

@property (nonatomic, weak) UIButton *buttonContacts;

@property (nonatomic, weak) UIButton *buttonDone;

@property (nonatomic, strong) NSArray *dataSourceConnections;

- (void)setupViewElements;

- (void)keyboardBecameActive:(NSNotification *)notification;
- (void)keyboardBecameInactive:(NSNotification *)notification;

- (void)animateScrollViewFrame:(CGRect)newFrame withDuration:(CGFloat)duration andAnimationCurve:(NSInteger)animationCurve;

- (void)buttonCustomerClicked:(UIButton *)sender;
- (void)buttonDefaultConnectionClicked:(UIButton *)sender;
- (void)buttonContactsClicked:(UIButton *)sender;

- (void)buttonDoneClicked:(UIButton *)sender;

@end

@implementation BSUserDetailsViewController

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
	BSUserDetailsView *rootView = [[BSUserDetailsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	_scrollView = rootView.scrollViewContainer;
	
	_labelName = rootView.labelName;
	_labelEmail = rootView.labelEmail;
	_labelPhone = rootView.labelPhone;
	
	_textFieldName = rootView.textFieldName;
	_textFieldName.delegate = self;
	_textFieldEmail = rootView.textFieldEmail;
	_textFieldEmail.delegate = self;
	_textFieldPhone = rootView.textFieldPhone;
	_textFieldPhone.delegate = self;
	
	_tableViewUserTypes = rootView.tableViewUserTypes;
	_tableViewUserTypes.dataSource = self;
	_tableViewUserTypes.delegate = self;
	
	_buttonDefaultConnection = rootView.buttonDefaultConnection;
	[_buttonDefaultConnection addTarget:self action:@selector(buttonDefaultConnectionClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_buttonCustomer = rootView.buttonCustomer;
	[_buttonCustomer addTarget:self action:@selector(buttonCustomerClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_buttonVerifiedEmail = rootView.buttonVerifiedEmail;
	_buttonVerifiedPhone = rootView.buttonVerifiedPhone;
	_buttonVerifiedTerms = rootView.buttonVerifiedTerms;
	
	_tableViewConnections = rootView.tableViewConnections;
	_tableViewConnections.dataSource = self;
	_tableViewConnections.delegate = self;
	
	_tableViewConnections = rootView.tableViewConnections;
	_tableViewConnections.dataSource = self;
	_tableViewConnections.delegate = self;
	
	_buttonContacts = rootView.buttonContacts;
	[_buttonContacts addTarget:self action:@selector(buttonContactsClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_buttonDone = rootView.buttonDone;
	[_buttonDone addTarget:self action:@selector(buttonDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	self.view = rootView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self setupViewElements];
	
	//Add keyboard appearance notification
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecameActive:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecameInactive:) name:UIKeyboardWillHideNotification object:nil];
	
	//Collect all available connections for user
	[[BSUser currentUser] getAvailableConnectionsOnCompletion:^(NSArray *connections, NSArray *errors) {
		_dataSourceConnections = connections;
		[_tableViewConnections reloadData];
		
		[_buttonDefaultConnection setTitle:[BSUser currentUser].defaultConnection.label forState:UIControlStateNormal];
	}];
	
	//Reload user types table view
	[_tableViewUserTypes reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[_tableViewConnections deselectRowAtIndexPath:[_tableViewConnections indexPathForSelectedRow] animated:animated];
}

#pragma mark - Private methods

- (void)setupViewElements
{
	BSUser *u = [BSUser currentUser];
	
	_labelName.text = NSLocalizedString(@"Name:", @"");
	_labelEmail.text = NSLocalizedString(@"Email:", @"");
	_labelPhone.text = NSLocalizedString(@"Phone:", @"");
	
	_textFieldName.text = u.name;
	_textFieldEmail.text = u.email;
	_textFieldPhone.text = u.phone;
	
	[_buttonCustomer setTitle:u.customerName forState:UIControlStateNormal];
	[_buttonDefaultConnection setTitle:u.defaultConnection.label forState:UIControlStateNormal];
	
	[_buttonContacts setTitle:@"Contacts" forState:UIControlStateNormal];
	
	[_buttonDone setTitle:NSLocalizedString(@"Update", @"") forState:UIControlStateNormal];
}

- (void)keyboardBecameActive:(NSNotification *)notification
{
	CGRect keyboardFrameEndUser = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
	CGRect scrollViewFrame = _scrollView.frame;
	scrollViewFrame.size.height = keyboardFrameEndUser.origin.y;
	
	[self animateScrollViewFrame:scrollViewFrame
					withDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
			   andAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
}

- (void)keyboardBecameInactive:(NSNotification *)notification
{
	CGRect keyboardFrameEndUser = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
	CGRect scrollViewFrame = _scrollView.frame;
	scrollViewFrame.size.height = keyboardFrameEndUser.origin.y;
	
	[self animateScrollViewFrame:scrollViewFrame
					withDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
			   andAnimationCurve:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
}

- (void)animateScrollViewFrame:(CGRect)newFrame withDuration:(CGFloat)duration andAnimationCurve:(NSInteger)animationCurve {
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:animationCurve];
	[UIView setAnimationBeginsFromCurrentState:YES];
	{
		self.view.frame = newFrame;
		_scrollView.frame = self.view.frame;
	}
	[UIView commitAnimations];
}

- (void)buttonCustomerClicked:(UIButton *)sender
{
	BSCustomerViewController *customerVC = [[BSCustomerViewController alloc] init];
	[self.navigationController pushViewController:customerVC animated:YES];
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:nil];
}

- (void)buttonDefaultConnectionClicked:(UIButton *)sender
{
	BSSendMessageViewController *msgVC = [[BSSendMessageViewController alloc] initWithConnection:[BSUser currentUser].defaultConnection];
	[self.navigationController pushViewController:msgVC animated:YES];
}

- (void)buttonContactsClicked:(UIButton *)sender
{
	BSContactsViewController *contactsVC = [[BSContactsViewController alloc] init];
	[self.navigationController pushViewController:contactsVC animated:YES];
}

- (void)buttonDoneClicked:(UIButton *)sender
{
	if ([_textFieldName isFirstResponder]) {
		[_textFieldName resignFirstResponder];
		
		[BSUser currentUser].name = _textFieldName.text;
		
		[[BSUser currentUser] updateUserOnCompletion:^(NSArray *errors) {
			
		}];
	}
	
	if ([_textFieldPhone isFirstResponder]) {
		[_textFieldPhone resignFirstResponder];
		
		[BSUser currentUser].phone = _textFieldPhone.text;
		
		[[BSUser currentUser] updateUserOnCompletion:^(NSArray *errors) {
			
		}];
	}
	
	if ([_textFieldEmail isFirstResponder]) {
		[_textFieldEmail resignFirstResponder];
		
		[BSUser currentUser].email = _textFieldEmail.text;
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Enter password to update email", @"")
															  message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
		alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
		[alert show];
	}
	
	
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if ([tableView isEqual:_tableViewUserTypes]) {
		return [[BSUser currentUser].userTypes count];
	}
	else {
		return [_dataSourceConnections count];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier;
	if ([tableView isEqual:_tableViewUserTypes]) {
		CellIdentifier = @"UserTypeCell";
	}
	else {
		CellIdentifier = @"ConnectionCell";
	}
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		if ([tableView isEqual:_tableViewUserTypes]) {
			cell = [[BSUserTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
			[cell setUserInteractionEnabled:NO];
		}
		else {
			cell = [[BSConnectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		}
	}
	
	if ([tableView isEqual:_tableViewUserTypes]) {
		cell.textLabel.text	= [[BSUser currentUser].userTypes[indexPath.row] title];
	}
	else {
		cell.textLabel.text = [_dataSourceConnections[indexPath.row] title];
	}
	
	return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([tableView isEqual:_tableViewConnections]) {
		
		BSConnection *connection = _dataSourceConnections[indexPath.row];
		
		id vc;
		if (connection.type == BSConnectionTypeSMS) {
			vc = [[BSSendMessageViewController alloc] initWithConnection:connection];
		}
		else {
			vc = [[BSHLRViewController alloc] initWithConnection:connection];
		}
		
		[self.navigationController pushViewController:vc animated:YES];
		
	}
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
		case 0:
		{
			
		}
			break;
		case 1:
		{
			NSString *password = [alertView textFieldAtIndex:0].text;
			[[BSUser currentUser] updateUserEmailWithPassword:password onCompletion:^(NSArray *errors) {
				
			}];
		}
			break;
		default:
			break;
	}
}

@end
