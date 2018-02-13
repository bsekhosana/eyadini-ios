//
//  PLAPICLient.h
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "PLConstants.h"

typedef void (^successBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void (^failureBlock)(NSURLSessionDataTask *task, NSError *error);
typedef void (^doneBlock)(void);

@interface PLAPICLient : AFHTTPSessionManager
+ (PLAPICLient *)sharedClient;
  
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(successBlock)successHandler
                        failure:(failureBlock)failureHandler
                         done:(doneBlock)doneHandler;
  
- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                        parameters:(id)parameters
                           success:(successBlock)successHandler
                           failure:(failureBlock)failureHandler
                            done:(doneBlock)doneHandler;
  
- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      success:(successBlock)successHandler
                      failure:(failureBlock)failureHandler
                         done:(doneBlock)doneHandler;
  
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(successBlock)successHandler
                         failure:(failureBlock)failureHandler
                          done:(doneBlock)doneHandler;
  
@end
