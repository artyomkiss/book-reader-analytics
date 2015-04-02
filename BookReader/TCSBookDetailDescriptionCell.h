//
//  TCSBookDetailDescriptionCell.h
//  BookReader
//
//  Created by Artem Kiselev on 15/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCSBookDetailDescriptionCell : UITableViewCell

@property (nonatomic, strong) NSString * stringForDescription;

- (CGFloat)heightForTableWidth:(CGFloat)tableViewWidth;

@end
