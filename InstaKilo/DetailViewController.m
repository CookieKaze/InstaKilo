//
//  DetailViewController.m
//  InstaKilo
//
//  Created by Erin Luu on 2016-11-16.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = [UIImage imageNamed:self.imageName];
}


@end
