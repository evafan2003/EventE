//
//  HTTPClient+TIckets.h
//  moshTickets
//
//  Created by 魔时网 on 14-4-2.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "HTTPClient.h"

@interface HTTPClient (TIckets)

/*
 全部票信息
 */

- (void) ticketsInfoWithActivity:(Activity *)act
                           isall:(BOOL)all
                       backgroud:(BOOL)back;
@end
