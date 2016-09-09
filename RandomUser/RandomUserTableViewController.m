//
//  RUTableController.m
//  RandomUser
//
//  Created by Cédric Clavier on 09/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import "RandomUserTableViewController.h"
#import "AppDelegate.h"

@implementation RandomUserTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIApplication* app = [UIApplication sharedApplication];
    self.users = [(AppDelegate*)[app delegate] getUsers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUsersChange:) name:@"randomusers/collection/change" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserAvatarChange:) name:@"randomuser/avatar/change" object:nil];
}

#pragma mark Event Listeners

- (void)onUsersChange:(NSNotification*) notification {
    [self.table reloadData];
}

- (void) onUserAvatarChange:(NSNotification*) notification {
    [self.table reloadData];
}

#pragma mark UITableViewDataSource overrides

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.users){
        return self.users.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RandomUserCell"forIndexPath:indexPath];
    if(self.users !=nil && indexPath.row < self.users.count){
        RandomUser *ru = [self.users getItemAt:indexPath.row];
        if(ru != nil){
            cell.textLabel.text = [[NSArray arrayWithObjects:ru.firstName,@" ",ru.lastName,nil] componentsJoinedByString:@""];
            cell.imageView.image = ru.avatar;
        }else{
            cell.textLabel.text = nil;
            cell.imageView.image = nil;
        }
    }
    return cell;
}

@end
