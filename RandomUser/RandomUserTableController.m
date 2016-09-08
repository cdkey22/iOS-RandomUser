//
//  RandomUserTableController.m
//  RandomUser
//
//  Created by Cédric Clavier on 07/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import "RandomUserTableController.h"

@implementation RandomUserTableController

#pragma mark Static Methods

+ (RandomUserTableController*) initAndDelegate:(RandomUserCollection*)randomUserCollection table:(UITableView*)table {
    RandomUserTableController* _return = [[RandomUserTableController alloc] init];
    _return.users = randomUserCollection;
    _return.table = table;
    [_return manageDelegation];
    return _return;
}

#pragma mark Constructor

-(id)init{
    self = [super init];
    if(self != nil){
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUsersChange:) name:@"randomusers/collection/change" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserAvatarChange:) name:@"randomuser/avatar/change" object:nil];
    }
    return self;
}

#pragma mark Public methods

- (void)manageDelegation{
    if(self.table !=nil){
        self.table.dataSource = self;
    }
}

#pragma mark Static UITableViewDataSource overrides

- (void)onUsersChange:(NSNotification*) notification {
    [self.table reloadData];
}

- (void) onUserAvatarChange:(NSNotification*) notification {
    [self.table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.users){
        return self.users.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RandomUserCellView"forIndexPath:indexPath];
    if(self.users !=nil && indexPath.row < self.users.count){
        RandomUser *ru = [self.users getItemAt:indexPath.row];
        if(ru != nil){
            cell.textLabel.text = [[NSArray arrayWithObjects:ru.firstName,@" ",ru.lastName,nil] componentsJoinedByString:@""];
            cell.detailTextLabel.text = ru.desc;
            cell.imageView.image = ru.avatar;
        }else{
            cell.textLabel.text = nil;
            cell.detailTextLabel.text = nil;
            cell.imageView.image = nil;
        }
    }
    return cell;
}





@end
