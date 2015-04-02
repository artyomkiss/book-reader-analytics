//
//  TCSAnalytics.m
//  BookReader
//
//  Created by Artem Kiselev on 25/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import "TCSAnalytics.h"
#import <OpenUDID/OpenUDID.h>
#import <objc/runtime.h>

#ifdef FLURRY
#import "Flurry.h"
#endif

#ifdef YANDEX
#import <YandexMobileMetrica/YandexMobileMetrica.h>
#endif


@implementation TCSAnalytics




#pragma mark - Setup Analytics

+ (void)setupAnalyticsWithLaunchOptions:(NSDictionary *)launchOptions
{
#ifdef FLURRY
    
    [self setupFlurryWithLaunchOptions:launchOptions];
    
#endif
    
#ifdef GOOGLE
    
    [self setupGoogleWithLaunchOptions:launchOptions];
    
#endif
    
#ifdef YANDEX
    
    [self setupYandexWithLaunchOptions:launchOptions];
    
#endif
}




#pragma mark - Setup Flurry

#ifdef FLURRY

+ (void)setupFlurryWithLaunchOptions:(NSDictionary *)launchOptions
{
    //Запуск процесса сбора статистики
    [Flurry startSession:@"TF5YHBTV2T9X2C8PK28R" withOptions:launchOptions];
    
    //Задание времени между отправками событий
    [Flurry setSessionReportsOnCloseEnabled:YES];
    [Flurry setSessionReportsOnPauseEnabled:YES];

    //Установка уровня логирования
#ifdef DEBUG
    [Flurry setDebugLogEnabled:YES];
    [Flurry setLogLevel:FlurryLogLevelAll];
#endif
    
    //Включение отслеживания необработанных исключений
    [Flurry setCrashReportingEnabled:YES];

    // Установка пола и возраста
    [Flurry setAge:25];
    [Flurry setGender:@"m"]; //@"f" - female, m - male
    
    //Отслеживание экранов
    UIWindow * window = [[[UIApplication sharedApplication]delegate]window];
    UINavigationController * navigationController = (UINavigationController *)[window rootViewController];
    if ([navigationController isKindOfClass:[UINavigationController class]])
    {
        //UINavigationController or UITabBarController
        [Flurry logAllPageViewsForTarget:navigationController];
        //вручную с помощью [Flurry logPageView]
        
        //Остановить логирование переходов для navigationController
//        [Flurry stopLogPageViewsForTarget:navigationController];
    }
}

#endif



#pragma mark - Setup Google

#ifdef GOOGLE

+ (void)setupGoogleWithLaunchOptions:(NSDictionary *)launchOptions
{
    //Запуск процесса сбора статистики
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-60345116-3"];

    //Задание времени между отправками событий
    [GAI sharedInstance].dispatchInterval = 20;
 
    //Установка уровня логирования
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    //Включение отслеживания необработанных исключений
    
    // Optional: set Logger to VERBOSE for debug information.
#ifdef DEBUG
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
#endif
    
    // Enable IDFA collection.
    [[GAI sharedInstance] defaultTracker].allowIDFACollection = YES;
}

