//
//  ViewController.h
//  RandomUser
//
//  Created by Cédric Clavier on 06/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RandomUserCollection.h"

@interface HomeController : UIViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property RandomUserCollection *users;

@end