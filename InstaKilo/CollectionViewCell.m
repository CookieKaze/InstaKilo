//
//  CollectionViewCell.m
//  InstaKilo
//
//  Created by Erin Luu on 2016-11-16.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@end


@implementation CollectionViewCell

- (void) setImageName:(NSString *)imageName {
    self.cellImageView.image = [UIImage imageNamed:imageName];
    _imageName = imageName;
}

@end
