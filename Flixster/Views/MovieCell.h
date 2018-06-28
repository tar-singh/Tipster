//
//  MovieCell.h
//  Flixster
//
//  Created by Tarini Singh on 6/28/18.
//  Copyright © 2018 Tarini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *synopsisTitle;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;

@end
