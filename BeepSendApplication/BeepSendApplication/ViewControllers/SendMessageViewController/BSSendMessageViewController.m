//
//  BSSendMessageViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/9/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSendMessageViewController.h"

#import "BSSendMessageView.h"

@interface BSSendMessageViewController () <UITextFieldDelegate>

@property (nonatomic, strong) BSConnection *connection;
@property (nonatomic, strong) BSContact *contact;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UITextField *textFieldFrom;
@property (nonatomic, weak) UITextField *textFieldTo;

@property (nonatomic, weak) UITextView *textViewMessageBox;

@property (nonatomic, weak) UIButton *buttonValidateSMS;
@property (nonatomic, weak) UIButton *buttonSendSMS;

@property (nonatomic, weak) UIButton *buttonDone;

@property (nonatomic, weak) UIButton *buttonBack;
@property (nonatomic, weak) UISegmentedControl *segmentedControlMessageType;

- (void)setupViewElements;

- (void)buttonDoneClicked:(UIButton *)sender;
- (void)buttonValidateClicked:(UIButton *)sender;
- (void)buttonSendClicked:(UIButton *)sender;

- (void)keyboardBecameActive:(NSNotification *)notification;
- (void)keyboardBecameInactive:(NSNotification *)notification;

- (void)buttonBackClicked:(UIButton *)sender;
- (void)segmentedControlChangedValue:(UISegmentedControl *)sender;

- (BSMessage *)messageToSend;

@end

@implementation BSSendMessageViewController

#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BSSendMessageViewController *)initWithConnection:(BSConnection *)connection
{
	self = [super init];
    if (self) {
        // Custom initialization
		
		_connection = connection;
    }
    return self;
}

- (BSSendMessageViewController *)initWithConnection:(BSConnection *)connection forContact:(BSContact *)contact
{
	self = [super init];
    if (self) {
        // Custom initialization
		
		_connection = connection;
		_contact = contact;
    }
    return self;
}

#pragma mark - View lifecycle

