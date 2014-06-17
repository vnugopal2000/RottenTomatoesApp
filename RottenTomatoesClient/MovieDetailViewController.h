//
//  MovieDetailViewController.h
//  RottenTomatoesClient
//
//  Created by Venu Narayanabhatla on 6/16/14.
//  Copyright (c) 2014 Venu Narayanabhatla. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *moviePosterBackground;
@property (weak, nonatomic) IBOutlet UIScrollView *movieDescriptionScrollView;
@property (weak, nonatomic) IBOutlet UIView *movieDescriptionContainerView;
@property (weak, nonatomic) IBOutlet UILabel *movieDescriptionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieDescriptionLabel;

@property (nonatomic, strong)NSDictionary *movieDetail;
@end
