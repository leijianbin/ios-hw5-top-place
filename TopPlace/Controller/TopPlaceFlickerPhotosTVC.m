//
//  TopPlaceFlickerPhotosTVC.m
//  TopPlace
//
//  Created by Jianbin Lei on 5/31/14.
//  Copyright (c) 2014 ou. All rights reserved.
//

#import "TopPlaceFlickerPhotosTVC.h"
#import "FlickrFetcher.h"
#import "FlickerPlacesTVC.h"
#import "FlickPhotoForPlaceTVC.h"


@interface TopPlaceFlickerPhotosTVC ()

@end

@implementation TopPlaceFlickerPhotosTVC



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchPlaces];
    // Do any additional setup after loading the view.
}

- (void)fetchPlaces
{
    NSURL *url = [FlickrFetcher URLforTopPlaces];

    //muti-thread
    dispatch_queue_t fetchQ = dispatch_queue_create("flickr fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSData *jsonResult = [NSData dataWithContentsOfURL:url];
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResult
                                                                            options:0
                                                                              error:NULL];
        //NSLog(@"Flikr Result = %@", propertyListResults);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *places = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PLACES];
            self.topPlaces = places;
        });
    });
}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if ([sender isKindOfClass:[UITableViewCell class]]) {
         NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
         if (indexPath) {
             if ([segue.identifier isEqualToString:@"Select Place"]) {
                 if ([segue.destinationViewController isKindOfClass:[FlickPhotoForPlaceTVC class]]) {
                    //
                    NSDictionary *place = [self placeForRowAtIndexPath:indexPath];
                    FlickPhotoForPlaceTVC *fppTVC = segue.destinationViewController;
                    fppTVC.place = place;
                 }
             }
         }
     }
 }


@end
