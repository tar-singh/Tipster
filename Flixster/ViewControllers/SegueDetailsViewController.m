//
//  SegueDetailsViewController.m
//  Flixster
//
//  Created by Tarini Singh on 6/28/18.
//  Copyright © 2018 Tarini. All rights reserved.
//

#import "SegueDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface SegueDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *details_backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *details_posterView;
@property (weak, nonatomic) IBOutlet UILabel *details_titleView;
@property (weak, nonatomic) IBOutlet UILabel *details_synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *dertails_dateLabel;

@end

@implementation SegueDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    self.details_backdropView.image = nil;
    [self.details_backdropView setImageWithURL:backdropURL];
    
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    self.details_posterView.image = nil;
    [self.details_posterView setImageWithURL:posterURL];
    
    self.details_titleView.text = self.movie[@"title"];
    self.details_synopsisLabel.text = self.movie[@"overview"];
    self.dertails_dateLabel.text = self.movie[@"release_date"];
    
    [self.details_titleView sizeToFit];
    [self.details_synopsisLabel sizeToFit];
    [self.dertails_dateLabel sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
