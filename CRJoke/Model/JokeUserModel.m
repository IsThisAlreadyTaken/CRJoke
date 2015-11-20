//
//  JockUserModel.m
//  CRJoke
//
//  Created by 然 程 on 15/11/14.
//  Copyright © 2015年 chengran. All rights reserved.
//

#import "JokeUserModel.h"
#import "NSObject+MJKeyValue.h"


@implementation JokeUserModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    NSDictionary *dict = @{@"iid": @"id"};
    return dict;
}

@end
