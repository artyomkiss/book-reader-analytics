//
//  TCSBooksListCell.h
//  BookReader
//
//  Created by Artem Kiselev on 11/03/15.
//  Copyright (c) 2015 Artyom Kiselev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCSBooksListCell : UITableViewCell

@property (nonatomic, strong) NSString * imageThumbnailURLString;
@property (nonatomic, strong) NSString * bookTitleString;
@property (nonatomic, strong) NSString * authorsString;

@end
