//
//  RecentPhotos.h
//  TopPlace
//
//  Created by Jianbin Lei on 6/13/14.
//  Copyright (c) 2014 ou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecentPhotos : NSObject

+ (NSArray *)allPhotos; //of photos
+ (void)addPhoto: (NSDictionary *)photo;
 
@end
