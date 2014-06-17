//
//  BOMovieViewController.m
//  RottenTomatoesClient
//
//  Created by Venu Narayanabhatla on 6/16/14.
//  Copyright (c) 2014 Venu Narayanabhatla. All rights reserved.
//

#import "BOMovieViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MBProgressHUD.h"
#import "MovieDetailViewController.h"
#import "iToast.h"

@interface BOMovieViewController ()
@property (weak, nonatomic) IBOutlet UITableView *BOTableView;


@property (nonatomic, strong) NSArray *BoxOfficemovies;
@property (nonatomic, strong)NSDictionary *BoxOfficemovie;
@property (nonatomic, retain) MBProgressHUD *hud;
@property (nonatomic, retain) UIRefreshControl *refreshControl;
- (void)loadTopBoxOfficeList;


@end

@implementation BOMovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Box Office Movies"];
    [self loadTopBoxOfficeList ];
    
    // pull down to refresh feature
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(loadTopDVDList) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = _refreshControl;

    
}

- (void)loadTopBoxOfficeList {
    
    //Progress bar while loading
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_hud];
    _hud.labelText = @"Top Box Office Movies Loading";
    [_hud show:YES];
    
    
    
    self.BOTableView.delegate = self;
    self.BOTableView.dataSource = self;
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=tgpaezu83rd2kxqqa53ymn3r";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if ([data length] >0 && error == nil)
        {
            
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", object);
            self.BoxOfficemovies = object[@"movies"];
            
            [self.BOTableView reloadData];
            [_hud show:NO];
            [_hud removeFromSuperview];
            
        }
        else if ([data length] == 0 && error == nil)
        {
            NSLog(@"Nothing was downloaded.");
            NSLog(@"Error = %@", error);
            [_hud removeFromSuperview];
            [self.refreshControl endRefreshing];
            [[iToast makeText:NSLocalizedString(@"Network Connection Error.", @"")] show];
            
        }
        else if (error != nil){
            NSLog(@"Error = %@", error);
            [_hud removeFromSuperview];
            [self.refreshControl endRefreshing];
            [[iToast makeText:NSLocalizedString(@"Network Connection Error.", @"")] show];
            
        }
        
    }];
    
    

    
    [self.BOTableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil]
              forCellReuseIdentifier:@"MovieCell"];
    self.BOTableView.rowHeight=120;
    
}


-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.BoxOfficemovies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    _BoxOfficemovie = self.BoxOfficemovies[indexPath.row];
    cell.titleLabel.text = _BoxOfficemovie[@"title"];
    cell.synopsisLabel.text = _BoxOfficemovie[@"synopsis"];
    
    NSString *imageUrl = _BoxOfficemovie[@"posters"][@"detailed"];
    NSURL *url = [NSURL URLWithString:imageUrl];
    [cell.thumbnailView setImageWithURL:url];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _BoxOfficemovie = self.BoxOfficemovies[indexPath.row];
    MovieDetailViewController *myViewController = [[MovieDetailViewController alloc] init];
    myViewController.movieDetail = _BoxOfficemovie;
    [self.navigationController pushViewController:myViewController animated:true];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
