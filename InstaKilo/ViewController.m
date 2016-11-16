
//
//  ViewController.m
//  InstaKilo
//
//  Created by Erin Luu on 2016-11-16.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import "ViewController.h"
#import "PhotoManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property PhotoManager * photoManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoManager = [[PhotoManager alloc] init];
    self.collectionView.dataSource = self.photoManager;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    CGFloat width = self.collectionView.frame.size.width/2-1;
    CGSize size = CGSizeMake(width, width);
    layout.itemSize = size;
    [layout setMinimumLineSpacing:1];
    [layout setMinimumInteritemSpacing:1];
    
    [self.photoManager sortByLocation];
}



@end
