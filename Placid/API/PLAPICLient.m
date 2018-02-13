//
//  PLAPICLient.m
//  Placid
//
//  Created by Bruno Sekhosana on 2018/02/13.
//  Copyright © 2018 StrapBlaque. All rights reserved.
//

#import "PLAPICLient.h"

@implementation PLAPICLient

+ (PLAPICLient *)sharedClient {
  static PLAPICLient * _sharedPLClient = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedPLClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:[PLConstants PLApiKey]]];
  });
  
  return _sharedPLClient;
}
  
- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
      //self.responseSerializer = [AFJSONResponseSerializer serializer];
      self.responseSerializer = [AFHTTPResponseSerializer serializer]; // we want to handle deserialisation ourselves
      self.requestSerializer = [AFJSONRequestSerializer serializer];
      [self.requestSerializer setTimeoutInterval:20];
      
      // Set headers
//      NSDictionary * headers = [self getHeaders];
//      
//      for(id key in headers) {
//        id value = [headers objectForKey:key];
//        [self.requestSerializer setValue:value forHTTPHeaderField:key];
//      }
    }
    
    return self;
}
  
#pragma mark overrides
  
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(successBlock)successHandler
                      failure:(failureBlock)failureHandler
                         done:(doneBlock)doneHandler {
  
  
  failureBlock fail = [self getFailureHandler:failureHandler done:doneHandler];
  successBlock success = [self getSuccessHandler:successHandler done:doneHandler];
  
  return [super GET:URLString parameters:nil progress:nil success:success failure:fail];
}
  
- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(id)parameters
                         success:(successBlock)successHandler
                         failure:(failureBlock)failureHandler
                            done:(doneBlock)doneHandler {
  
  
  failureBlock fail = [self getFailureHandler:failureHandler done:doneHandler];
  successBlock success = [self getSuccessHandler:successHandler done:doneHandler];
  return [super DELETE:URLString parameters:parameters success:success failure:fail];
}
  
- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(id)parameters
                      success:(successBlock)successHandler
                      failure:(failureBlock)failureHandler
                         done:(doneBlock)doneHandler {
  
  
  failureBlock fail = [self getFailureHandler:failureHandler done:doneHandler];
  successBlock success = [self getSuccessHandler:successHandler done:doneHandler];
  return [super PUT:URLString parameters:parameters success:success failure:fail];
}
  
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(successBlock)successHandler
                       failure:(failureBlock)failureHandler
                          done:(doneBlock)doneHandler {
  
  
  failureBlock fail = [self getFailureHandler:failureHandler done:doneHandler];
  successBlock success = [self getSuccessHandler:successHandler done:doneHandler];
  return [super POST:URLString parameters:parameters success:success failure:fail];
}
  
- (failureBlock) getFailureHandler:(failureBlock)failureHandler done:(doneBlock) doneHandler{
  return ^(NSURLSessionDataTask *task, NSError *error){
    
    if (error.code == NSURLErrorCancelled){
      NSLog(@"HTTP Request Cancelled");
      if (doneHandler){
        doneHandler();
      }
      return;
    }
    
    if (failureHandler){
      failureHandler(task, error);
    }
    
    if (doneHandler){
      doneHandler();
    }
  };
}

- (successBlock) getSuccessHandler:(successBlock)successHandler done:(doneBlock) doneHandler{
  return ^(NSURLSessionDataTask *task, id responseObject){
    
    if (successHandler){
      successHandler(task, responseObject);
    }
    
    if (doneHandler){
      doneHandler();
    }
  };
}
  
@end
