//
//  PushConfig.h
//  Pods
//
//  Created by Push2Engage on 04/11/15.
//  Copyright © 2016 Push2Engage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface PushConfig : NSObject

#pragma mark - App Key
@property (nonatomic, strong) NSString *productionAppKey;
@property (nonatomic, strong) NSString *productionAppKeySecret;

@property (nonatomic, strong) NSString *developmentAppKey;
@property (nonatomic, strong) NSString *developmentAppKeySecret;


#pragma mark - Location
@property (nonatomic, assign) BOOL locationEnabled;

// Default 10 sec
@property (nonatomic, assign) NSTimeInterval locationTimeout;

// Default 1000m
@property (nonatomic, assign) CLLocationAccuracy desiredAccuracy;

// Default NO (This will continue fetching location with minimum interval of 1 hour.)
@property (nonatomic, assign) BOOL allowsContinousLocationUpdates;

@end
