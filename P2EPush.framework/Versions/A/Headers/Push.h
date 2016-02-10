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

@interface Push : NSObject

+ (void)startPush;
+ (void)startPushWithConfiguration:(PushConfig*)configuration;
+ (void)updatePushConfigration:(PushConfig*)configuration;

+ (PushConfig*)getPushConfig;

+ (BOOL)isQuietTimeEnabled;
+ (void)enableQuiteTimeStartHour:(NSInteger)startHour
                     startMinute:(NSInteger)startMinute
                         endHour:(NSInteger)endHour
                       endMinute:(NSInteger)endMinute;
+ (void)disableQuietTime;

// Tags
+ (NSArray*)getTags;
+ (NSArray*)getTagsForGroup:(NSString*)groupName;

+ (void)addTag:(NSString*)tagName;
+ (void)addTag:(NSString*)tagName inGroup:(NSString*)groupName;
+ (void)removeTag:(NSString*)tagName;
+ (void)removeTag:(NSString*)tagName inGroup:(NSString*)groupName;

+ (void)updateBadgeCount:(NSInteger)badgeCount;
+ (void)increaseBadgeCount;
+ (void)decreaseBadgeCount;
+ (void)resetBadgeCount;

// Location
+ (void)sendLocation;
+ (void)sendLocation:(CLLocation*)location;

@end
