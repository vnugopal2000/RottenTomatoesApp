//
//  MovieDetailViewController.m
//  RottenTomatoesClient
//
//  Created by Venu Narayanabhatla on 6/16/14.
//  Copyright (c) 2014 Venu Narayanabhatla. All rights reserved.
//

#import <UIImageView+AFNetworking.h>

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()



@end

@implementation MovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
        self.moviePosterBackground.frame = self.view.frame;
        NSURL *imgUrl = [NSURL URLWithString:self.movieDetail[@"posters"][@"original"]];
        [self.moviePosterBackground setImageWithURL:imgUrl];
         [self initScrollView];


    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)initScrollView {
    [self.movieDescriptionTitleLabel setText:self.movieDetail[@"title"]];
    [self.movieDescriptionTitleLabel sizeToFit];
    [self.movieDescriptionLabel setText:self.movieDetail[@"synopsis"]];
    [self.movieDescriptionLabel sizeToFit];
    
   
    [self.movieDescriptionContainerView addSubview:self.movieDescriptionTitleLabel];
    [self.movieDescriptionContainerView addSubview:self.movieDescriptionLabel];
    
    // find the gap between the title label and the description label
    CGFloat gap = self.movieDescriptionLabel.frame.origin.y - (self.movieDescriptionTitleLabel.frame.origin.y + self.movieDescriptionTitleLabel.frame.size.height);
    
    // hack to get the right padding on the bottom of the container for iOS 7 vs iOS 6
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        gap += 20;
    }
    else {
        gap += 50;
    }
    
    // change starting y coordinate and size of the container
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    // start 60% down from the bottom of the navigation bar
    frame.origin.y = (self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height) * 0.6;
    CGSize fitSize = CGSizeMake(self.view.frame.size.width, self.movieDescriptionTitleLabel.frame.size.height + self.movieDescriptionLabel.frame.size.height + gap);
    frame.size = fitSize;
    self.movieDescriptionContainerView.frame = frame;
    
    // add container view to scroll view
    self.movieDescriptionScrollView.frame = self.view.frame;
    [self.movieDescriptionScrollView addSubview:self.movieDescriptionContainerView];
    
    // set content size, taking the starting y coordinate of the container into consideration
    self.movieDescriptionScrollView.contentSize = CGSizeMake(self.movieDescriptionContainerView.frame.size.width, self.movieDescriptionContainerView.frame.size.height + self.movieDescriptionContainerView.frame.origin.y + 20);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end