//
//  FlickPhotoForPlaceTVC.m
//  TopPlace
//
//  Created by Jianbin Lei on 6/3/14.
//  Copyright (c) 2014 ou. All rights reserved.
//

#import "FlickPhotoForPlaceTVC.h"
#import "FlickrFetcher.h"

@interface FlickPhotoForPlaceTVC ()

@end

@implementation FlickPhotoForPlaceTVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchPhotos];
    // Do any additional setup after loading the view.
}

- (void)setPlace:(NSDictionary *)place
{
    _place = place;
    self.title = [self.place valueForKey:@"title"];
    [self fetchPhotos];
}

- (void)fetchPhotos
{
    NSURL *url = [FlickrFetcher URLforPhotosInPlace:[self.place valueForKeyPath:FLICKR_PLACE_ID] maxResults:50];
    
    //muti-thread
    dispatch_queue_t fetchQ = dispatch_queue_create("flickr photos fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSData *jsonResult = [NSData dataWithContentsOfURL:url];
        NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResult
                                                                            options:0
                                                                              error:NULL];
        //NSLog(@"Flikr Photo Result = %@", propertyListResults);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
            self.photos = photos;
        });
    });
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
