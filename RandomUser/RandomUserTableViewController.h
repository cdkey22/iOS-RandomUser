//
//  RUTableController.h
//  RandomUser
//
//  Created by Cédric Clavier on 09/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RandomUserCollection.h"

@interface RandomUserTableViewController : UITableViewController<UITableViewDataSource>

@property RandomUserCollection *users;
@property (strong, nonatomic) IBOutlet UITableView *table;

@end
