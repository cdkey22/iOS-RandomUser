//
//  RandomUser.h
//  RandomUser
//
//  Created by Cédric Clavier on 06/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RandomUser : NSObject<NSURLConnectionDataDelegate>

@property NSString* firstName;
@property NSString* lastName;
@property NSString* desc;
@property NSString* email;
@property NSString* phoneNumber;
@property NSString* cellNumber;
@property NSString* imageUrl;
@property UIImage* avatar;

@property (readonly) NSString* fullName;

+ (RandomUser*) parseFromJSON:(NSDictionary*) rawContent;

@end