- (void)loadView
{
	BSSendMessageView *sendMessageView = [[BSSendMessageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	_scrollView = sendMessageView.scrollViewContainer;
	
	_textFieldFrom = sendMessageView.textFieldFrom;
	_textFieldTo = sendMessageView.textFieldTo;
	
	_textViewMessageBox = sendMessageView.textViewMessageBox;
	
	_buttonValidateSMS = sendMessageView.buttonValidateSMS;
	_buttonDone = sendMessageView.buttonDone;
	_buttonSendSMS = sendMessageView.buttonSendSMS;
	
	[_buttonValidateSMS addTarget:self action:@selector(buttonValidateClicked:) forControlEvents:UIControlEventTouchUpInside];
	[_buttonSendSMS addTarget:self action:@selector(buttonSendClicked:) forControlEvents:UIControlEventTouchUpInside];
	[_buttonDone addTarget:self action:@selector(buttonDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_buttonBack = sendMessageView.buttonBack;
	[_buttonBack addTarget:self action:@selector(buttonBackClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_segmentedControlMessageType = sendMessageView.segmentedControlMessageType;

	self.view = sendMessageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self setupViewElements];
	
	//Add keyboard appearance notification
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecameActive:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardBecameInactive:) name:UIKeyboardWillHideNotification object:nil];
	
	if (_contact) {
		_textFieldTo.text = _contact.phoneNumber;
	}
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

#pragma mark - Private methods

- (void)setupViewElements
{
	_textFieldFrom.placeholder = NSLocalizedString(@"Who is sending message?", @"");
	_textFieldFrom.delegate = self;
	
	_textFieldTo.placeholder = NSLocalizedString(@"To whom is message sent?", @"");
	_textFieldTo.delegate = self;
	
	[_buttonValidateSMS setTitle:NSLocalizedString(@"Validate message", @"") forState:UIControlStateNormal];
	[_buttonSendSMS setTitle:NSLocalizedString(@"Send message", @"") forState:UIControlStateNormal];
	
	[_segmentedControlMessageType insertSegmentWithTitle:NSLocalizedString(@"Normal", @"") atIndex:0 animated:YES];
	[_segmentedControlMessageType insertSegmentWithTitle:NSLocalizedString(@"Binary", @"") atIndex:1 animated:YES];
	[_segmentedControlMessageType insertSegmentWithTitle:NSLocalizedString(@"Flash", @"") atIndex:2 animated:YES];
	[_segmentedControlMessageType setSelectedSegmentIndex:0];
}

- (void)buttonDoneClicked:(UIButton *)sender
{
	if ([_textFieldFrom isFirstResponder]) {
		[_textFieldFrom resignFirstResponder];
	}
	
	if ([_textFieldTo isFirstResponder]) {
		[_textFieldTo resignFirstResponder];
	}
	
	if ([_textViewMessageBox isFirstResponder]) {
		[_textViewMessageBox resignFirstResponder];
	}
}

- (void)buttonValidateClicked:(UIButton *)sender {
	
	BSMessage *message = [self messageToSend];
	
	if (!message) {
		return; //Message not valid
	}
	
	__block UIView *viewLoader = [[UIView alloc] initWithFrame:self.view.bounds];
	[viewLoader setBackgroundColor:[UIColor blackColor]];
	viewLoader.alpha = 0.6;
	__block UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.center = self.view.center;
	[activityIndicator startAnimating];
	[self.view addSubview:viewLoader];
	[self.view addSubview:activityIndicator];
	
	[message validateMessageOnCompletion:^(BSMessage *message, NSArray *errors) {
		
		[viewLoader removeFromSuperview];
		[activityIndicator stopAnimating];
		[activityIndicator removeFromSuperview];
		
		if (!errors || errors.count == 0) {
			[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success!", @"") message:NSLocalizedString(@"Message was successfully validated!", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
		}
		else {
			
			NSString *errorMessages = @"";
			for (BSError *error in errors) {
				errorMessages = [[errorMessages stringByAppendingString:error.errorDescription] stringByAppendingString:@"\n"];
			}
			
			[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error!", @"") message:errorMessages delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
		}
	}];
	
}

- (void)buttonSendClicked:(UIButton *)sender
{
	BSMessage *message = [self messageToSend];
	
	if (!message) {
		return; //Message not valid
	}
	
	__block UIView *viewLoader = [[UIView alloc] initWithFrame:self.view.bounds];
	[viewLoader setBackgroundColor:[UIColor blackColor]];
	viewLoader.alpha = 0.6;
	__block UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.center = self.view.center;
	[activityIndicator startAnimating];
	[self.view addSubview:viewLoader];
	[self.view addSubview:activityIndicator];
	
	[_connection sendSMS:message withCompletionBlock:^(BSMessage *message, NSArray *errors) {
		
		[viewLoader removeFromSuperview];
		[activityIndicator stopAnimating];
		[activityIndicator removeFromSuperview];
		
		if (!errors || errors.count == 0) {
			[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success!", @"") message:NSLocalizedString(@"Message was successfully sent!", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
		}
		else {
			
			NSString *errorMessages = @"";
			for (BSError *error in errors) {
				errorMessages = [[errorMessages stringByAppendingString:error.errorDescription] stringByAppendingString:@"\n"];
			}
			
			[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error!", @"") message:errorMessages delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
		}
	}];
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

- (void)buttonBackClicked:(UIButton *)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)segmentedControlChangedValue:(UISegmentedControl *)sender
{
	
}

- (BSMessage *)messageToSend
{
	if ([_textFieldFrom isFirstResponder]) {
		[_textFieldFrom resignFirstResponder];
	}
	else if ([_textFieldTo isFirstResponder]) {
		[_textFieldTo resignFirstResponder];
	}
	else if ([_textViewMessageBox isFirstResponder]) {
		[_textViewMessageBox resignFirstResponder];
	}
	
	if (![Helper isNilOrEmpty:_textFieldFrom.text] &&
		![Helper isNilOrEmpty:_textFieldTo.text] &&
		![Helper isNilOrEmpty:_textViewMessageBox.text]) {
		
		BSMessage *message;
		switch (_segmentedControlMessageType.selectedSegmentIndex) {
			case 0://Normal message
			{
				message = [BSMessage messageWithBody:_textViewMessageBox.text from:_textFieldFrom.text to:_textFieldTo.text];
			}
				break;
			case 1://Binary message
			{
				message = [BSMessage binaryMessageWithBody:_textViewMessageBox.text from:_textFieldFrom.text to:_textFieldTo.text];
			}
				break;
			case 2://Flash message
			{
				message = [BSMessage flashMessageWithBody:_textViewMessageBox.text from:_textFieldFrom.text to:_textFieldTo.text];
			}
				break;
			default:
				break;
		}
	
		return message;
	}
	
	return nil;
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if ([textField isEqual:_textFieldTo] && _contact) {
		return NO;
	}
	
	if ([textField isEqual:_textViewMessageBox]) {
		[_buttonDone setTitle:NSLocalizedString(@"Send", @"") forState:UIControlStateNormal];
	}
	else {
		[_buttonDone setTitle:NSLocalizedString(@"Done", @"") forState:UIControlStateNormal];
	}
	
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if ([textField isEqual:_textFieldFrom]) {
		[_textFieldTo becomeFirstResponder];
	}
	
	return YES;
}

@end
