//
//  Push.h
//  Pods
//
//  Created by Push2Engage on 29/10/15.
//  Copyright © 2016 Push2Engage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class PushConfig;

/**
 *  This class provides an interface to the functionality provided by the Push2Engage iOS Push API.
 */
@interface Push : NSObject

/**
 *  Initalizes and starts Push2Engage iOS SDK. 
 *  For this to work, "p2e.plist" file should be should be created in your project. 
 *  "p2e.plist" must have "productionAppKey", "productionKeySecret", "developmentAppKey" and "developmentKeySecret". key and its corresponding value.
 *  While is development "productionAppKey", "productionKeySecret" can be omited.
 */
+ (void)startPush;

/**
 *  Initalize and starts Push2Engage iOS SDK with configuration. When using "startPushWithConfiguration" developer do not need to have "p2e.plst" file. All congiguration is passed by "PushConfig" object.
 *
 *  @param configuration Contains configuration that will be used for initalizing and starting Push2Engage SDK. "productionAppKey", "productionAppKeySecret", "developmentAppKey" and "developmentAppKeySecret" are mandatory.
 */
+ (void)startPushWithConfiguration:(PushConfig*)configuration;

/**
 *  Update existing configuration for Push2Engage. When this is function is called, configuration is validated and and if the configuration is OK, Push2Engage is reinitalized and restarted.
 *
 *  @param configuration Contains configuration that will be used for initalizing and starting Push2Engage SDK. "productionAppKey", "productionAppKeySecret", "developmentAppKey" and "developmentAppKeySecret" are mandatory.
 */
+ (void)updatePushConfigration:(PushConfig*)configuration;

/**
 *  Fetches existing Push2Engage configuration.
 *
 *  @return PushConfig object
 */
+ (PushConfig*)getPushConfig;

/**
 *  Tells if Quite time is enabled or not.
 *
 *  @return YES or NO. If YES, this means end user will not receive any notification during a specified time range. NO means Quite time is disabled, and push notification will be send to the end user.
 */
+ (BOOL)isQuietTimeEnabled;

/**
 *  Returns a dictionary with the details for Quite Time. If quite time is enabled, NSDictionary with key "startTime" and "endTime" will be returned. The value for both the keys will be in HH:MM 24 hour format.
 *
 *  @return NSDictionary with Quite time details. If nil is returned, this means quite time has not been set.
 */
+ (NSDictionary*)getQuietTime;

/**
 *  This function is used to enable Quite Time. End user will not receive any notification during a specified time range.
 *
 *  @param startHour   Quiet time start hour. Only 0-23 is valid.
 *  @param startMinute Quiet time start minute. Only 0-59 is valid.
 *  @param endHour     Quiet time end hour. Only 0-23 is valid.
 *  @param endMinute   Quiet time end minute. Only 0-59 is valid.
 */
+ (void)enableQuiteTimeStartHour:(NSInteger)startHour
                     startMinute:(NSInteger)startMinute
                         endHour:(NSInteger)endHour
                       endMinute:(NSInteger)endMinute;

/**
 *  Disables Quite Time.
 */
+ (void)disableQuietTime;

/**
 *  Gets all tags that is accoaicated with the user. Contains key value pair. Key is the group name. All the tags that is created via "addTag" method goes under "generic" group name.
 *
 *  @return NSDictionary of tags. Group name as key and array of tags in value.
 */
+ (NSDictionary*)getAllTags;

/**
 *  Get all Generic tags.
 *
 *  @return Array of tags from generic group.
 */
+ (NSArray*)getGenericTags;

/**
 *  Get all the tags under a specified Group Name
 *
 *  @param groupName Group name that is used
 *
 *  @return Will fetch array of tags under specified group name.
 */
+ (NSArray*)getTagsForGroupName:(NSString*)groupName;

/**
 *  Add tags under Generic Group Name
 *
 *  @param tagName Tag name that will be associcated with generic group name.
 */
+ (void)addTag:(NSString*)tagName;

/**
 *  Add tag under specified group name
 *
 *  @param tagName   Tag name to be added under the specified group name.
 *  @param groupName Group Name. If This group is not created, new group with the specified name will be created.
 */
+ (void)addTag:(NSString*)tagName inGroup:(NSString*)groupName;

/**
 *  Remove tag under generic group name.
 *
 *  @param tagName Tag name to de deleted under generic group.
 */
+ (void)removeTag:(NSString*)tagName;

/**
 *  Remove tag under specified group name
 *
 *  @param tagName   Tag name to be removed under the specified group name.
 *  @param groupName Group name under which the tag will be deleted
 */
+ (void)removeTag:(NSString*)tagName inGroup:(NSString*)groupName;

/**
 *  Updates the badge count on Push2Engage server. Also "[[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeCount];" is executed so that the client and Push2Engage server are in sync.
 *
 *  @param badgeCount Badge count that is pushed to Push2Engage server as well as client.
 */
+ (void)updateBadgeCount:(NSInteger)badgeCount;

/**
 *  Increment badge count by +1. Also "[[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeCount];" is executed so that the client and Push2Engage server are in sync.
 */
+ (void)incrementBadgeCount;

/**
 *  Decrement badge count by -1. Also "[[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeCount];" is executed so that the client and Push2Engage server are in sync.
 */
+ (void)decrementBadgeCount;

/**
 *  Reset badge count to 0. Also "[[UIApplication sharedApplication] setApplicationIconBadgeNumber:badgeCount];" is executed so that the client and Push2Engage server are in sync.
 */
+ (void)resetBadgeCount;

/**
 *  Send location to Push2Engage server. This will only work if the "locationEnabled" is set to YES in PushConfig.
 */
+ (void)sendLocation;

/**
 *  Send location to Push2Engage server.
 *
 *  @param location Location that needs to be updated to Push2Engage server.
 */
+ (void)sendLocation:(CLLocation*)location;

/**
 *  Set alias for user.
 *
 *  @param alias Alias that will be associated with the user.
 */
+ (void)setAlias:(NSString *)alias;

/**
 *  Set email for user.
 *
 *  @param emailID Email that will be associated with the user.
 */
+ (void)setEmailID:(NSString *)emailID;

@end
