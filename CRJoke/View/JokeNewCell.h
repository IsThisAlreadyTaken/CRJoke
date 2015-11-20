//
//  JokeNewCell.h
//  CRJoke
//
//  Created by chengran on 15/11/16.
//  Copyright © 2015年 chengran. All rights reserved.
//

#import <UIKit/UIKit.h>


@class JokeNewsModel;

@protocol JokeNewsModelDelegate <NSObject>

- (void) imageClickByIid:(NSString *)Iid;

@end


@interface JokeNewCell : UITableViewCell

@property (nonatomic, strong) JokeNewsModel *modelNew;

+ (CGFloat) cellHeightWithModelNew:(JokeNewsModel *)model;

//控件

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;



@property (nonatomic, strong) UIView *contentTextView;
@property (nonatomic, strong) UILabel *contentTextLabe;



@property (nonatomic, strong) UIView *contentPicView;
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, copy) NSString *iid;


@property (nonatomic, assign) id <JokeNewsModelDelegate> delegate;

@end
