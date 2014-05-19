//
//  HTTPClient+Members.h
//  moshTickets
//
//  Created by 魔时网 on 14-3-26.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "HTTPClient.h"

@interface HTTPClient (Members)

/*
 购票者信息
 */

- (void) memberInfoWithEid:(NSString *)eid
              ticketTypeID:(NSString *)tid;


/*
 单个购票者信息
 */
- (void) singleMemberInfoWithEid:(NSString *)eid
                             tid:(NSString *)tid
                            uuid:(NSString *)uid
                         isentry:(NSString *)isentry
                         success:(void (^)(MemberInfo *info))success
                            fail:(void (^)(void))fail;



@end
