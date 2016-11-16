//
//  PhotoManager.m
//  InstaKilo
//
//  Created by Erin Luu on 2016-11-16.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import "PhotoManager.h"
#import "Photo.h"
#import "CollectionViewCell.h"
#import "CollectionReusableView.h"


@interface PhotoManager ()
@property UICollectionView * collectionView;
@end

@implementation PhotoManager 
#pragma mark - Setup
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createMasterCollection];
    }
    return self;
}

-(void) createMasterCollection {
    if (!_masterCollection) {
        _masterCollection = [[NSMutableArray alloc] init];
    }
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    NSError * error;
    NSMutableArray * directoryContents = (NSMutableArray*)[[NSFileManager defaultManager] contentsOfDirectoryAtPath:resourcePath error:&error];
    NSMutableArray * imagesCollection = [[NSMutableArray alloc] init];
    
    for (NSString * object in directoryContents) {
        if([[object substringToIndex:5] isEqualToString: @"image"]) {
            [imagesCollection addObject:object];
        }
    }
    for (NSString * image in imagesCollection) {
        Photo * photo = [[Photo alloc] init];
        photo.name = image;
        switch ([image characterAtIndex:5]) {
            case '0':
            case '6':
            case '7':
            case '8':
                photo.location = @"Akihabara";
                break;
            case '2':
            case '3':
            case '4':
            case '5':
            case '9':
            case '1':
                photo.location = @"Shibuya";
                break;
            default:
                break;
        }
        switch ([image characterAtIndex:5]) {
            case '3':
            case '4':
            case '5':
            case '8':
            case '9':
                photo.subject = @"Food";
                break;
            case '1':
            case '2':
            case '6':
            case '7':
            case '0':
                photo.subject = @"Other";
                break;
            default:
                break;
        }
        [self.masterCollection addObject:photo];
    }
}

#pragma mark - Sorting
-(void) sortByLocation {
    self.sortedBy = @"Location";
    NSMutableArray * shibuyaArray = [[NSMutableArray alloc] init];
    NSMutableArray * akihabaraArray = [[NSMutableArray alloc] init];
    for (Photo * photo in self.masterCollection) {
        if ([photo.location isEqualToString:@"Shibuya"]) {
            [shibuyaArray addObject: photo];
        }else if ([photo.location isEqualToString:@"Akihabara"]) {
            [akihabaraArray addObject:photo];
        }
    }
    self.sortedCollection = @[akihabaraArray, shibuyaArray];
}

-(void) sortBySubject {
    self.sortedBy = @"Subject";
    NSMutableArray * FoodArray = [[NSMutableArray alloc] init];
    NSMutableArray * OtherArray = [[NSMutableArray alloc] init];
    for (Photo * photo in self.masterCollection) {
        if ([photo.subject isEqualToString:@"Food"]) {
            [FoodArray addObject: photo];
        }else if ([photo.subject isEqualToString:@"Other"]) {
            [OtherArray addObject:photo];
        }
    }
    self.sortedCollection = @[FoodArray, OtherArray];
}

#pragma mark - Collection DataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.collectionView = collectionView;
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Photo * currentPhoto;
    
    if (!self.sortedCollection) {
        currentPhoto = self.masterCollection[indexPath.row];
    } else {
        NSArray * sectionPhotos = self.sortedCollection[indexPath.section];
        currentPhoto = sectionPhotos[indexPath.row];
    }
    
    cell.imageName = currentPhoto.name;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reuseableView" forIndexPath:indexPath];
    if (!self.sortedCollection) {
        headerView.titleLabel.text = @"My Images";
    }else {
        NSArray * sectionPhotos = self.sortedCollection[indexPath.section];
        Photo * currentPhoto = sectionPhotos[indexPath.row];
        if ([self.sortedBy isEqualToString:@"Location"]) {
            headerView.titleLabel.text = currentPhoto.location;
        }else if ([self.sortedBy isEqualToString:@"Subject"]) {
            headerView.titleLabel.text = currentPhoto.subject;
        }
    }
    return headerView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger count;
    if (!self.sortedCollection) {
        count = 1;
    }else {
        count = [self.sortedCollection count];
    }
    return count;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count;
    if (!self.sortedCollection) {
        count = [self.masterCollection count];
    }else {
        count = [self.sortedCollection[section] count];
    }
    return count;
}

-(NSString*) getImageName: (NSIndexPath *) indexPath {
    NSString * name;
    Photo * currentPhoto;
    if (!self.sortedBy) {
        currentPhoto = self.masterCollection[indexPath.row];
        name = currentPhoto.name;
    } else {
        NSArray * sectionPhotos = self.sortedCollection[indexPath.section];
        currentPhoto = sectionPhotos[indexPath.row];
        name = currentPhoto.name;
    }
    return name;
}
@end
