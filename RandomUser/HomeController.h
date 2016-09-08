//
//  ViewController.h
//  RandomUser
//
//  Created by Cédric Clavier on 06/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RandomUserCollection.h"
#import "RandomUserTableController.h"

@interface HomeController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *randomUserTable;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;

@property RandomUserCollection *randomUsers;

@property RandomUserTableController *tableController;

@end

