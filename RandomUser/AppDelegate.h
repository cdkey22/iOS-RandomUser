//
//  AppDelegate.h
//  RandomUser
//
//  Created by Cédric Clavier on 06/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RandomUserCollection.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    RandomUserCollection* _users;
}

@property (strong, nonatomic) UIWindow *window;
- (RandomUserCollection*) getUsers;


@end

