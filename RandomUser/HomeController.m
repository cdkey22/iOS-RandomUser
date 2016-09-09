//
//  ViewController.m
//  RandomUser
//
//  Created by Cédric Clavier on 06/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeController.h"
#import "RandomUser.h"
#import "RandomUserCollection.h"
#import "RandomUserTableViewController.h"

@interface HomeController ()


@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIApplication* app = [UIApplication sharedApplication];
    self.users = [(AppDelegate*)[app delegate] getUsers];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUsersChange:) name:@"randomusers/collection/init" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onUsersChange:(NSNotification*) notification{
    self.loadingLabel.hidden = true;
    self.containerView.hidden = false;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"embedTable"]){
        RandomUserTableViewController* controller = [segue destinationViewController];
        controller.searchBar = self.searchBar;
    }
}

@end
