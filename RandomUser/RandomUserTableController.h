//
//  RandomUserTableController.h
//  RandomUser
//
//  Created by Cédric Clavier on 07/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RandomUserCollection.h"

@interface RandomUserTableController : NSObject<UITableViewDataSource>

+ (RandomUserTableController*) initAndDelegate:(RandomUserCollection*)randomUserCollection table:(UITableView*)table;
- (void) manageDelegation;

@property RandomUserCollection *users;
@property UITableView *table;



@end
