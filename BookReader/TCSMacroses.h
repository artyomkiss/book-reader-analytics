//
//  TCSMacroses.h
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

@import UIKit;

#ifndef BookReader_TCSMacroses_h
#define BookReader_TCSMacroses_h

#define SINGLETON_GCD(classname)\
+ (instancetype)sharedInstance\
{\
static dispatch_once_t pred = 0;\
__strong static id _sharedObject##classname = nil;\
dispatch_once(&pred,\
^{\
_sharedObject##classname = [[self alloc] init];\
});\
return _sharedObject##classname;\
}\

#pragma mark -
#pragma mark Loging & Assert

#define Alert( s, ... ) 	[[[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:(s), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];\


#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"%@%s:(%d)> %@", [[self class] description], __FUNCTION__ , __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )

#define ALog( s, ... ) 	[[[UIAlertView alloc]initWithTitle:@"Error!" message:[NSString stringWithFormat:(s), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];\
DLog(@"%@",[NSString stringWithFormat:(s), ##__VA_ARGS__]);

#define DAssert(A, B, ...) NSAssert(A, B, ##__VA_ARGS__);

#else

#define ALog( s, ... )
#define DLog( s, ... )
#define DAssert(...)

#endif



#endif
