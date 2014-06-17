//
//  MovieCell.h
//  RottenTomatoesClient
//
//  Created by Venu Narayanabhatla on 6/11/14.
//  Copyright (c) 2014 Venu Narayanabhatla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end
