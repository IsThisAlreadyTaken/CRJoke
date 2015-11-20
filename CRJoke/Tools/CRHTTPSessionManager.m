//
//  CRHTTPSessionManager.m
//  CRJoke
//
//  Created by 然 程 on 15/11/14.
//  Copyright © 2015年 chengran. All rights reserved.
//

#import "CRHTTPSessionManager.h"

@implementation CRHTTPSessionManager

+ (instancetype)shareCRManager
{
    static CRHTTPSessionManager *instance;
    static dispatch_once_t onceToken;
    
  dispatch_once(&onceToken, ^{
     //单例
      NSURL *url = [NSURL URLWithString:@""];
      
      NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
      instance = [[self alloc]initWithBaseURL:url sessionConfiguration:config];
      instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
 
  });
    
    return instance;
}

@end
