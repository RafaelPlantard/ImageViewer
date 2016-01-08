//
//  IVApiManager.h
//  ImageViewer
//
//  Created by Rafael Ferreira on 1/7/16.
//  Copyright © 2016 Data Empire. All rights reserved.
//

#import "IVSessionManager.h"

/*! @brief The set of endpoints to the 500px.com API methods. */
@interface IVApiManager : IVSessionManager

/*! @brief Do a GET request for the 500px API on \photos endpoint. */
- (NSURLSessionDataTask *) getPhotos:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
