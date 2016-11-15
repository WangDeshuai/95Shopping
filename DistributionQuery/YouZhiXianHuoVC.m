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
@interface YouZhiXianHuoVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)UITableView*leftTabelView;
@property(nonatomic,strong)UITableView*rightTabelView;
@property(nonatomic,strong)UIButton * bgview;
@property(nonatomic,strong)UIButton * button1;
@property(nonatomic,strong)UIButton * button2;
@end
@implementation YouZhiXianHuoVC
-(void)viewWillAppear:(BOOL)animated{
     [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
     self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    if (_tagg==1) {
        self.title=@"优质现货";
    }else if (_tagg==10){
        self.title=@"特价专区";
        [self shuJuJieXiDataPage:@"1" HangYe:@"0"];
    }else if (_tagg==11){
        self.title=@"设备专区";
    }else if (_tagg==12){
        self.title=@"物资专区";
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
-(void)shuJuJieXiDataPage:(NSString*)page HangYe:(NSString*)hangye{
    [Engine tejiaZhuanQuLieBiaoHangYeID:hangye DiQu:@"0" GuanJianZi:@"0" Page:page PageSize:@"10" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            
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
    if (btn.tag==0) {
        //点击的是第一个
        if (btn.selected==YES) {
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
    
    _leftTabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+51, ScreenWidth/2.5, ScreenHeight/1.5) style:UITableViewStylePlain];
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
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==_leftTabelView) {
     return 15;
    }else if (tableView==_rightTabelView){
     return 20;
    }else{
     return 10;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==_leftTabelView) {
       
        UITableViewCell * cell1 =[LeftMyAdressCell cellWithTableView:tableView];
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell1;
    }else if (tableView==_rightTabelView)
    {
        UITableViewCell * cell1 =[RightMyAddressCell cellWithTableView:tableView];
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell1;
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
        YouZhiXianHuoCell * cell =[YouZhiXianHuoCell cellWithTableView:tableView CellID:CellIdentifier];
        [cell.chaKanBtn addTarget:self action:@selector(chaKan:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
  
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==_leftTabelView) {
        [self CreatRightTableView:ScreenWidth-ScreenWidth/2.5 Xzhou:ScreenWidth/2.5 Gzhou:ScreenHeight/1.5];
    }else if (tableView==_rightTabelView){
        
    }else{
        XiangQingVC * vc =[XiangQingVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView==_leftTabelView) {
        return 44;
    }else if (tableView==_rightTabelView){
        return 44;
    }else{
        return 95;
    }

}

#pragma mark --立即查看
-(void)chaKan:(UIButton*)btn{
    XiangQingVC * vc =[XiangQingVC new];
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
