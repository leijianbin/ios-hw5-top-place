//
//  RecentPhotos.m
//  TopPlace
//
//  Created by Jianbin Lei on 6/13/14.
//  Copyright (c) 2014 ou. All rights reserved.
//

#import "RecentPhotos.h"
#import "FlickrFetcher.h"

#define RECENT_PHOTOS_KEY @"Recent_Photos_Key"
#define RECENT_PHOTOS_MAX_NUMBER 20

@implementation RecentPhotos

+ (NSArray *)allPhotos
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:RECENT_PHOTOS_KEY];
}

+ (void)addPhoto: (NSDictionary *)photo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *photos = [[defaults objectForKey:RECENT_PHOTOS_KEY] mutableCopy];
    
    //
    if (!photos) {
        photos = [[NSMutableArray alloc] init];
    }
    // search
    for (NSDictionary *obj in photos) {
        if( [[obj valueForKeyPath:FLICKR_PHOTO_ID] isEqualToString:[photo valueForKeyPath:FLICKR_PHOTO_ID] ])
        {
            [photos removeObject:obj];    // remove
            break;
        }
    }
    
    // add itself
    [photos insertObject:photo atIndex:0];
    
    // remove the last one if the length of the array large than the Max lenght
    
    if ([photos count] > RECENT_PHOTOS_MAX_NUMBER) {
        [photos removeLastObject];
    }
    //
    
    [defaults setObject:photos forKey:RECENT_PHOTOS_KEY];
    [defaults synchronize];
}

@end
