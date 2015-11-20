//
//  JokeNewsModel.h
//  CRJoke
//
//  Created by 然 程 on 15/11/14.
//  Copyright © 2015年 chengran. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JokeUserModel;
@class JokeVotesModel;

@interface JokeNewsModel : NSObject

@property(nonatomic , copy) NSString *format;

@property(nonatomic , copy) NSString *image;

@property(nonatomic , copy) NSString *published_at;

@property(nonatomic , copy) NSString *tag;

@property(nonatomic , strong) JokeUserModel *user;

@property(nonatomic , copy) NSString *image_size;

@property(nonatomic , copy) NSString *iid;

@property (nonatomic, strong) JokeVotesModel *votes;

@property(nonatomic , copy) NSString *created_at;

@property(nonatomic , copy) NSString *content;

@property(nonatomic , copy) NSString *state;

@property(nonatomic , copy) NSString *comments_count;

@property(nonatomic , copy) NSString *allow_comment;

@property(nonatomic , copy) NSString *share_count;

@property(nonatomic , copy) NSString *type;




@end
