//
//  ActionDef.h
//  CRJoke
//
//  Created by 然 程 on 15/11/14.
//  Copyright © 2015年 chengran. All rights reserved.
//

#ifndef ActionDef_h
#define ActionDef_h


/*
 
  "http://m2.qiushibaike.com/article/list/suggest?count=20&page=\(page)"
 }
 "http://m2.qiushibaike.com/article/list/latest?count=20&page=\(page)"
 }
 "http://m2.qiushibaike.com/article/list/imgrank?count=20&page=\(page)"
 }
  http://m2.qiushibaike.com/article/list/day?count=30&page=1
 */

#define  CRMaigin 10.0

#define  CRNewUrl @"http://m2.qiushibaike.com/article/list/day?count=20&page=%d"

#define  CRHotUrl @"http://m2.qiushibaike.com/article/list/latest?count=20&page=%d"

#define  CRTrueUrl @"http://m2.qiushibaike.com/article/list/imgrank?count=20&page=%d"

#define  CRBaseIconUrl @"http://pic.qiushibaike.com/system/avtnew%@"

#define  CRBasePicUrl @"http://pic.qiushibaike.com/system/pictures%@"

#define   PhoneSize [UIScreen mainScreen].bounds.size

#endif /* ActionDef_h */
