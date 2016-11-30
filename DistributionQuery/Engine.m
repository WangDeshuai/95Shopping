//
//  Engine.m
//  DistributionQuery
//
//  Created by Macx on 16/10/8.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "Engine.h"

#import "AFNetworking.h"
@implementation Engine
#pragma mark --获取首页轮播图
+(void)huoQuFirstLunBoTusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@index/GetRotationPic",SER_VICE];
    NSLog(@"获取首页轮播图%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"获取首页轮播图%@",str);
         aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"获取首页轮播图%@",error);
    }];
    
}

#pragma mark --获取设备和物资专区
+(void)huoQuSheBeiWuZiZhuanQuClassIDType:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@index/GetIndustry?classid=%@",SER_VICE,type];
    NSLog(@"获取设备和物资专区%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取设备和物资专区%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取设备和物资专区%@",error);
    }];
    
    
}
#pragma mark --根据行业获取经纪人列表
+(void)huoQuJingJiRenWithHangYeID:(NSString*)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Broker/GetUserList?category=%@",SER_VICE,idd];
    NSLog(@"根据行业获取经纪人列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"根据行业获取经纪人列表%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"根据行业获取经纪人列表%@",error);
    }];
    
}
#pragma mark --1.会员注册
+(void)zhuCeAccountPhoneNumber:(NSString*)str Pwd:(NSString*)pwd CodeStr:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Member/Register?Mobile=%@&Password=%@&Code=%@",SER_VICE,str,pwd,code];
    NSLog(@"会员注册%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"1.会员注册%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"会员注册"];
        NSLog(@"会员注册%@",error);
    }];
    
    
    
}
#pragma mark --2.会员登录
+(void)loginAccountPhoneNumber:(NSString*)str Pwd:(NSString*)pwd CodeStr:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Login/Login?Mobile=%@&Password=%@&Code=%@",SER_VICE,str,pwd,code];
    NSLog(@"2.会员登录%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"2.会员登录%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"2.会员登录%@",error);
    }];
    
}

#pragma mark --3.获取验证码
+(void)getCodePhone:(NSString*)phone typeStr:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Login/GetCode?Mobile=%@&Type=%@",SER_VICE,phone,type];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSLog(@"获取验证码%@",urlStr);
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取验证码%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"获取验证码"];
        NSLog(@"获取验证码%@",error);
    }];
    
    
}



#pragma mark --5.获取首页特价专区
+(void)FirstTeJiaZhuanQusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Commodity/GetDiscountList?Count=10",SER_VICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"1.获取首页特价专区%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"1.获取首页特价专区%@",error);
    }];

}





