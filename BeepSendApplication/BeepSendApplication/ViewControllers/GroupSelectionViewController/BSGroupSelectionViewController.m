//
//  BSGroupSelectionViewController.m
//  BeepSendApplication
//
//  Created by Vladica Pesic on 7/22/14.
//  Copyright (c) 2014 BeepSend. All rights reserved.
//

#import "BSGroupSelectionViewController.h"

#import "BSGroupSelectionView.h"

@interface BSGroupSelectionViewController ()

- (void)setupTitles;

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
	BSGroupSelectionView *groupSelectionView = [[BSGroupSelectionView alloc] initWithFrame:[UIScreen mainScreen].bounds];
	
	self.view = groupSelectionView;
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
	
}

@end
