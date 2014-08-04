//
//  BSContactsViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/22/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSContactsViewController.h"

#import "BSContactsView.h"

#import "BSAddNewContactViewController.h"
#import "BSSendMessageViewController.h"

@interface BSContactsViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) BSContact *selectedContact;

@property (nonatomic, strong) NSArray *dataSourceContacts;
@property (nonatomic, strong) NSDictionary *dataSourceGroups;

@property (nonatomic, weak) UITableView *tableViewContacts;

@property (nonatomic, weak) UIButton *buttonAddContact;
@property (nonatomic, weak) UIButton *buttonBack;

- (void)setupTitles;

- (void)buttonAddContactClicked:(UIButton *)sender;
- (void)buttonBackClicked:(UIButton *)sender;

@end

@implementation BSContactsViewController

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
	BSContactsView *contactsView = [[BSContactsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	_buttonAddContact = contactsView.buttonAddContact;
	[_buttonAddContact addTarget:self action:@selector(buttonAddContactClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_buttonBack = contactsView.buttonBack;
	[_buttonBack addTarget:self action:@selector(buttonBackClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_tableViewContacts = contactsView.tableViewContacts;
	_tableViewContacts.dataSource = self;
	_tableViewContacts.delegate = self;
	
	self.view = contactsView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[[BSUser currentUser] getAllGroupsForNextPage:NO onCompletion:^(NSArray *groups, NSArray *errors) {

		NSMutableDictionary *mDict = [@{} mutableCopy];
		for (BSGroup *g in groups) {
			[mDict setObject:g forKey:g.groupID];
		}
		_dataSourceGroups = [NSDictionary dictionaryWithDictionary:mDict];
		
		[_tableViewContacts reloadData];
	}];
	
	[self setupTitles];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	[_tableViewContacts deselectRowAtIndexPath:[_tableViewContacts indexPathForSelectedRow] animated:YES];

	[[BSUser currentUser] getAllContactsfromGroup:nil sorted:nil forNextPage:NO onCompletion:^(NSArray *contacts, NSArray *errors) {
		_dataSourceContacts = contacts;
		[_tableViewContacts reloadData];
	}];
}

#pragma mark - Private methods

- (void)setupTitles
{
	[_buttonBack setTitle:NSLocalizedString(@"Back", @"") forState:UIControlStateNormal];
	[_buttonAddContact setTitle:NSLocalizedString(@"Add contact", @"") forState:UIControlStateNormal];
}

- (void)buttonAddContactClicked:(UIButton *)sender
{
	BSAddNewContactViewController *addVC = [[BSAddNewContactViewController alloc] init];
	[self.navigationController pushViewController:addVC animated:YES];
}

- (void)buttonBackClicked:(UIButton *)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _dataSourceContacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"ContactCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		[cell.textLabel setFont:[UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize]];
	}
	
	BSContact *contact = _dataSourceContacts[indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"%@, %@ - %@", contact.lastName, contact.firstName, contact.phoneNumber];
	cell.detailTextLabel.text = contact.group ? _dataSourceGroups ? [_dataSourceGroups[contact.group.groupID] name] : contact.group.groupID : @"Ungrouped";
	
	return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	_selectedContact = _dataSourceContacts[indexPath.row];
	
	if ([[BSUser currentUser] defaultConnection].type == BSConnectionTypeSMS) {
		[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Send message?", @"") message:NSLocalizedString(@"Are you sure that you want to send message to selected contact?", @"") delegate:self cancelButtonTitle:NSLocalizedString(@"Yes", @"") otherButtonTitles:NSLocalizedString(@"No", @""), nil] show];
	}
	else {
		[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"") message:NSLocalizedString(@"Your default connection is unable to send messages!", @"") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil] show];
	}
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex) {
		case 0:
		{
			BSSendMessageViewController *smsVC = [[BSSendMessageViewController alloc] initWithConnection:[[BSUser currentUser] defaultConnection] forContact:_selectedContact];
			[self.navigationController pushViewController:smsVC animated:YES];
		}
			break;
		case 1:
		{
			_selectedContact = nil;
			[_tableViewContacts deselectRowAtIndexPath:[_tableViewContacts indexPathForSelectedRow] animated:YES];
		}
			break;
		default:
			break;
	}
}

@end
