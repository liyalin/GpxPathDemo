//
//  MapPathViewController.m
//  GpxPathDemo
//
//  Created by phil on 15/11/14.
//  Copyright © 2015年 lyl. All rights reserved.
//

#import "MapPathViewController.h"

@interface MapPathViewController ()

@end

@implementation MapPathViewController
@synthesize mapView = _mapView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self parserGpxFile];
}


-(void) parserGpxFile
{
    NSString *fielPath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"gpx"];
    NSData *fileData = [NSData dataWithContentsOfFile:fielPath];

    [GPXParser parse:fileData completion:^(BOOL success, GPX *gpx) {
        // success indicates completion
        // gpx is the parsed file
        if (success)
        {
            NSLog( @"%@",gpx);
            _mapView = [[MKMapView alloc] initWithFrame:[self.view bounds]];
            _mapView.showsUserLocation = YES;
            _mapView.mapType = MKMapTypeStandard;
            _mapView.delegate = self;
            [self.view addSubview:_mapView];
            
            [self updateRouteView:[gpx.tracks objectAtIndex:0]];
        }
    }];
}

-(void) updateRouteView :(Track *)track
{
    [_mapView removeOverlays:_mapView.overlays];
    
    CLLocationCoordinate2D *points = malloc([track.fixes count] * sizeof(CLLocationCoordinate2D));
    for(int i = 0; i < track.fixes.count; i++) {
        CLLocationCoordinate2D coords;
        Fix * demo_fixes = [track.fixes objectAtIndex:i];
        coords.latitude = demo_fixes.coordinate.latitude;
        coords.longitude = demo_fixes.coordinate.longitude;
        points[i] = coords;
    }
    MKPolyline *myPolyline = [MKPolyline polylineWithCoordinates:points count:[track.fixes count]];
    free(points);
    [_mapView addOverlay:myPolyline];
}


- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineView *lineview=[[MKPolylineView alloc] initWithOverlay:overlay] ;
        lineview.strokeColor=[UIColor redColor];
        lineview.lineWidth=8.0;
        return lineview;
    }
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
