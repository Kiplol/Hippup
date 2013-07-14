//
//  HUInfoViewController.m
//  Hippup
//
//  Created by Elliott Kipper on 7/14/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import "HUInfoViewController.h"
#import "HUInfoCell.h"
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
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [_collectionView registerClass:[HUInfoCell class] forCellWithReuseIdentifier:@"infoCell"];
	// Do any additional setup after loading the view.
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
        cell.keyLabel.text = @"BFS";
        cell.valueLabel.text = @"";
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return TOTAL_ROWS;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
@end
