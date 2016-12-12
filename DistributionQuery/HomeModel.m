//
//  HomeModel.m
//  DistributionQuery
//
//  Created by Macx on 16/11/14.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
#pragma mark --特价专区Model
-(id)initWithTeJiaDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * image =[ToolClass isString:[dic objectForKey:@"C_CommodityPic"]];
        _imageview=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,image];
        _titleName=[ToolClass isString:[dic objectForKey:@"C_Title"]];
        _priceName=[ToolClass isString:[dic objectForKey:@"C_ExpectPrice"]];
        NSString *city=[ToolClass isString:[dic objectForKey:@"C_City_Name"]];
        NSString *sheng=[ToolClass isString:[dic objectForKey:@"C_Prov_Name"]];
        _cityName=[NSString stringWithFormat:@"%@-%@",sheng,city];
        _taishuName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_LookCount"]]];
        _sheBeiName=[ToolClass isString:[dic objectForKey:@"C_ProductName"]];
    }
    
    return self;
}
//优质现货
-(id)initWithYouZhiXianHuoDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
         NSString * image =[ToolClass isString:[dic objectForKey:@"C_CommodityPic"]];
        _imageview=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,image];
        _titleName=[ToolClass isString:[dic objectForKey:@"C_Title"]];
        _priceName=[ToolClass isString:[dic objectForKey:@"C_ExpectPrice"]];
        NSString *city=[ToolClass isString:[dic objectForKey:@"C_City_Name"]];
        NSString *sheng=[ToolClass isString:[dic objectForKey:@"C_Prov_Name"]];
        NSLog(@"aa输出%@",sheng);
        NSLog(@"bb输出%@",city);
        _cityName=[NSString stringWithFormat:@"%@-%@",sheng,city];
          NSLog(@"cc输出%@",_cityName);
        _taishuName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_LookCount"]]];
        _sheBeiName=[ToolClass isString:[dic objectForKey:@"C_ProductName"]];
        _messageID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Id"]]];
        
    }
    
    return self;
}

//优质商户
-(id)initWithYouZhiShangHuDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * image =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_PlaceImg"]]];
        _imageview=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,image];
        _titleName=[ToolClass isString:[dic objectForKey:@"M_CompanyName"]];
        NSString *city=[ToolClass isString:[dic objectForKey:@"M_CityName"]];
        NSString *sheng=[ToolClass isString:[dic objectForKey:@"M_ProvinceName"]];
       
        _cityName=[NSString stringWithFormat:@"%@-%@",sheng,city];
      //代替收藏
        _taishuName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_Hits"]]];
      //代替成交
        _sheBeiName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_Volumes"]]];
        //头像
        _priceName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_HeadImg"]]];
        //电话
        _phoneNumber=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_MobieNum"]]];
        _messageID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"M_Id"]]];
    }
    
    return self;
}








//最新采购(收藏采购)
-(id)initWithCaiGouDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        NSString * image =[ToolClass isString:[dic objectForKey:@"C_CommodityPic"]];
        _imageview=[NSString stringWithFormat:@"%@%@",IMAGE_TITLE,image];
        _titleName=[ToolClass isString:[dic objectForKey:@"C_Title"]];
        _priceName=[ToolClass isString:[dic objectForKey:@"C_ExpectPrice"]];
        NSString *city=[ToolClass isString:[dic objectForKey:@"C_City_Name"]];
        NSString *sheng=[ToolClass isString:[dic objectForKey:@"C_Prov_Name"]];
      
        _phoneNumber=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"E_Number"]]];
        _cityName=[NSString stringWithFormat:@"%@-%@",sheng,city];
      
        _taishuName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"C_Count"]]];
        _sheBeiName=[ToolClass isString:[dic objectForKey:@"C_ProductName"]];
        _messageID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"V_Id"]]];
    }
    
    return self;
}
@end
