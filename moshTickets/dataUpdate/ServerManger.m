//
//  ServerManger.m
//  moshTickets
//
//  Created by 魔时网 on 14-2-11.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "ServerManger.h"
#import "ServerRequest.h"
#import "Reachability.h"
#import "GlobalConfig.h"
#import "CJSONSerializer.h"
#import "HTTPClient+TIckets.h"
#import "MoshTicketDatabase.h"
#import "CheckTickets.h"

static CGFloat  RepeatUpdateTime = 5.0;
static CGFloat RepeatLoadTime = 30.0;

@implementation ServerManger


+ (ServerManger *) shareServerManger
{
    static ServerManger *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[ServerManger alloc] init];
    });
    return _instance;
}

- (id) init
{
    if (self = [super init]) {
        self.ticketsArray = [NSMutableArray array];
        self.tmpArray = [NSMutableArray array];
        self.isPosting = NO;
    }
    return self;
}

//提交检票信息
- (void) updateTicket:(Ticket *)ticket
{
    if (self.isPosting) {//正在进行网络交互 存入临时文件
        [self.tmpArray addObject:ticket];
    }
    else {
        [self.ticketsArray addObject:ticket];
    }
}

- (void) updateTickets:(NSArray *)array
{
    if (self.isPosting) {//正在进行网络交互 存入临时文件
        [self.tmpArray addObjectsFromArray:array];
    }
    else {
        [self.ticketsArray addObjectsFromArray:array];
    }
}


//开始工作
- (void) startNetNoti
{
    //网络检查
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    ability = [Reachability reachabilityWithHostname:SERVERHOST];
    [ability startNotifier];
    
    //5秒循环提交检票信息至服务器
   _postTimer =  [NSTimer scheduledTimerWithTimeInterval:RepeatUpdateTime target:self selector:@selector(dataPost) userInfo:nil repeats:YES];
}

- (void) startDownloadNewsTicket:(Activity *)act
{
    
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:act.eid]) {
        _act = act;
        if ([_loadTimer isValid]) {
            [_loadTimer invalidate];
        }
        //5秒循环从服务器请求最新票信息
        _loadTimer = [NSTimer scheduledTimerWithTimeInterval:RepeatLoadTime target:self selector:@selector(dataLoad) userInfo:Nil repeats:YES];
        
            MOSHLog(@"开始下载");
    }
}

- (void) endDownloadNewsTicket
{
    [_loadTimer invalidate];
    MOSHLog(@"结束下载");
}

//- (void) dataLoad
//{
//    [[HTTPClient shareHTTPClient] getAllTicketWitheid:_currentEid success:^(NSMutableArray *tickets){
//    
//            //成功之后开始搞(存库之类)
//            if (tickets.count > 0) {
//                
//                //异步加入数据库
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    
//                    [[MoshTicketDatabase sharedInstance] insertTickets:tickets];
//                    
//                    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_checkTicket object:nil];
//                });
//            }
//                                                    }
//                                                 fail:^{
//                                                    
//                                                 }];
//    
//}

- (void) dataLoad
{
    [[HTTPClient shareHTTPClient] ticketsInfoWithActivity:_act isall:NO backgroud:YES];
    
}


//循环调用提交信息至服务器
- (void) dataPost
{
    
    //检查是否正在提交，正在提交则返回
    if (self.isPosting) {
        return;
    }
    else {
        //将临时文件中的票信息转入票数组并制空
        if ([GlobalConfig isKindOfNSArrayClassAndCountGreaterThanZero:self.tmpArray]) {
            [self.ticketsArray addObjectsFromArray:self.tmpArray];
            [self.tmpArray removeAllObjects];
        }
    }
    
    //提交服务器
    if (self.isNetWorking && [GlobalConfig isKindOfNSArrayClassAndCountGreaterThanZero:self.ticketsArray]) {
        //将数据传给服务器
        self.isPosting = YES;
        Ticket *ticket = self.ticketsArray[0];
        
        [[HTTPClient shareHTTPClient] uploadTicketWitheid:ticket.eid
                                                      dic:[self jsonSerial]
                                                   sucess:^(NSString *str){
                                                   //判断是否成功
                                                       //success
                                                       NSLog(@"%@",str);
                                                       [self dataUpdateSuccess];
                                                    
                                                   } fail:^{
                                                       //fail
                                                       NSLog(@"------------postFail");
                                                       self.isPosting = NO;
                                                   
                                                   }];
    }
}

//将数据序列化
- (NSDictionary *) jsonSerial
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    NSError *error = nil;
    NSData *aa;
    for (Ticket *t in self.ticketsArray) {
   
        NSMutableArray *values = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *keys = [NSMutableArray arrayWithCapacity:0];
        
        [values addObject:t.t_id];
        [values addObject:t.use_date];
        [keys addObject:@"code"];
        [keys addObject:@"use_time"];
        NSDictionary *tmpDic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
        aa = [[CJSONSerializer serializer] serializeDictionary:tmpDic error:&error];
        [array addObject:aa];
    }
    
    NSData *dataArray = [[CJSONSerializer serializer] serializeArray:array error:&error];
    
    NSString *string = [[NSString alloc] initWithData:dataArray encoding:NSASCIIStringEncoding];
    
    string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
    string = [string stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
    
    return [NSDictionary dictionaryWithObject:string forKey:@"data"];

}

//成功提交
- (void) dataUpdateSuccess
{
    for (Ticket *ticket in self.ticketsArray) {
        [[MoshTicketDatabase sharedInstance] updateTicket:ticket isPost:ticketUpdte_yes];
    }
    [self.ticketsArray removeAllObjects];
    self.isPosting = NO;
    
}


#pragma  mark  - networking -
//网络变化通知
- (void) reachabilityChanged:(NSNotification *)noti
{
    Reachability *ability1 = noti.object;
    
    if ([ability1 isKindOfClass:[Reachability class]]) {
        if (ability1.isReachable) {
            //连接
            self.isNetWorking = YES;
//            [_postTimer fire];
        }
        else {
            //未连接
            self.isNetWorking = NO;
//            [_postTimer invalidaite];            
        }
    }
}

@end