+ (NSMutableDictionary *)datesForEventsDictionariesForTracker:(id<GAITracker>)tracker
{
    NSMutableDictionary * datesDict = (NSMutableDictionary *)objc_getAssociatedObject(tracker, @selector(datesForEventsDictionariesForTracker:));
    
    if (!datesDict)
    {
        datesDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(tracker, @selector(datesForEventsDictionariesForTracker:), datesDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return datesDict;
}

#endif




#pragma mark - Setup Yandex

#ifdef YANDEX

+ (void)setupYandexWithLaunchOptions:(NSDictionary *)launchOptions
{
    //Запуск процесса сбора статистики
    [YMMYandexMetrica startWithAPIKey:@"34970"];
    
    //Задание времени между отправками событий
    [YMMYandexMetrica setDispatchPeriod:20];
    
    //Включение отслеживания необработанных исключений
    [YMMYandexMetrica setReportCrashesEnabled:YES];
    
    //Включение отслеживания положения пользователя
    [YMMYandexMetrica setTrackLocationEnabled:YES];
}

#endif



#pragma mark - Update Location

+ (void)updateLocation:(CLLocation *)location
{
#ifdef FLURRY
    
    [Flurry setLatitude:location.coordinate.latitude
              longitude:location.coordinate.longitude
     horizontalAccuracy:location.horizontalAccuracy
       verticalAccuracy:location.verticalAccuracy];
    
#endif
    
#ifdef GOOGLE
    
    //GOOGLE == Nostradamus. It doesn't need location. It just knows.
    
#endif
    
#ifdef YANDEX
    
    [YMMYandexMetrica setLocation:location];
    
#endif
}




#pragma mark - Logging Events

+ (void)logEventWithName:(NSString *)eventName
{
#ifdef FLURRY
    
    [Flurry logEvent:eventName];
    
#endif
    
#ifdef GOOGLE
    
    NSDictionary * eventDictionary = [[GAIDictionaryBuilder createEventWithCategory:@"Event" action:eventName label:@"" value:nil]build];
    [[[GAI sharedInstance]defaultTracker] send:eventDictionary];
    
#endif
    
#ifdef YANDEX
    
    [YMMYandexMetrica reportEvent:eventName onFailure:nil];
    
#endif
}

+ (void)logEventWithName:(NSString *)eventName andParameters:(NSDictionary *)parameters
{
#ifdef FLURRY

    [Flurry logEvent:eventName withParameters:parameters];
    
#endif
    
#ifdef GOOGLE
    
    NSData * parametersData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
    NSString * parametersString = [[NSString alloc]initWithData:parametersData encoding:NSUTF8StringEncoding];
    NSDictionary * eventDictionary = [[GAIDictionaryBuilder createEventWithCategory:@"Event with parameters" action:eventName label:parametersString value:nil]build];
    [[[GAI sharedInstance]defaultTracker] send:eventDictionary];

#endif
    
#ifdef YANDEX
    
    [YMMYandexMetrica reportEvent:eventName parameters:parameters onFailure:nil];
    
#endif
}

+ (void)logEventWithName:(NSString *)eventName andParameters:(NSDictionary *)parameters startOrEndTimer:(BOOL)startOrEndTimer
{
#ifdef FLURRY
    
    if (startOrEndTimer)
    {
        [Flurry logEvent:eventName withParameters:parameters timed:YES];
    }
    else
    {
        [Flurry endTimedEvent:eventName withParameters:parameters];
    }
    
#endif
    
#ifdef GOOGLE
    
    id<GAITracker> gaiTracker = [[GAI sharedInstance]defaultTracker];
    NSMutableDictionary * datesDictionary = [self datesForEventsDictionariesForTracker:gaiTracker];
    NSDate * currentDate = [NSDate date];
    
    @synchronized(gaiTracker)
    {
        if (startOrEndTimer)
        {
            [datesDictionary setObject:currentDate forKey:eventName];
        }
        else
        {
            NSDate * eventStartedDate = [datesDictionary objectForKey:eventName];
            if (eventStartedDate)
            {
                [datesDictionary removeObjectForKey:eventName];
                
                NSTimeInterval interval = [currentDate timeIntervalSinceDate:eventStartedDate];
                NSInteger intervalInMilliseconds = interval * 1000;
            
                NSMutableString * parametersString = [NSMutableString string];

                for (NSString * key in parameters.allKeys)
                {
                    [parametersString appendFormat:@"%@ : %@ %@",key, parameters[key], parametersString.length > 0 ? @"|" : @""];
                }

                NSDictionary * eventDictionary = [[GAIDictionaryBuilder createTimingWithCategory:@"Timed"
                                                                                        interval:@(intervalInMilliseconds)
                                                                                            name:eventName
                                                                                           label:@"fdf"]build];

                [[[GAI sharedInstance]defaultTracker] send:eventDictionary];
            }
        }
    }
    
#endif
    
    
#ifdef YANDEX
    
    [YMMYandexMetrica reportEvent:eventName parameters:parameters onFailure:nil];
    
#endif
}




@end
