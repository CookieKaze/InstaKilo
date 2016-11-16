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


@interface PhotoManager ()
@property UICollectionView * collectionView;
@end

@implementation PhotoManager 

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

-(void) sortByLocation {
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
    NSLog(@"%ld", (long)section);
    if (!self.sortedCollection) {
        count = [self.masterCollection count];
    }else {
        count = [self.sortedCollection[section] count];
    }
    return count;
}
@end
