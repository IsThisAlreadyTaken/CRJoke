//
//  CRHTTPSessionManager.h
//  CRJoke
//
//  Created by 然 程 on 15/11/14.
//  Copyright © 2015年 chengran. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface CRHTTPSessionManager : AFHTTPSessionManager

+(instancetype) shareCRManager;

@end
