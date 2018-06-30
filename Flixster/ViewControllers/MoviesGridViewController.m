//
//  MoviesGridViewController.m
//  Flixster
//
//  Created by Tarini Singh on 6/29/18.
//  Copyright © 2018 Tarini. All rights reserved.
//

#import "MoviesGridViewController.h"
#import "MoviesCollectionCell.h"
#import "UIImageView+AFNetworking.h"
#import "SegueDetailsViewController.h"

@interface MoviesGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *superheroCollectionView;
@property (nonatomic, strong) NSArray *movies;
@property (strong, nonatomic) NSArray *filteredMovies;
@property (weak, nonatomic) IBOutlet UISearchBar *superSearchBar;
@end

@implementation MoviesGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.superheroCollectionView.dataSource = self;
    self.superheroCollectionView.delegate = self;
    self.superSearchBar.delegate = self;

    [self fetchMovies];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.superheroCollectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    CGFloat itemsPerLine = 2;
    CGFloat itemWidth = (self.superheroCollectionView.frame.size.width - layout.minimumInteritemSpacing * (itemsPerLine - 1)) / itemsPerLine;
    CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)fetchMovies {
    // where "297762" is the Wonder Woman id
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/297762/similar?api_key=05f54c7a849a59aebe449f7ce850bddf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            // Get the array of movies
            // Store the movies in a property to use elsewhere
            self.movies = dataDictionary[@"results"];
            self.filteredMovies = self.movies;
            [self.superheroCollectionView reloadData];
        }
    }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// if search bar is being used, don't do segue -> just hide keyboard
// if search bar is not being used (keyboard is hid) -> do segue
#pragma mark - Navigation
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if (self.superSearchBar.isFirstResponder) {
        [self.superSearchBar resignFirstResponder];
        return false;
    } else {
        return true;
    }
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *tappedIndexPath = [self.superheroCollectionView indexPathForCell:tappedCell];
    NSDictionary *movie = self.filteredMovies[tappedIndexPath.item];
    
    SegueDetailsViewController *segueDetailsViewController = [segue destinationViewController];
    segueDetailsViewController.movie = movie;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MoviesCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MoviesCollectionCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.filteredMovies[indexPath.item];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    cell.posterView.image = nil;
    [cell.posterView setImageWithURL:posterURL];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.filteredMovies.count;
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
    
    [self.superheroCollectionView reloadData];
    
}

@end
