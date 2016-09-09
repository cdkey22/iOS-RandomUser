//
//  RandomUserCollection.m
//  RandomUser
//
//  Created by Cédric Clavier on 07/09/2016.
//  Copyright © 2016 Cédric Clavier. All rights reserved.
//

#import "RandomUserCollection.h"

@implementation RandomUserCollection {
    NSArray *_users;
    NSMutableData *_responseData;
}
#pragma mark Static Methods
+(RandomUserCollection *) initAndFetch{
    RandomUserCollection *_return = [[RandomUserCollection alloc] init];
    [_return fetch];
    return _return;
}

#pragma mark Constructor
-(id)init{
    self = [super init];
    if(self){
        self->_users = [NSArray array];
    }
    return self;
}

#pragma mark Public methods
-(RandomUser *) getItemAt:(NSInteger)index filter:(NSString*)filter{
    if(index >=0){
        NSArray<RandomUser*> *workingArray;
        
        if(filter != nil){
            workingArray = [self getFilteredUsers:filter];
        }else{
            workingArray = self->_users;
        }
        
        if(index < workingArray.count ){
            return [workingArray objectAtIndex:index];
        }
    }
    return nil;
}

- (NSInteger) getCount:(NSString*)filter{
    if(filter != nil && filter.length> 0){
        return [self getFilteredUsers:filter].count;
    }else{
        return self->_users.count;
    }
}



#pragma mark Private methods

- (NSArray<RandomUser *>*) getFilteredUsers:(NSString*)searchPattern{
    if(searchPattern == nil || searchPattern.length == 0){
        return self->_users;
    } else {
        NSMutableArray<RandomUser*>* results = [[NSMutableArray alloc] init];
        for (RandomUser* user in self->_users) {
            if([[user.fullName lowercaseString] containsString:[searchPattern lowercaseString]]){
                [results addObject:user];
            }
        }
        return results;
    }
}

-(void) fetch{
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.randomuser.me/?results=20"]];
    if([[NSURLConnection alloc] initWithRequest:request delegate:self]){
        NSLog(@"Loading random user");
    }
}

#pragma mark NSURLConnection Delegate Methods
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self->_responseData = [[NSMutableData alloc] init];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection{
    NSError *error = nil;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    NSArray *results = [jsonDict objectForKey:@"results"];
    NSMutableArray<RandomUser*> *users = [[NSMutableArray alloc] init];
    for (int i=0; i<results.count; i++) {
        [users addObject:[RandomUser parseFromJSON:[results objectAtIndex:i]]];
    }
    self->_users = [users copy];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"randomusers/collection/init" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"randomusers/collection/change" object:self];
    
}


@end
