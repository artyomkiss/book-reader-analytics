//
//  TCSAnalytics.h
//  BookReader
//
//  Created by Artem Kiselev on 25/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#if defined(FLURRY) || defined(GOOGLE) || defined(YANDEX)
#define ANALYTICS
#endif

#ifdef ANALYTICS

#import "TCSEventConstants.h"
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#ifdef GOOGLE
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h" //Custom tracking UITableViewControllers
#import "GAITrackedViewController.h" // Should be a parent of VCs you want to track
#endif


@interface TCSAnalytics : NSObject

+ (void)setupAnalyticsWithLaunchOptions:(NSDictionary *)launchOptions;

+ (void)updateLocation:(CLLocation *)location;

+ (void)logEventWithName:(NSString *)eventName;
+ (void)logEventWithName:(NSString *)eventName andParameters:(NSDictionary *)parameters;
+ (void)logEventWithName:(NSString *)eventName andParameters:(NSDictionary *)parameters startOrEndTimer:(BOOL)startOrEndTimer;

@end

#endif


