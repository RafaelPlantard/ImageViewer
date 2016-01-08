//
//  IVApiManager.m
//  ImageViewer
//
//  Created by Rafael Ferreira on 1/7/16.
//  Copyright © 2016 Data Empire. All rights reserved.
//

#import "IVApiManager.h"

/*! @brief The consumer key for access the API requests and responses. */
static NSString *const kConsumerKey = @"EuXNUey1J4QPHtfDJ0nJ68HDNFTFlxqiOjZUQjkg";

/*! @brief The endpoint to get photos.*/
static NSString *const kPhotosEndPoint = @"/v1/photos";

@implementation IVApiManager

- (NSURLSessionDataTask *) getPhotos:(void (^)(id json))success failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = @{
                                 @"feature": @"editors",
                                 @"page": @1,
                                 @"image_size": @4,
                                 @"consumer_key": kConsumerKey
                                 };
    
    return [self GET:kPhotosEndPoint parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

@end
