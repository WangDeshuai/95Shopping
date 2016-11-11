//
//  LoginVC.m
//  DistributionQuery
//
//  Created by Macx on 16/11/11.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "LoginVC.h"
#import "RegistVC.h"
@interface LoginVC ()
@property(nonatomic,strong)UIImageView * topImageview;//天空图片
@property(nonatomic,strong)UITextField *phoneText;//手机号
@property(nonatomic,strong)UITextField *pwdText;//请输入密码
@property(nonatomic,strong)UITextField * codeText;//输入验证码
@property(nonatomic,strong)UIButton * codeBtn;//获取验证码
@property(nonatomic,strong)UIButton * forgetBtn;//忘记密码
@property(nonatomic,strong)UIButton * loginBtn;
@property(nonatomic,strong)UIView * lineView1;
@property(nonatomic,strong)UIView * lineView2;
@property(nonatomic,strong)UIView * lineView3;
@property(nonatomic,strong)UIView * bgview;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"95商城";
    self.view.backgroundColor=[UIColor whiteColor];
    [self CreatRightBtn];
    [self CreatTopImageView];//创建天空的图片
    [self CreatView];
    [self CreatLoginBtn];//登录按钮
}

#pragma mark --注册
-(void)CreatRightBtn{
    //搜索按钮
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"注册" forState:0];
    [rightBtn setTitleColor:[UIColor redColor] forState:0];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:TITLE_FOUNT];
    rightBtn.frame=CGRectMake(0, 0, 50, 15);
    [rightBtn addTarget:self action:@selector(registBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtnn =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems=@[rightBtnn];

}

#pragma mark --注册
-(void)registBtn:(UIButton*)btn{
    RegistVC * vc =[RegistVC new];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark--  创建天空的图片
-(void)CreatTopImageView{
    _topImageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_banner"]];
    [self.view sd_addSubviews:@[_topImageview]];
    _topImageview.sd_layout
    .leftSpaceToView(self.view,0)
    .topSpaceToView(self.view,64)
    .rightSpaceToView(self.view,0)
    .heightIs(ScreenWidth*434/750);
}
#pragma mark --创建白色的view
-(void)CreatView{
    _bgview=[[UIView alloc]init];
    _bgview.backgroundColor=[UIColor whiteColor];
    [self.view sd_addSubviews:@[_bgview]];
    _bgview.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(_topImageview,20);
    
    //手机号
    _phoneText=[[UITextField alloc]init];
    _phoneText.placeholder=@"手机号";
    _phoneText.alpha=1;
    _phoneText.leftView =[self imageViewNameStr:@"phone"];
    _phoneText.leftViewMode = UITextFieldViewModeAlways;
    [_bgview sd_addSubviews:@[_phoneText]];
    _phoneText.sd_layout
    .leftSpaceToView(_bgview,40)
    .rightSpaceToView(_bgview,40)
    .heightIs(30)
    .topSpaceToView(_bgview,10);
    
    //线条1
    _lineView1=[UIView new];
    _lineView1.backgroundColor=COLOR;
    [_bgview sd_addSubviews:@[_lineView1]];
    _lineView1.sd_layout
    .leftEqualToView(_phoneText)
    .rightEqualToView(_phoneText)
    .topSpaceToView(_phoneText,10)
    .heightIs(1);
    
    //请输入密码
    _pwdText=[[UITextField alloc]init];
    _pwdText.placeholder=@"请输入密码";
    _pwdText.alpha=1;
    _pwdText.leftView =[self imageViewNameStr:@"login_ps"];
    _pwdText.leftViewMode = UITextFieldViewModeAlways;
    [_bgview sd_addSubviews:@[_pwdText]];
    _pwdText.sd_layout
    .leftEqualToView(_phoneText)
    .rightEqualToView(_phoneText)
    .heightRatioToView(_phoneText,1)
    .topSpaceToView(_lineView1,15);
    
    //线条2
    _lineView2=[UIView new];
    _lineView2.backgroundColor=COLOR;
    [_bgview sd_addSubviews:@[_lineView2]];
    _lineView2.sd_layout
    .leftEqualToView(_lineView1)
    .rightEqualToView(_lineView1)
    .topSpaceToView(_pwdText,10)
    .heightIs(1);
    
    //获取验证码btn
    _codeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _codeBtn.backgroundColor=COLOR;
    [_codeBtn setTitle:@"获取验证码" forState:0];
    [_codeBtn setTitleColor:[UIColor blackColor] forState:0];
    _codeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    
    [_bgview sd_addSubviews:@[_codeBtn]];
    _codeBtn.sd_layout
    .widthIs(100)
    .rightEqualToView(_phoneText)
    .heightIs(40)
    .topSpaceToView(_lineView2,10);
    
    
    //请输入验证码
    _codeText=[[UITextField alloc]init];
    _codeText.placeholder=@"请输入验证码";
    _codeText.leftView =[self imageViewNameStr:@"login_yanzhnegma"];
    _codeText.leftViewMode = UITextFieldViewModeAlways;
    [_bgview sd_addSubviews:@[_codeText]];
    _codeText.sd_layout
    .leftEqualToView(_phoneText)
    .rightSpaceToView(_codeBtn,0)
    .heightRatioToView(_phoneText,1)
    .topSpaceToView(_lineView2,15);
    
    //线条3
    _lineView3=[UIView new];
    _lineView3.backgroundColor=COLOR;
    [_bgview sd_addSubviews:@[_lineView3]];
    _lineView3.sd_layout
    .leftEqualToView(_lineView2)
    .rightEqualToView(_lineView2)
    .topSpaceToView(_codeText,10)
    .heightIs(1);

    //忘记密码
    _forgetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [_forgetBtn setTitle:@"忘记密码?" forState:0];
    [_forgetBtn setTitleColor:[UIColor redColor] forState:0];
    _forgetBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    _forgetBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [_bgview sd_addSubviews:@[_forgetBtn]];
    _forgetBtn.sd_layout
    .widthIs(100)
    .rightEqualToView(_lineView3)
    .heightRatioToView(_phoneText,1)
    .topSpaceToView(_lineView3,10);
    
    [_bgview setupAutoHeightWithBottomView:_forgetBtn bottomMargin:10];
    
    
    
}
#pragma mark --登录按钮
-(void)CreatLoginBtn{
    //登录
    _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.backgroundColor=[UIColor redColor];
   // [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_bt"] forState:0];
    [_loginBtn setTitle:@"登录" forState:0];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:0];
    _loginBtn.sd_cornerRadius=@(5);
    [self.view sd_addSubviews:@[_loginBtn]];
    _loginBtn.sd_layout
    .leftEqualToView(_lineView3)
    .rightEqualToView(_lineView3)
    .heightIs(40)
    .topSpaceToView(_bgview,0);

}
-(UIButton*)imageViewNameStr:(NSString*)imageName{
    UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:0];
    
    btn.frame=CGRectMake(0, 0, 30, 30);
    return btn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end