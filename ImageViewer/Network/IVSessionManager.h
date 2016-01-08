//
//  IVSessionManager.h
//  ImageViewer
//
//  Created by Rafael Ferreira on 1/7/16.
//  Copyright © 2016 Data Empire. All rights reserved.
//

#import "AFHTTPSessionManager.h"

/*! @brief A session manager generated as a singleton for the app. */
@interface IVSessionManager : AFHTTPSessionManager

/*! @brief Generates a singleton instance of this manager. */
+ (instancetype)sharedManager;

@end
