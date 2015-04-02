//
//  TCSBookDetailThumbnailCell.h
//  BookReader
//
//  Created by Artem Kiselev on 15/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCSBookDetailThumbnailCell : UITableViewCell

@property (nonatomic, strong) NSString * stringForimageThumbnailURL;
@property (nonatomic, strong) NSString * stringForSubtitle;
@property (nonatomic, strong) NSString * stringForAuthors;
@property (nonatomic, strong) NSString * stringForPublisher;
@property (nonatomic, strong) NSString * stringForDate;

@end
