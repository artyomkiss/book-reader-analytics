//
//  StringConstantsMarcos.h
//  MessyMessage
//
//  Created by Artem Kiselev on 05.07.14.
//  Copyright (c) 2014 Artem Kiselev. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifdef SYNTHESIZE_CONSTANTS
#define STR_CONST(name, value) NSString* const name = @value
#else
#define STR_CONST(name, value) extern NSString* const name
#endif
