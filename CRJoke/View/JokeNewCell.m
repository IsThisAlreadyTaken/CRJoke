//
//  JokeNewCell.m
//  CRJoke
//
//  Created by chengran on 15/11/16.
//  Copyright © 2015年 chengran. All rights reserved.
//

#import "JokeNewCell.h"
#import "UIImageView+WebCache.h"
#import "ActionDef.h"
#import "JokeNewsModel.h"
#import "JokeUserModel.h"


@interface JokeNewCell()









@end


@implementation JokeNewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self initControl];
    
    
    
    return self;
}



#pragma mark -- --设置frame
- (void)setModelNew:(JokeNewCell *)modelNew
{
    _modelNew = modelNew;
    
    [self initContentAll];
    
}

#pragma mark -- private

//初始化
- (void) initControl
{
    self.titleView = [[UIView alloc] init];
    [self.contentView addSubview: self.titleView];
    
    self.iconImageView = [[UIImageView alloc] init];
    [self.titleView addSubview: self.iconImageView];
    
    
    self.userNameLabel = [[UILabel alloc] init];
    [self.titleView addSubview:self.userNameLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.titleView addSubview:self.timeLabel];
    
    
    self.contentTextView = [[UIView alloc] init];
    [self.contentView addSubview:self.contentTextView];
    
    self.contentTextLabe = [[UILabel alloc] init];
    self.contentTextLabe.numberOfLines = 0;
    [self.contentTextView addSubview:self.contentTextLabe];
    
    
    self.contentPicView  = [[UIView alloc] init];
    [self.contentView addSubview:self.contentPicView];
    self.contentImageView = [[UIImageView alloc] init];
    [self.contentPicView addSubview:self.contentImageView];
    [self.contentImageView setUserInteractionEnabled:YES];
    
    //加入事件
    [self.contentImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick:)]];
    
    
}

- (void) initContentAll
{
    //标题view
    self.titleView.frame = CGRectMake(0, 0, PhoneSize.width, 60);
    //self.titleView.backgroundColor = [UIColor redColor];
    
    //头像icon
    JokeUserModel *userModel = self.modelNew.user;
    NSString *suUrlStr =  [NSString stringWithFormat:@"/%@/%@/medium/%@",[userModel.iid substringToIndex:4],userModel.iid
     ,userModel.icon];
    NSURL *iconUrl = [NSURL URLWithString: [NSString stringWithFormat:CRBaseIconUrl,suUrlStr]];
    [self.iconImageView sd_setImageWithURL:iconUrl];
    self.iconImageView.frame = CGRectMake(CRMaigin, CRMaigin , 40, 40);
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width / 4;
    self.iconImageView.layer.masksToBounds = YES;

    
    
    //用户名称
    self.userNameLabel.text = userModel.login;
    self.userNameLabel.font = [UIFont systemFontOfSize:14];
    self.userNameLabel.textColor = [UIColor orangeColor];
    [self.userNameLabel sizeToFit];
    NSDictionary *fontDic = @{NSFontAttributeName: self.userNameLabel.font};
    CGSize fontSize = [userModel.login sizeWithAttributes:fontDic];
    self.userNameLabel.frame = CGRectMake( CGRectGetMaxX(self.iconImageView.frame)+CRMaigin, CRMaigin , fontSize.width, fontSize.height);
    
    //发布时间
    long long int dateTimeIn = (long long int)[self.modelNew.published_at intValue];
    NSDate *publishDate = [NSDate dateWithTimeIntervalSince1970:dateTimeIn];
    self.timeLabel.text = [self getTimeByDate:publishDate FormatStr:@"YYYY-MM-dd"];
    self.timeLabel.font = [UIFont systemFontOfSize:11];
    self.timeLabel.textColor = [UIColor grayColor];
    NSDictionary *fontTimeDic = @{NSFontAttributeName: self.timeLabel.font};
    CGSize fontTimeSize = [self.timeLabel.text sizeWithAttributes:fontTimeDic];
    self.timeLabel.frame = CGRectMake( self.userNameLabel.frame.origin.x, CGRectGetMaxY(self.userNameLabel.frame)+CRMaigin -5 , fontTimeSize.width, fontTimeSize.height);

    
    //内容的view
    //首先根据内容算出宽高
    UIFont *contentFont = [UIFont systemFontOfSize:13];
    NSDictionary *fontContentDic = @{NSFontAttributeName: contentFont};
    CGFloat maxContentWidth = PhoneSize.width - 2*CRMaigin;
    CGSize contentSize = [self.modelNew.content boundingRectWithSize:CGSizeMake(maxContentWidth, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:fontContentDic context:nil].size;
    
    self.contentTextView.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.frame), PhoneSize.width, contentSize.height + CRMaigin);
    self.contentTextLabe.font = contentFont;
    self.contentTextLabe.text = self.modelNew.content;
    self.contentTextLabe.textColor = [UIColor blackColor];
    self.contentTextLabe.frame = CGRectMake(CRMaigin, 0, contentSize.width, contentSize.height);
    
    
    
    //计算图片
    
    if ((self.modelNew.image == nil ) || (self.modelNew.image.length <=0))
    {
        self.contentPicView.bounds = CGRectMake(0, 0, 0, 0);
        self.contentImageView.bounds = CGRectMake(0, 0, 0, 0);
    }
    else
    {
        self.contentPicView.frame = CGRectMake(0, CGRectGetMaxY(self.contentTextView.frame), PhoneSize.width, PhoneSize.width -2*CRMaigin+CRMaigin);
//        self.contentPicView.backgroundColor = [UIColor redColor];
        self.contentImageView.frame = CGRectMake(CRMaigin, 0, PhoneSize.width -2*CRMaigin, PhoneSize.width -2*CRMaigin);
        
        NSString *picNeedStr = [NSString stringWithFormat:@"/%@/%@/medium/%@",[self.modelNew.iid substringToIndex:5],self.modelNew.iid,self.modelNew.image];
        NSString *picUrlStr = [NSString stringWithFormat:CRBasePicUrl,picNeedStr];
        NSURL *picUrl = [NSURL URLWithString:picUrlStr];
        [self.contentImageView sd_setImageWithURL:picUrl];
    }
    
    
                                        
    
    

    

}


//时间

-(NSString *)getTimeByDate:(NSDate *)date FormatStr:(NSString *)formatStr
{
    if (!date)
        return nil;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatStr];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [dateFormat setTimeZone:timeZone];
    return [dateFormat stringFromDate:date];
}


+ (CGFloat)cellHeightWithModelNew:(JokeNewsModel *)model
{
    
    CGFloat currentHeight ;
    
    UIFont *contentFont = [UIFont systemFontOfSize:13];
    NSDictionary *fontContentDic = @{NSFontAttributeName: contentFont};
    CGFloat maxContentWidth = PhoneSize.width - 2*CRMaigin;
    CGSize contentSize = [model.content boundingRectWithSize:CGSizeMake(maxContentWidth, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:fontContentDic context:nil].size;
    
    currentHeight = contentSize.height + 60;
    
    if ( model.image.length <=0 )
    {
        return currentHeight + CRMaigin;
    }
    else
    {
        return currentHeight + (PhoneSize.width -2*CRMaigin+CRMaigin+ CRMaigin);
    }
    
}


#pragma mark --图片点击

- (void) imageClick :(UITapGestureRecognizer *)recognizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageClickByIid:)])
    {
        [self.delegate imageClickByIid:self.iid];
    }
}

@end
