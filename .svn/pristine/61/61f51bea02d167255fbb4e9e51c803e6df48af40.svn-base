//
//  MemberInfo.m
//  moshTickets
//
//  Created by 魔时网 on 14-2-20.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import "MemberInfo.h"
#import "GlobalConfig.h"
#import "TicketType.h"
#import "CJSONSerializer.h"
#import "AFNetworking.h"
#import "SBJson.h"

@implementation MemberInfo

+ (MemberInfo *) memberInfo:(NSDictionary *)dic
{
    MemberInfo *member = [[MemberInfo alloc] init];
    
    member.uid = [GlobalConfig convertToString:dic[@"uid"]];
    member.eid = [GlobalConfig convertToString:dic[@"eid"]];
    member.tid = [GlobalConfig convertToString:dic[@"tid"]];
    member.isentry = [GlobalConfig convertToString:dic[@"isentry"]];
    member.tTypeID = [GlobalConfig convertToString:dic[@"ticket_id"]];
    member.name = [GlobalConfig convertToString:dic[@"name"]];
    member.phoneNumber = [GlobalConfig convertToString:dic[@"tel"]];
    member.email = [GlobalConfig convertToString:dic[@"email"]];
    
    NSDictionary *descDic = [GlobalConfig convertToDictionary:dic[@"desc"]];
    member.desc = [[NSString alloc] initWithData:[[CJSONSerializer serializer] serializeDictionary:descDic error:nil] encoding:NSUTF8StringEncoding];
    
    return member;
}

- (void) memberDescConvertToInfo
{
    if ([GlobalConfig isKindOfNSStringClassAndLenthGreaterThanZero:self.desc]) {
        
         NSDictionary *dic = [self.desc JSONValue];//解json
        if (dic) {
            self.otherInfoArray = [NSMutableArray array];
            self.tickedTypeArray  = [NSMutableArray array];
            
           
            
            NSArray *entryArray = [GlobalConfig convertToArray:dic[@"entry"]];
            for (NSDictionary *entry in entryArray) {
                
                OtherInfo *other = [[OtherInfo alloc] init];
                other.key = [GlobalConfig convertToString:entry[@"colum"]];
                other.title = [GlobalConfig convertToString:entry[@"name"]];
                other.memberInfo = [GlobalConfig convertToString:dic[other.key]];
                [self.otherInfoArray addObject:other];
            }
            
            NSArray *tTypeArray = [GlobalConfig convertToArray:dic[@"ticketinfo"]];
            for (NSDictionary *type in tTypeArray) {
                TicketType *t = [TicketType  ticketType:type];
                [self.tickedTypeArray addObject:t];
            }
        }
    }
}


- (BOOL) memberIsContainInfo:(NSString *)info
{
    NSRange range1 = [self.name rangeOfString:info];
    NSRange range2 = [self.phoneNumber rangeOfString:info];
    NSRange range3 = [self.email rangeOfString:info];
    
    if ((range1.length > 0) || (range2.length > 0) || (range3.length > 0)) {
        return YES;
    }
    return NO;
}

- (BOOL) IsEqualMember:(MemberInfo *)info
{
    if ([info.name isEqualToString:self.name] && [info.phoneNumber isEqualToString:self.phoneNumber] && [info.email isEqualToString:self.email]) {
        return  YES;
    }
    return NO;
}

@end


@implementation OtherInfo


@end