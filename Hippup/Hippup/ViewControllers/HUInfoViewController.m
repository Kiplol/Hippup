//
//  HUInfoViewController.m
//  Hippup
//
//  Created by Elliott Kipper on 7/14/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import "HUInfoViewController.h"
#import "HUInfoCell.h"
#import "BodilyFunctionManager.h"
#import <Parse/Parse.h>

#define ROW_USERNAME 0
#define ROW_BF_COUNT 1
#define TOTAL_ROWS 2

@interface HUInfoViewController ()

@end

@implementation HUInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _arrMyBFs = [[NSMutableArray alloc] init];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        _arrMyBFs = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    //Refresh my bodily functions
    _arrMyBFs = [NSMutableArray arrayWithArray:[[BodilyFunctionManager getInstance] bodilyFunctionsForUser:[PFUser currentUser].username]];
    [_collectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HUInfoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"infoCell" forIndexPath:indexPath];
    if(indexPath.row == ROW_USERNAME)
    {
        cell.keyLabel.text = @"USERNAME";
        if(!_szUsername)
            _szUsername = [PFUser currentUser].username;
        cell.valueLabel.text = _szUsername;
    }
    else if(indexPath.row == ROW_BF_COUNT)
    {
        cell.keyLabel.text = @"Hiccups";
        cell.valueLabel.text = [NSString stringWithFormat:@"%d", _arrMyBFs.count];
    }
    else
    {
        int idx = indexPath.row - TOTAL_ROWS;
        BodilyFunctionModel * bfm = [_arrMyBFs objectAtIndex:idx];
        cell.keyLabel.text = [BodilyFunctionModel stringForType:bfm.type];

        NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:bfm.timestamp];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MMM dd, hh:mm:ss a"];
        NSString *dateString = [dateFormat stringFromDate:theDate];
        cell.valueLabel.text = dateString;
    }
    [cell setNeedsLayout];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return TOTAL_ROWS + _arrMyBFs.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
@end
