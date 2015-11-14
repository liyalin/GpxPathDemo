//
//  MapPathViewController.h
//  GpxPathDemo
//
//  Created by phil on 15/11/14.
//  Copyright © 2015年 lyl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GPXParser.h"


@interface MapPathViewController : UIViewController <MKMapViewDelegate >
{
}
@property (nonatomic ,strong) MKMapView * mapView;
@end
