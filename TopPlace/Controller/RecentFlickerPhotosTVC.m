//
//  RecentFlickerPhotosTVC.m
//  TopPlace
//
//  Created by Jianbin Lei on 6/14/14.
//  Copyright (c) 2014 ou. All rights reserved.
//

#import "RecentFlickerPhotosTVC.h"
#import "RecentPhotos.h"

@interface RecentFlickerPhotosTVC ()

@end

@implementation RecentFlickerPhotosTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchPhotos];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self fetchPhotos];
}

- (void)fetchPhotos
{
    self.photos = [RecentPhotos allPhotos];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
