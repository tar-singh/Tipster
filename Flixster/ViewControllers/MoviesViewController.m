//
//  MoviesViewController.m
//  Flixster
//
//  Created by Tarini Singh on 6/27/18.
//  Copyright © 2018 Tarini. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "SegueDetailsViewController.h"

@interface MoviesViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *pageLoadView;
@property (nonatomic, strong) NSArray *movies;
@property (strong, nonatomic) NSArray *filteredMovies;
@property (weak, nonatomic) IBOutlet UISearchBar *movieSearchBar;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.movieSearchBar.delegate = self;
    
    // Start the activity indicator
    [self.pageLoadView startAnimating];
    
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
}

- (void)addAlertController {
    // make alert controller
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Cannot get movies" message:@"Check your network connection and try again." preferredStyle:(UIAlertControllerStyleAlert)];
    
    // add try again button
    UIAlertAction *tryAction = [UIAlertAction actionWithTitle:@"Try again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // handle try again response here. doing nothing will dismiss view.
        [self fetchMovies];
    }];
    
    // add try again action to alertController
    [alert addAction:tryAction];
    
    // shows the alert controller
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
};

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            
            // give alert saying that network connection is not working
            [self addAlertController];
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@", dataDictionary);
            
            // Get the array of movies
            // Store the movies in a property to use elsewhere
            self.movies = dataDictionary[@"results"];
            self.filteredMovies = self.movies;
            
            
            // Reload your table view data
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
        
        // Stop the activity indicator
        // Hides automatically if "Hides When Stopped" is enabled
        [self.pageLoadView stopAnimating];
    }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredMovies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier: @"MovieCell"];
    NSDictionary *movie = self.filteredMovies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisTitle.text = movie[@"overview"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    cell.posterImageView.image = nil;
    [cell.posterImageView setImageWithURL:posterURL];
    
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains[cd] %@", searchText];
        self.filteredMovies = [self.movies filteredArrayUsingPredicate:predicate];
        
        NSLog(@"%@", self.filteredMovies);
    }
    else {
        self.filteredMovies = self.movies;
    }
    
    [self.tableView reloadData];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *tappedCell = sender;
    NSIndexPath *tappedIndexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.filteredMovies[tappedIndexPath.row];
    
    SegueDetailsViewController *segueDetailsViewController = [segue destinationViewController];
    segueDetailsViewController.movie = movie;
}

@end
