//
//  IVSessionManager.m
//  ImageViewer
//
//  Created by Rafael Ferreira on 1/7/16.
//  Copyright © 2016 Data Empire. All rights reserved.
//

#import "IVSessionManager.h"

/*! @brief Base URL for the requests. */
static NSString *const kBaseURL = @"https://api.500px.com";

@implementation IVSessionManager

- (instancetype)init {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    self = [super initWithBaseURL:[NSURL URLWithString:kBaseURL] sessionConfiguration:sessionConfiguration];
    
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        
        self.securityPolicy.validatesDomainName = NO;
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    
    return self;
}

+ (instancetype)sharedManager {
    static IVSessionManager *_sessionManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sessionManager = [self new];
    });
    
    return _sessionManager;
}
@end
