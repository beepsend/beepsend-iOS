//
//  BSSendMessageViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/9/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSSendMessageViewController.h"

#import "BSSendMessageView.h"

//TODO: IMPORT SDK FOR TESTING
#import "BSUser.h"
#import "BSConnection.h"
#import "BSMessage.h"
#import "BSWallet.h"

@interface BSSendMessageViewController () <UITextFieldDelegate>

@property (nonatomic, strong) BSConnection *connection;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UITextField *textFieldFrom;
@property (nonatomic, weak) UITextField *textFieldTo;

@property (nonatomic, weak) UITextView *textViewMessageBox;

@property (nonatomic, weak) UIButton *buttonCheckDestinationNumber;
@property (nonatomic, weak) UIButton *buttonDone;

@property (nonatomic, weak) UIButton *buttonBack;
@property (nonatomic, weak) UISegmentedControl *segmentedControlMessageType;

- (void)setupViewElements;

- (void)buttonDoneClicked;
- (void)buttonCheckClicked;

- (void)keyboardBecameActive:(NSNotification *)notification;
- (void)keyboardBecameInactive:(NSNotification *)notification;

- (void)buttonBackClicked:(UIButton *)sender;
- (void)segmentedControlChangedValue:(UISegmentedControl *)sender;

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

#pragma mark - View lifecycle

- (void)loadView
{
	BSSendMessageView *sendMessageView = [[BSSendMessageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	_scrollView = sendMessageView.scrollViewContainer;
	
	_textFieldFrom = sendMessageView.textFieldFrom;
	_textFieldTo = sendMessageView.textFieldTo;
	
	_textViewMessageBox = sendMessageView.textViewMessageBox;
	
	_buttonCheckDestinationNumber = sendMessageView.buttonCheckDestinationNumber;
	_buttonDone = sendMessageView.buttonDone;
	
	[_buttonCheckDestinationNumber addTarget:self action:@selector(buttonCheckClicked) forControlEvents:UIControlEventTouchUpInside];
	[_buttonDone addTarget:self action:@selector(buttonDoneClicked) forControlEvents:UIControlEventTouchUpInside];
	
	_buttonBack = sendMessageView.buttonBack;
	[_buttonBack addTarget:self action:@selector(buttonBackClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_segmentedControlMessageType = sendMessageView.segmentedControlMessageType;
	[_segmentedControlMessageType insertSegmentWithTitle:NSLocalizedString(@"Normal", @"") atIndex:0 animated:YES];
	[_segmentedControlMessageType insertSegmentWithTitle:NSLocalizedString(@"Binary", @"") atIndex:1 animated:YES];
	[_segmentedControlMessageType insertSegmentWithTitle:NSLocalizedString(@"Flash", @"") atIndex:2 animated:YES];
	[_segmentedControlMessageType setSelectedSegmentIndex:0];
	
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
	
	if (_connection.type == BSConnectionTypeSMS) {
		_buttonCheckDestinationNumber.enabled = NO;
		_buttonCheckDestinationNumber.alpha = 0.3;
		
		_textFieldTo.placeholder = NSLocalizedString(@"To whom is message sent?", @"");
	}
	else {
		_textFieldFrom.enabled = NO;
		_textFieldFrom.alpha = 0.3;
		_textViewMessageBox.userInteractionEnabled = NO;
		_textViewMessageBox.alpha = 0.3;
		_segmentedControlMessageType.enabled = NO;
		_segmentedControlMessageType.alpha = 0.3;
		
		_textFieldTo.placeholder = NSLocalizedString(@"Enter number to perform HLR", @"");
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
	
}

- (void)buttonDoneClicked
{
	if (_connection.type == BSConnectionTypeHLR) {
		
		[_textFieldTo resignFirstResponder];
		return;
	}
	
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
		
		[_connection sendSMS:message withCompletionBlock:^(BSMessage *message, id error) {
			
			if (!error) {
				[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success!", @"") message:NSLocalizedString(@"Message was successfully sent!", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
			}
			else {
				[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error!", @"") message:NSLocalizedString(@"There was an error while sending message! Try again.", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
			}
		}];
	}
}

- (void)buttonCheckClicked {
	
	if ([Helper isNilOrEmpty:_textFieldTo.text]) {
		[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Warning!", @"") message:NSLocalizedString(@"You must enter number to perform HLR request.", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
		return; //Enter number to perform hlr
	}

	[_connection validateHLRForNumber:_textFieldTo.text onCompletion:^(BSHLR *hlr, id error) {
		
	}];
	
//	[_connection immediateHLRForNumber:_textFieldTo.text onCompletion:^(BSHLR *hlr, id error) {
//		//TODO: show result
//	}];
	
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

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
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