#pragma mark --6.1（优质现货1，最新采购2）特价专区列表
+(void)tejiaZhuanQuLieBiaoHangYeID:(NSString*)category DiQu:(NSString*)area GuanJianZi:(NSString*)keyword Page:(NSString*)page PageSize:(NSString*)pagesize GongQiu:(NSString*)gq TeJia:(NSString*)tejia  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Commodity/GetList?Category=%@&Area=%@&Keyword=%@&Page=%@&PageSize=%@&Discount=%@&Business=%@",SER_VICE,category,area,keyword,page,pagesize,tejia,gq];
    NSLog(@"3.特价专区列表%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"3.特价专区列表%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"3.特价专区列表%@",error);
    }];
}
#pragma mark --6.2.列表详情界面
+(void)tableViewXiangQingJieMianMessageID:(NSString*)messageId success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    // http://api.hs95.com/Commodity/GetDetail?Id=7458
    NSString * urlStr =[NSString stringWithFormat:@"%@Commodity/GetDetail?Id=%@",SER_VICE,messageId];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"2.列表详情界面%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"列表详情界面%@",error);
    }];
    
}
#pragma mark --6获取顶级产品分类
+(void)getHangYeChanPinFenLeisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Category/GetTopList",SER_VICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"6获取顶级产品分类%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"6获取顶级产品分类%@",error);
    }];
    

    
    
}
#pragma mark --7根据行业获取分类
+(void)getHangYeWithID:(NSString*)Idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Category/GetTopList?Id=%@",SER_VICE,Idd];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"根据行业获取分类%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"根据行业获取分类%@",error);
    }];

}
#pragma mark --9获取省级地区
+(void)getShengJiDiQusuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Area/GetProvinceList",SER_VICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取省级地区%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"获取省级地区%@",error);
    }];

}
#pragma mark --10.根据省获取市
+(void)getCityWithShengCode:(NSString*)code success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Area/GetCityList?Id=%@",SER_VICE,code];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"根据省获取市%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"根据省获取市%@",error);
    }];
    
}
#pragma mark --12修改个人资料
+(void)XiuGaiMenZiLiaoNiCheng:(NSString*)nicheng Name:(NSString*)name Sheng:(NSString*)sheng City:(NSString*)city Xian:(NSString*)xian success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Member/ModifyPersonal",SER_VICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:nicheng forKey:@"NickName"];
    [dic setObject:name forKey:@"RealName"];
    if (sheng) {
    [dic setObject:sheng forKey:@"Province"];
    }if (city) {
    [dic setObject:city forKey:@"City"];
    }
   
    
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"修改个人资料%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [LCProgressHUD showFailure:@"请检查网络连接"];
        NSLog(@"修改个人资料%@",error);
    }];

    
}
#pragma mark --13修改公司资料
+(void)XiuGaiCompanyZiLiaoName:(NSString*)gongsi Address:(NSString*)adress HangYeID:(NSString*)hangyeID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@Member/ModifyCompany",SER_VICE];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:gongsi forKey:@"Company"];
    if (hangyeID) {
        [dic setObject:hangyeID forKey:@"Category"];
    }if (adress) {
        [dic setObject:adress forKey:@"Address"];
    }
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"修改公司资料%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"修改公司资料%@",error);
    }];

    
    
}
#pragma mark --14上传图片来获取图片地址
+(void)ShangChuanImageData:(NSData*)dataImage Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@uploadfile/UpLoadProcess",SER_VICE];

    //获得的data
    NSData *imageData=dataImage;
    //base编码后
    NSString * endStr =[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:endStr forKey:@"img"];
    [dic setObject:type forKey:@"type"];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"上传图片后返回的地址%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传图片后返回的地址%@",error);
    }];

}
#pragma mark --15保存图片
+(void)saveImageType:(NSString*)type urlStr:(NSString*)url success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Member/SaveImg",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:type forKey:@"Type"];
    [dic setObject:url forKey:@"Url"];
     NSLog(@"token=%@",[NSUSE_DEFO objectForKey:@"token"]);
     NSLog(@"UId=%@",[NSUSE_DEFO objectForKey:@"mid"]);
     NSLog(@"Type=%@",type);
     NSLog(@"Url=%@",url);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"15保存图片%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"15保存图片%@",error);
    }];
}
#pragma mark --17获取图片
+(void)huoQuImageWithType:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@Member/GetImg",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:type forKey:@"Type"];
//    NSLog(@"token=%@",[NSUSE_DEFO objectForKey:@"token"]);
//    NSLog(@"UId=%@",[NSUSE_DEFO objectForKey:@"mid"]);
//    NSLog(@"Type=%@",type);
//    NSLog(@"Url=%@",url);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"17获取图片%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"17获取图片%@",error);
    }];
}
#pragma mark --19添加信息记录(浏览，收藏，关注)
+(void)addMessageJiLuMessageID:(NSString*)pid Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@ViewLog/AddViewLog",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:pid forKey:@"PId"];
    [dic setObject:type forKey:@"Type"];
    NSLog(@"1输出看看%@",[NSUSE_DEFO objectForKey:@"token"]);
     NSLog(@"2输出看看%@",pid);
     NSLog(@"3输出看看%@",type);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"添加信息记录%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"添加信息记录错误%@",error);
    }];
    
}
#pragma mark --20删除信息记录
+(void)deleteMessageID:(NSString*)pid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@ViewLog/DeleteViewLog",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:pid forKey:@"PId"];
    NSLog(@"1输出看看%@",[NSUSE_DEFO objectForKey:@"token"]);
    NSLog(@"2输出看看%@",pid);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"删除信息记录%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"删除信息记录错误%@",error);
    }];
}
#pragma mark --21获取信息记录列表（浏览，收藏，关注）
+(void)getMessageJiLuType:(NSString*)type Page:(NSString*)page PageSize:(NSString*)tiaoShu success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@ViewLog/GetViewLogList",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[NSUSE_DEFO objectForKey:@"token"] forKey:@"Token"];
    [dic setObject:type forKey:@"Type"];
    [dic setObject:page forKey:@"Page"];
    [dic setObject:tiaoShu forKey:@"PageSize"];
    
    
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取信息记录列表%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取信息记录列表错误%@",error);
    }];
}
@end
