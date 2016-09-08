//
//  RandomUserCollection.h
//  RandomUser
//
//  Created by Cédric Clavier on 07/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RandomUser.h"

@interface RandomUserCollection : NSObject<NSURLSessionDataDelegate>

@property (readonly) NSInteger count;

+ (RandomUserCollection*) initAndFetch;
- (RandomUser*) getItemAt:(NSInteger)index;


@end
