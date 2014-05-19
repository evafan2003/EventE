//
//  MemberInfo.h
//  moshTickets
//
//  Created by 魔时网 on 14-2-20.
//  Copyright (c) 2014年 mosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberInfo : NSObject

@property (nonatomic, strong) NSString *uid;//购票者uid
@property (nonatomic, strong) NSString *tid;//购票者tid
@property (nonatomic, strong) NSString *eid;//活动eid
@property (nonatomic, strong) NSString *tTypeID;//购票者票种id
@property (nonatomic, strong) NSString *isentry;//是否有报名表


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *desc;//json格式的详情

@property (nonatomic, strong) NSMutableArray *otherInfoArray;//报名表
@property (nonatomic, strong) NSMutableArray *tickedTypeArray;//票种

+ (MemberInfo *) memberInfo:(NSDictionary *)dic;

//将member的详情转化为报名表形式；
- (void) memberDescConvertToInfo;

/*
 通过从名称、手机、邮箱等信息查找是否属于这个人
 */
- (BOOL) memberIsContainInfo:(NSString *)info;

/*
 通过从名称、手机、邮箱等信息判断两个人是否相同
 */
- (BOOL) IsEqualMember:(MemberInfo *)info;
@end

@interface OtherInfo : NSObject

@property (nonatomic, strong) NSString *key;//取出info的key
@property (nonatomic, strong) NSString *title;//报名表行名称
@property (nonatomic, strong) NSString *memberInfo;//报名者行信息

@end



