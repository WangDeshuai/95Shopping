//
//  YouZhiXianHuoVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/10.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "YouZhiXianHuoVC.h"
#import "YouZhiXianHuoCell.h"
#import "XiangQingVC.h"
#import "LeftMyAdressCell.h"
#import "RightMyAddressCell.h"
#import "HomeModel.h"
#import "CityModel.h"
#import "HangYeModel.h"
@interface YouZhiXianHuoVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UITableView*leftTabelView;
@property(nonatomic,strong)UITableView*rightTabelView;
@property(nonatomic,strong)UIButton * bgview;
@property(nonatomic,strong)UIButton * button1;
@property(nonatomic,strong)UIButton * button2;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)int AAA;
@property (nonatomic, strong) MJRefreshComponent *myRefreshView;
//顶级数组
@property(nonatomic,strong)NSMutableArray * shengArr;
@property(nonatomic,strong)NSMutableArray * cityArr;
@property(nonatomic,assign)NSInteger btntag;//用来区分左右按钮
@end
@implementation YouZhiXianHuoVC
-(void)viewWillAppear:(BOOL)animated{
     [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
     self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _dataArray=[NSMutableArray new];
    _shengArr=[NSMutableArray new];
    _cityArr=[NSMutableArray new];
    if (_tagg==1) {
        self.title=@"优质现货";
        
    }else if (_tagg==10){
        self.title=@"特价专区";
        // [self shuJuJieXiDataPage:@"1" TeJia:@"1"];
    }else if (_tagg==11){
        self.title=@"设备专区";
         // [self shuJuJieXiDataPage:@"1" TeJia:@"1"];
    }else if (_tagg==12){
        self.title=@"物资专区";
          //[self shuJuJieXiDataPage:@"1" TeJia:@"1"];
    }
    
    NSMutableArray* titleArr =[[NSMutableArray alloc]initWithObjects:@"地区",@"行业", nil];
    _bgview=[[UIButton alloc]init];
    _bgview.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    _bgview.backgroundColor=[UIColor blackColor];
    [_bgview addTarget:self action:@selector(bgViewBtn) forControlEvents:UIControlEventTouchUpInside];
    _bgview.alpha=.5;
   
   [self CreatBtnTitle:titleArr];
   [self CreatTableView];
}

#pragma mark --数据解析
-(void)shuJuJieXiDataPage:(NSString*)page TeJia:(NSString*)te{
    //GongQiu 1优质现货 2最新采购
   
    [Engine tejiaZhuanQuLieBiaoHangYeID:@"0" DiQu:@"0" GuanJianZi:@"0" Page:page PageSize:@"10" GongQiu:@"1" TeJia:te success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            
            if ([dic objectForKey:@"Item3"]==[NSNull null]) {
                 [LCProgressHUD showMessage:@"Item3没有数据"];
            }else{
                NSArray * array =[dic objectForKey:@"Item3"];
                 NSMutableArray * array2=[NSMutableArray new];
                for (NSDictionary * dicc in array) {
                    HomeModel * md =[[HomeModel alloc]initWithYouZhiXianHuoDic:dicc];
                    [array2 addObject:md];
                }
                if (self.myRefreshView == _tableView.header) {
                    _dataArray = array2;
                    _tableView.footer.hidden = _dataArray.count==0?YES:NO;
                }else if(self.myRefreshView == _tableView.footer){
                    [_dataArray addObjectsFromArray:array2];
                }
                
                
            }
            [_tableView reloadData];
            [_myRefreshView  endRefreshing];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
             [_myRefreshView endRefreshing];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --获取全国省份
-(void)shengFenData{
     [_shengArr removeAllObjects];
    [Engine getShengJiDiQusuccess:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in arr)
            {
                 CityModel * model =[[CityModel alloc]initWithShengDic:dicc];
                [_shengArr addObject:model];
            }
            
            [_leftTabelView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --获取所有行业
-(void)getHangYeAll{
    [_shengArr removeAllObjects];
    [Engine getHangYeChanPinFenLeisuccess:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in arr) {
                HangYeModel * md =[[HangYeModel alloc]initWithHangYeAllDic:dicc];
                 [_shengArr addObject:md];
            }
            [_leftTabelView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}

#pragma mark --创建下拉的Button
-(void)CreatBtnTitle:(NSMutableArray*)arr{
    CGFloat k =(ScreenWidth)/arr.count;///3-20;
    CGFloat g =45;
   
        for (int i = 0; i<arr.count; i++) {
           UIButton *  menuBtn  =[UIButton buttonWithType:UIButtonTypeCustom];
           [self.view sd_addSubviews:@[menuBtn]];
            menuBtn.sd_layout
            .leftSpaceToView(self.view,k*i)
            .topSpaceToView(self.view,5+64)
            .widthIs(k)
            .heightIs(g);
            menuBtn.backgroundColor=[UIColor whiteColor];
            [menuBtn setTitleColor:[UIColor blackColor] forState:0];
            menuBtn.titleLabel.font=[UIFont systemFontOfSize:15];
            menuBtn.tag=i;
            [menuBtn setImage:[UIImage imageNamed:@"xia123"] forState:UIControlStateNormal];
            [menuBtn addTarget:self action:@selector(butTitleClink:) forControlEvents:UIControlEventTouchUpInside];
            [menuBtn setTitle:arr[i] forState:0];
            [menuBtn setImage:[UIImage imageNamed:@"shang123"] forState:UIControlStateSelected];
            [menuBtn setImageEdgeInsets:UIEdgeInsetsMake(0,k-20, 0, 0)];
            [menuBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            [menuBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            
        }
    
    
}

#pragma mark --topBtn点击状态
-(void)butTitleClink:(UIButton*)btn{
     btn.selected=!btn.selected;
    _btntag=btn.tag;
    if (btn.tag==0) {
        //点击的是第一个
        if (btn.selected==YES) {
             [self shengFenData];
            _tableView.scrollEnabled=NO;
            [_tableView setContentOffset:CGPointZero animated:NO];
            [_tableView addSubview:_bgview];
            [_rightTabelView removeFromSuperview];
            [_leftTabelView removeFromSuperview];
            _button2.selected=NO;
            [self CreatLeftTableVeiw];
        }else{
            [self dissmiss];
        }
        
        _button1=btn;
        
    }else{
        //点击的是第二个
        if (btn.selected==YES) {
             [self getHangYeAll];
            _tableView.scrollEnabled=NO;
            [_tableView setContentOffset:CGPointZero animated:NO];
            [_tableView addSubview:_bgview];
            [_leftTabelView removeFromSuperview];
            [_rightTabelView removeFromSuperview];
            _button1.selected=NO;
             [self CreatLeftTableVeiw];
        }else{
            [self dissmiss];
        }
        _button2=btn;
    }
}
#pragma mark --灰色按钮点击取消
-(void)bgViewBtn{
    [self dissmiss];
    _button1.selected=NO;
    _button2.selected=NO;
}

#pragma mark --创建左边表格
-(void)CreatLeftTableVeiw{
    
    _leftTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+51, ScreenWidth/2, ScreenHeight/1.5) style:UITableViewStylePlain];
    _leftTabelView.dataSource=self;
    _leftTabelView.delegate=self;
    _leftTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_leftTabelView];
    
}
#pragma mark --创建第二个表格
-(void)CreatRightTableView:(CGFloat)kuan Xzhou:(CGFloat)x Gzhou:(CGFloat)g{
    [_rightTabelView removeFromSuperview];
    _rightTabelView=nil;
    if (_rightTabelView==nil) {
        _rightTabelView=[[UITableView alloc]initWithFrame:CGRectMake(x, 64+51,kuan, g) style:UITableViewStylePlain];
        _rightTabelView.backgroundColor=COLOR;
        _rightTabelView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _rightTabelView.dataSource=self;
        _rightTabelView.delegate=self;
        [self.view addSubview:_rightTabelView];
    }
    
}

#pragma mark --创建主表
-(void)CreatTableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+51, ScreenWidth, ScreenHeight-64-51) style:UITableViewStylePlain];
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    //刷新操作
    __weak typeof (self) weakSelf =self;
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         NSLog(@"往下拉了");
        weakSelf.myRefreshView = weakSelf.tableView.header;
        if (_tagg==1) {
            [self shuJuJieXiDataPage:@"1" TeJia:@"0"];
        }else{
            [self shuJuJieXiDataPage:@"1" TeJia:@"1"];
        }
        
    }];
    
    // 马上进入刷新状态
    [_tableView.header beginRefreshing];
    //..上拉刷新
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
         weakSelf.myRefreshView = weakSelf.tableView.footer;
        NSLog(@"往上拉了");
        _AAA=_AAA+1;
        if (_tagg==1) {
        [self shuJuJieXiDataPage:[NSString stringWithFormat:@"%d",_AAA] TeJia:@"0"];
        }else{
        [self shuJuJieXiDataPage:[NSString stringWithFormat:@"%d",_AAA] TeJia:@"1"];
        }
       
    }];
    _tableView.footer.hidden = YES;

    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==_leftTabelView) {
     return _shengArr.count;
    }else if (tableView==_rightTabelView){
     return _cityArr.count;
    }else{
     return _dataArray.count;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==_leftTabelView) {
       
        LeftMyAdressCell * cell1 =[LeftMyAdressCell cellWithTableView:tableView];
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (_btntag==0) {
            //点击的是城市给城市赋值
             CityModel * md =_shengArr[indexPath.row];
            cell1.name=md.shengName;
        }else{
            //点击的是行业，给行业赋值
            HangYeModel * md =_shengArr[indexPath.row];
            cell1.name=md.HYname;
        }
      
       
        
        return cell1;
    }else if (tableView==_rightTabelView)
    {
        RightMyAddressCell * cell1 =[RightMyAddressCell cellWithTableView:tableView];
        if (_btntag==0) {
            CityModel * md =_cityArr[indexPath.row];
            cell1.name=md.cityName;
        }else{
            HangYeModel * md =_cityArr[indexPath.row];
            cell1.name=md.HYname;
        }
       
        return cell1;
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
        YouZhiXianHuoCell * cell =[YouZhiXianHuoCell cellWithTableView:tableView CellID:CellIdentifier];
        cell.chaKanBtn.tag=indexPath.row;
        [cell.chaKanBtn addTarget:self action:@selector(chaKan:) forControlEvents:UIControlEventTouchUpInside];
        cell.model=_dataArray[indexPath.row];
        return cell;
  
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (tableView==_leftTabelView) {
        [self CreatRightTableView:ScreenWidth-ScreenWidth/2 Xzhou:ScreenWidth/2 Gzhou:ScreenHeight/1.5];
        if (_btntag==0) {
            CityModel * mdd =_shengArr[indexPath.row];
            [self shengWithCity:mdd];
        }else{
            HangYeModel * md =_shengArr[indexPath.row];
            [self genJuIddGetHangYe:md];
        }
        
      //  NSLog(@"输出看看省的code=%@",mdd.shengCode);
      
        
    }else if (tableView==_rightTabelView){
        if (_btntag==0) {
            CityModel * mdd=_cityArr[indexPath.row];
            _button1.selected=NO;
            [_button1 setTitle:mdd.cityName forState:0];
            _button1.titleLabel.font=[UIFont systemFontOfSize:14];
        }else{
            HangYeModel * mdd =_cityArr[indexPath.row];
            _button2.selected=NO;
            [_button2 setTitle:mdd.HYname forState:0];
            _button2.titleLabel.font=[UIFont systemFontOfSize:14];
        }
       
        [self dissmiss];
    }else{
         HomeModel * md =_dataArray[indexPath.row];
        XiangQingVC * vc =[XiangQingVC new];
        vc.messageID=md.messageID;
        NSLog(@"messageID=%@",md.messageID);
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}
#pragma mark --根据省去解析市级
-(void)shengWithCity:(CityModel*)mdd{
    [_cityArr removeAllObjects];
    [Engine getCityWithShengCode:mdd.shengCode success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * cityA =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in cityA)
            {
                CityModel * mmd =[[CityModel alloc]initWithCityDic:dicc];
                [_cityArr addObject:mmd];
            }
            
            [_rightTabelView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
}
#pragma mark --根据ID获取行业分类
-(void)genJuIddGetHangYe:(HangYeModel*)md{
     [_cityArr removeAllObjects];//把之前的城市清楚，换成行业数据
    [Engine getHangYeWithID:md.HYidd success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            NSArray * arr =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in arr) {
                HangYeModel * md =[[HangYeModel alloc]initWithHangYeAllDic:dicc];
                [_cityArr addObject:md];
            }
            [_rightTabelView reloadData];
        }else{
            [LCProgressHUD showMessage:[dic objectForKey:@"Item2"]];
        }
    } error:^(NSError *error) {
        
    }];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_leftTabelView) {
        return 44;
    }else if (tableView==_rightTabelView){
        return 44;
    }else{
        return [_tableView cellHeightForIndexPath:indexPath model:_dataArray[indexPath.row]keyPath:@"model" cellClass:[YouZhiXianHuoCell class] contentViewWidth:[ToolClass  cellContentViewWith]];
    }

}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
#pragma mark --立即查看
-(void)chaKan:(UIButton*)btn{
    HomeModel * md =_dataArray[btn.tag];
    XiangQingVC * vc =[XiangQingVC new];
    vc.messageID=md.messageID;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dissmiss{
    _tableView.scrollEnabled=YES;
    [_bgview removeFromSuperview];
    [_leftTabelView removeFromSuperview];
    [_rightTabelView removeFromSuperview];
}
@end
