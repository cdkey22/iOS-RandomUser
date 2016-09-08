//
//  ViewController.m
//  RandomUser
//
//  Created by Cédric Clavier on 06/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import "HomeController.h"
#import "RandomUser.h"
#import "RandomUserCollection.h"
#import "RandomUserTableController.h"

@interface HomeController ()


@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.randomUsers = [RandomUserCollection initAndFetch];
    self.tableController = [RandomUserTableController initAndDelegate:self.randomUsers table:self.randomUserTable];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUsersChange:) name:@"randomusers/collection/init" object:nil];
}

- (void)onUsersChange:(NSNotification*) notification{
    self.loadingLabel.hidden = true;
    self.randomUserTable.hidden = false;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
