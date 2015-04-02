//
//  ViewController.h
//  BookReader
//
//  Created by Artem Kiselev on 10/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCSAnalytics.h"

#ifdef GOOGLE

@interface TCSRequestViewController : GAITrackedViewController <UITextFieldDelegate>

#else
@interface TCSRequestViewController : UIViewController <UITextFieldDelegate>
#endif

@end

