//
//  NSString+SizeWithFont.m
//  TCSMBiOS
//
//  Created by a.v.kiselev on 25/11/14.
//  Copyright (c) 2014 “Tinkoff Credit Systems” Bank (closed joint-stock company). All rights reserved.
//

#import "NSString+SizeWithFont.h"

@implementation NSString (SizeWithFont)

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)constraintSize
{
	NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:self attributes:
										  @{
											NSFontAttributeName: font
											}];

	CGRect rect = [attributedText boundingRectWithSize:constraintSize
											   options:NSStringDrawingUsesLineFragmentOrigin
											   context:nil];
	CGSize size = rect.size;

	return size;
}

- (CGSize)sizeForLabelWithFont:(UIFont *)font constrainedToSize:(CGSize)constraintSize
{
	CGSize size = [self sizeWithFont:font constrainedToSize:constraintSize];

	size.width = (CGFloat)ceil(size.width);
	size.height = (CGFloat)ceil(size.height);

	return size;
}

@end
