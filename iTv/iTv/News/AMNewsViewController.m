//
//  AMNewsViewController.m
//  Anurse
//
//  Created by Amen on 6/18/15.
//  Copyright (c) 2015 Amen. All rights reserved.
//

#import "AMNewsViewController.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "AMNewsTableViewCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "AMNewsDetailedViewController.h"

@interface AMNewsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak)IBOutlet UITableView *table;
@property (nonatomic, retain) NSMutableArray *result_list;
@property(nonatomic) NSInteger pageNo;
@end

@implementation AMNewsViewController
@synthesize result_list = _result_list;
@synthesize table = _table;
@synthesize pageNo = _pageNo;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻";
    

 
    [_table addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(queryNewsList)];
    
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [_table.header beginRefreshing];
    _result_list = [[NSMutableArray alloc] init];
    
     _pageNo = 1;
  
}

- (void)queryNewsList{
    
   
    
//    NSString *address = @"http://apis.baidu.com/showapi_open_bus/channel_news/search_news";
//    NSString *channelId = @"5572a109b3cdc86cf39001db";
//    NSString *channelName = @"国内最新";
//    NSString *title = @"财经";
//    NSString *needContent = @"1";
//    NSString *needHtml = @"1";
//    
//    NSString *strUrl = [[NSString alloc] initWithFormat:@"%@?channelId=%@&channelName=%@&title=%@&page=%ld&needContent=%@&needHtml=%@",address,channelId,channelName,title,(long)_pageNo,needContent,needHtml];
    
    NSString *address = @"http://apis.baidu.com/txapi/mvtp/meinv?num=100";
    NSString *strUrl = [[NSString alloc] initWithFormat:@"%@",address];
    

    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 15;
    
    [request addValue:@"c17452457610190b72c29db0c72020ca" forHTTPHeaderField:@"apikey"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        NSLog(@"Received %lld of %lld bytes", totalBytesRead, totalBytesExpectedToRead);
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: Status Code %ld", (long)operation.response.statusCode);
        if (operation.response.statusCode == 200) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            if (jsonDict) {
                if (_pageNo == 1) {
                    [_result_list removeAllObjects];
                }
                
                self.table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
                
                NSArray *jj = [jsonDict objectForKey:@"newslist"];
                [_result_list addObjectsFromArray:jj];
                [_table reloadData];
                [_table.footer endRefreshing];
                [_table.header endRefreshing];
                
                
                [_table addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(queryNewsListMore)];
            }
        }else{
            //网络错误
            self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
             [SVProgressHUD showErrorWithStatus:@"网络错误,请稍后再试"];
            [_table.footer endRefreshing];
            [_table.header endRefreshing];
            
            
            [self showOkayCancelAlert:@"网络错误" message:@"可以下拉刷新哦"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error.localizedDescription);
        self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table.footer endRefreshing];
        [_table.header endRefreshing];

        [self showOkayCancelAlert:@"网络错误" message:error.localizedDescription];
        
      
    }];
    
    // Connection
    
    [operation start];

    
}

-(void)queryNewsListMore
{
    
    _pageNo = _pageNo + 1 ;
    [self queryNewsList];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITABLeView
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 260.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _result_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AMNewsCell";
    
    AMNewsTableViewCell *cell = (AMNewsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"AMNewsTableViewCell" owner:self options:nil];
        cell = (AMNewsTableViewCell *)[nibArray objectAtIndex:0];
        
    }
    
    
   
        cell.titleLabel.text = [[_result_list objectAtIndex:indexPath.row] objectForKey:@"title"] ;
        
        cell.artistLabel.text = [[NSString alloc] initWithFormat:@"%@ @%@",[[_result_list objectAtIndex:indexPath.row] objectForKey:@"ctime"],[[_result_list objectAtIndex:indexPath.row] objectForKey:@"description"]];
        
        [cell.newsImage sd_setImageWithURL:[NSURL URLWithString:[_result_list[indexPath.row] objectForKey:@"picUrl"]] placeholderImage:[UIImage imageNamed:@"NEWS_IMAGES_DEFAUlT"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];

    

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    AMNewsDetailedViewController *AMdetailView = [[AMNewsDetailedViewController alloc] init];
    AMdetailView.detailedDict = [_result_list objectAtIndex:indexPath.row] ;
    AMdetailView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:AMdetailView animated:YES];
    
}

- (void)stopReTable
{
    [_table reloadData];
    [_table.footer endRefreshing];
    [_table.header endRefreshing];
    
}


- (void)showOkayCancelAlert:(NSString *)alertTitle message:(NSString *)alertMessage {
    
    NSString *title = alertTitle;
    NSString *message = alertMessage;
    NSString *cancelButtonTitle = NSLocalizedString(@"点击重试", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"我知道了", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
        [self queryNewsList];
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
    }];
  
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
