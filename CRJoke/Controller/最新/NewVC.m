//
//  NewVC.m
//  CRJoke
//
//  Created by chengran on 15/11/13.
//  Copyright © 2015年 chengran. All rights reserved.
//

#import "NewVC.h"
#import "JokeNewsModel.h"
#import "ActionDef.h"
#import "CRHTTPSessionManager.h"
#import "MJExtension.h"
#import "JokeNewCell.h"
#import "MJRefresh.h"
#import "MWCommon.h"
#import <Photos/Photos.h>
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"
#import "JokeNewsPhotoModel.h"

@interface NewVC ()<UITableViewDataSource,UITableViewDelegate,JokeNewsModelDelegate, MWPhotoBrowserDelegate>

@property (nonatomic, strong) UITableView *tableViewNew;

@property (nonatomic, assign) int pagCount;

@property (nonatomic, strong) NSMutableArray *ContenNewArray;

@property (nonatomic, strong) NSMutableArray *photoAllM;

@end

@implementation NewVC

- (NSMutableArray *)ContenNewArray
{
    if (_ContenNewArray == nil)
    {
        _ContenNewArray = [NSMutableArray array];
    }
    return _ContenNewArray;
}


- (NSMutableArray *)photoAllM
{
    if (_photoAllM == nil)
    {
        _photoAllM = [NSMutableArray array];
    }
    return _photoAllM;
}

#pragma mark -- 视图
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pagCount =0;
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"最新";
    self.tableViewNew = [[UITableView alloc] init];
    self.tableViewNew.frame = self.view.bounds;
    self.tableViewNew.dataSource = self;
    self.tableViewNew.delegate = self;
    [self.view addSubview:self.tableViewNew];
    //self.tableViewNew.rowHeight = 1000;
    
    //下拉刷新
    self.tableViewNew.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getReadDataFromHead:YES];
    }];
            //马上进入刷新状态
    [self.tableViewNew.header beginRefreshing];
    
    //上拉刷新
    self.tableViewNew.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getReadDataFromHead:NO];
    }];

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark -- private


//获取图片信息
- (void)loadLargeImage:(NSString *) Iid;
{
    NSLog(@"加载大图片");
    
    
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    int iIndex = 0 , currentIndex = 0;
    for (JokeNewsPhotoModel *photoModel in self.photoAllM) {
        
        MWPhoto *photoShow = [MWPhoto photoWithURL:[NSURL URLWithString:photoModel.imageUrl]];
        photoShow.caption =photoModel.contentStr;

        [photos addObject:photoShow];
        if ([photoModel.indexId isEqualToString:Iid])
            currentIndex = iIndex;
        iIndex ++;
        
    }
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
    browser.delegate = self;
    browser.zoomPhotosToFill = YES;
    browser.displayActionButton = NO;
    [browser setCurrentPhotoIndex:currentIndex];
    browser.navigationItem.rightBarButtonItem.title =@"返回";
   
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nc animated:YES completion:nil];

    
}

//获取最新消息
- (void) getReadDataFromHead:(BOOL) isFromHead
{
    if (isFromHead)
        self.pagCount = 1;
    else
        self.pagCount +=1;
    
    NSString *urlStr = [NSString stringWithFormat:CRNewUrl,self.pagCount];
    [[CRHTTPSessionManager shareCRManager] GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"获取数据成功");
        NSDictionary *dictJson = responseObject;
        NSMutableArray *newTemparrM = [JokeNewsModel objectArrayWithKeyValuesArray:[dictJson objectForKey:@"items"]];
        if (isFromHead)
        {
            [self.ContenNewArray removeAllObjects];
            [self.ContenNewArray addObjectsFromArray:newTemparrM];
            [self.tableViewNew reloadData];
            
            //图片集新增
            [self.photoAllM removeAllObjects];
            int i = 0;
            for (JokeNewsModel *tempMedel in self.ContenNewArray)
            {
                //有图片
                if (!((tempMedel.image == nil ) || (tempMedel.image.length <=0)))
                {
                    NSString *picNeedStr = [NSString stringWithFormat:@"/%@/%@/medium/%@",[tempMedel.iid substringToIndex:5],tempMedel.iid,tempMedel.image];
                    NSString *picUrlStr = [NSString stringWithFormat:CRBasePicUrl,picNeedStr];
                    NSDictionary *dict = @{@"indexId": tempMedel.iid  , @"imageUrl":picUrlStr , @"contentStr" : tempMedel.content};
                    
                    [self.photoAllM addObject:[JokeNewsPhotoModel objectWithKeyValues:dict]];

                }
                i ++;
            }
            //图片新增结束
            [self.tableViewNew.header endRefreshing];
            
            

        }
        else
        {
            [self.ContenNewArray addObjectsFromArray:newTemparrM];
            [self.tableViewNew reloadData];
            
            //图片集新增
            int i = 0;
            for (JokeNewsModel *tempMedel in newTemparrM)
            {
                //有图片
                 if (!((tempMedel.image == nil ) || (tempMedel.image.length <=0)))
                {
                    NSString *picNeedStr = [NSString stringWithFormat:@"/%@/%@/medium/%@",[tempMedel.iid substringToIndex:5],tempMedel.iid,tempMedel.image];
                    NSString *picUrlStr = [NSString stringWithFormat:CRBasePicUrl,picNeedStr];
                    NSDictionary *dict = @{@"indexId":  tempMedel.iid , @"imageUrl":picUrlStr , @"contentStr" : tempMedel.content};
                    [self.photoAllM addObject:[JokeNewsPhotoModel objectWithKeyValues:dict]];
                }
                i ++;
            }
            //图片集新增结束
            
            [self.tableViewNew.footer endRefreshing];
            

        }
        
       
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"失败");
        if (isFromHead)
            [self.tableViewNew.header endRefreshing];
        else
            [self.tableViewNew.footer endRefreshing];
    }];
}



#pragma mark -- tableView delegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ((self.ContenNewArray == nil) || (self.ContenNewArray.count <=0))
    {
        return 0;
    }
    else
    {
        return self.ContenNewArray.count;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [JokeNewCell cellHeightWithModelNew:self.ContenNewArray[indexPath.row]];
}




- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"newCell";
    JokeNewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[JokeNewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    //图片加入点击事件
    
    cell.delegate = self;
    JokeNewsModel *modelTemp = self.ContenNewArray[indexPath.row];
    cell.modelNew = modelTemp;
    cell.iid = modelTemp.iid;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"11111点击");
}

#pragma mark -- JokeNewModelDelegate
- (void)imageClickByIid:(NSString *)Iid
{
    NSLog([NSString stringWithFormat:@"%@",Iid]);
    [self loadLargeImage:Iid];
}


#pragma  mark -- MWPhotoBrowserDelegate  相册代理

- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index
{
    return [NSString stringWithFormat:@"%d/%d",index+1,self.photoAllM.count];
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index
//{
//    
//}




@end
