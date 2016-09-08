//
//  RandomUser.m
//  RandomUser
//
//  Created by Cédric Clavier on 06/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import "RandomUser.h"

@implementation RandomUser{
    NSMutableData *avatarRawData;
}

+ (RandomUser *)parseFromJSON:(NSDictionary *)rawContent{
    RandomUser* user = [[RandomUser alloc] init];
   
    user.firstName = [[rawContent objectForKey:@"name"] objectForKey:@"first"];
    user.lastName = [[rawContent objectForKey:@"name"] objectForKey:@"last"];
    user.desc = [[rawContent objectForKey:@"login"] objectForKey:@"username"];
    user.email = [rawContent objectForKey:@"email"];
    user.phoneNumber = [rawContent objectForKey:@"phone"];
    user.cellNumber = [rawContent objectForKey:@"cell"];
    user.imageUrl = [[rawContent objectForKey:@"picture"] objectForKey:@"medium"];
    [user fetchAvatar];
    NSLog(@"RandomUser created : %@ ",user);
    
    return user;
}

- (void) fetchAvatar{
    NSURLRequest *avatarRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:_imageUrl]];
    if([[NSURLConnection alloc] initWithRequest:avatarRequest delegate:self]){
        NSLog(@"Requesting the avatar at url %@",_imageUrl);
    }
}

- (NSString *)description{
    return [NSString stringWithFormat: @"firstName:%@ lastName:%@ (login:%@ - email: %@ - phoneNumber: %@ - cellNumber:%@)", self.firstName, self.lastName,self.desc,self.email,self.phoneNumber,self. cellNumber];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self->avatarRawData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self->avatarRawData appendData:data];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Error while receiving data for avatar %@",self.imageUrl);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    self.avatar = [[UIImage alloc] initWithData:self->avatarRawData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"randomuser/avatar/change" object:self];
}

@end
