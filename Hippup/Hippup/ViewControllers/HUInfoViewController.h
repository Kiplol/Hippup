//
//  HUInfoViewController.h
//  Hippup
//
//  Created by Elliott Kipper on 7/14/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUInfoViewController : UIViewController <UICollectionViewDataSource> {
    IBOutlet UICollectionView * _collectionView;
    NSString * _szUsername;
    NSMutableArray * _arrMyBFs;
}

@end
