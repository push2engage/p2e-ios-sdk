//
//  PushConfig.h
//  Pods
//
//  Created by Push2Engage on 04/11/15.
//  Copyright © 2016 Push2Engage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


/**
 *  Object of this class is passed to "startPushWithConfiguration" or "updatePushConfigration" funtion in Push.h.
 */
@interface PushConfig : NSObject

/**
 *  Production Key is mandatory when application is in Release Mode.
 */
@property (nonatomic, strong) NSString *productionAppKey;

/**
 *  Production Key Secret is mandatory when application is in Release Mode.
 */
@property (nonatomic, strong) NSString *productionAppKeySecret;

/**
 *  Devlopment Key is mandatory when application is in Release Mode.
 */
@property (nonatomic, strong) NSString *developmentAppKey;

/**
 *  Devlopment Key Secret is mandatory when application is in Release Mode.
 */
@property (nonatomic, strong) NSString *developmentAppKeySecret;


/**
 *  If this is set yes, and the end user has provided access for locationn services, then the app will fetch location every time app is launched or every time the applicationn goes comes to foregorund.
 */
@property (nonatomic, assign) BOOL locationEnabled;

/**
 *  Location timeout value by default is 10 seconds. It tells the SDK to keep looking for the valid location till the timeout period. If the timeout period expires, location fetching will be diabled.
 */
@property (nonatomic, assign) NSTimeInterval locationTimeout;

/**
 *  Represents the accuracy in meters for Location service. Default is set to 1000 meters.
 */
@property (nonatomic, assign) CLLocationAccuracy desiredAccuracy;

/**
 *  This tells the SDK to fecth location in background. By default this is set to NO. If this is set, location will be fetched every hour.
 */
@property (nonatomic, assign) BOOL allowsContinousLocationUpdates;

@end
