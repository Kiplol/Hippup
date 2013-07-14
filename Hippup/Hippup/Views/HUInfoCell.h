//
//  HUInfoCell.h
//  Hippup
//
//  Created by Elliott Kipper on 7/14/13.
//  Copyright (c) 2013 Supernovacaine Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUInfoCell : UICollectionViewCell {
    IBOutlet UILabel * _lblKey;
    IBOutlet UILabel * _lblValue;
}

@property (nonatomic, readonly) UILabel * keyLabel;
@property (nonatomic, readonly) UILabel * valueLabel;

@end
