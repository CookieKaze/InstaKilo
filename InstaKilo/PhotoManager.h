//
//  PhotoManager.h
//  InstaKilo
//
//  Created by Erin Luu on 2016-11-16.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Photo;

@interface PhotoManager : NSObject <UICollectionViewDataSource>

@property NSMutableArray * masterCollection;
@property NSArray * sortedCollection;
@property NSString * sortedBy;

-(void) createMasterCollection;
-(void) sortByLocation;
-(void) sortBySubject;
-(NSString*) getImageName: (NSIndexPath *) indexPath;

@end
