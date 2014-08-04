//
//  BSGroupSelectionViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/22/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGroupSelectionViewController.h"

#import "BSContactsView.h"

@interface BSGroupSelectionViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *dataSourceGroups;

@property (nonatomic, weak) UITableView *tableViewGroups;

@property (nonatomic, weak) UIButton *buttonAddContact;
@property (nonatomic, weak) UIButton *buttonBack;

- (void)setupTitles;

- (void)buttonAddContactClicked:(UIButton *)sender;
- (void)buttonBackClicked:(UIButton *)sender;

@end

@implementation BSGroupSelectionViewController

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
	BSContactsView *groupSelectionView = [[BSContactsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	_buttonAddContact = groupSelectionView.buttonAddContact;
	[_buttonAddContact addTarget:self action:@selector(buttonAddContactClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_buttonBack = groupSelectionView.buttonBack;
	[_buttonBack addTarget:self action:@selector(buttonBackClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	_tableViewGroups = groupSelectionView.tableViewContacts;
	_tableViewGroups.dataSource = self;
	_tableViewGroups.delegate = self;
	
	self.view = groupSelectionView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self setupTitles];
	
	[[BSUser currentUser] getAllGroupsForNextPage:NO onCompletion:^(NSArray *groups, NSArray *errors) {
		_dataSourceGroups = groups;
		[_tableViewGroups reloadData];
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)setupTitles
{
	[_buttonBack setTitle:NSLocalizedString(@"Back", @"") forState:UIControlStateNormal];
	[_buttonAddContact setTitle:NSLocalizedString(@"Add group", @"") forState:UIControlStateNormal];
}

- (void)buttonAddContactClicked:(UIButton *)sender
{
	UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Create new group?", @"")
														  message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	myAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
	[myAlertView show];

}

- (void)buttonBackClicked:(UIButton *)sender
{
	[self dismissViewControllerAnimated:YES completion:^{
		
	}];
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _dataSourceGroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"GroupCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		[cell.textLabel setFont:[UIFont fontWithName:kDefaultTextFontName size:kTextFieldDefaultTextSize]];
	}
	
	BSGroup *group = _dataSourceGroups[indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"%@ - (%@)", group.name, group.contactsCount];
	
	return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([_delegate respondsToSelector:@selector(groupSelectionViewController:didSelectGroup:)]) {
		[_delegate groupSelectionViewController:self didSelectGroup:_dataSourceGroups[indexPath.row]];
	}
	
	[self buttonBackClicked:nil];
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
			NSString *groupName = [alertView textFieldAtIndex:0].text;
			BSGroup *group = [[BSGroup alloc] initGroupWithName:groupName];
			[group saveGroupOnCompletion:^(BSGroup *group, NSArray *errors) {
				
			}];
			
			NSMutableArray *mArr = [_dataSourceGroups mutableCopy];
			[mArr addObject:group];
			_dataSourceGroups = [NSArray arrayWithArray:mArr];
			[_tableViewGroups reloadData];
		}
			break;
		default:
			break;
	}
}

@end
