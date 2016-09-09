//
//  RUTableController.m
//  RandomUser
//
//  Created by Cédric Clavier on 09/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import "RandomUserTableViewController.h"
#import "AppDelegate.h"
#import "RandomUserCell.h"

@implementation RandomUserTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIApplication* app = [UIApplication sharedApplication];
    self.users = [(AppDelegate*)[app delegate] getUsers];
    
    self.searchBar.delegate = self;
    
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
        return [self.users getCount:self.searchBar.text];
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RandomUserCell *cell = (RandomUserCell*)[self.tableView dequeueReusableCellWithIdentifier:@"RandomUserCell" forIndexPath:indexPath];
    if(self.users !=nil){
        if( indexPath.row < [self.users getCount:self.searchBar.text]){
            RandomUser *ru = [self.users getItemAt:indexPath.row filter:self.searchBar.text];
            
            cell.avatarImage.layer.cornerRadius = cell.avatarImage.frame.size.width/2;
            cell.avatarImage.clipsToBounds = YES;
            cell.avatarImage.layer.borderWidth = 0.3f;
            cell.avatarImage.layer.borderColor = [UIColor grayColor].CGColor;
            
            if(ru != nil){
                cell.nameLabel.text = [ru.fullName capitalizedString];
                cell.emailLabel.text = ru.email;
                cell.avatarImage.image = ru.avatar;
            }else{
                cell.nameLabel.text = nil;
                cell.emailLabel.text = nil;
                cell.avatarImage.image = nil;
            }
        }
    }
    return cell;
}



//Tells the delegate when the user begins editing the search text.
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.table reloadData];
}

//Tells the delegate that the user finished editing the search text.
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{

}

@end
