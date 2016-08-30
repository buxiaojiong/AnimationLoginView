//
//  ViewController.m
//  AnimationLoginView
//
//  Created by sourcecode on 16/8/29.
//  Copyright © 2016年 sourcecode. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface ViewController ()
<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIView *leftHand;
@property (nonatomic, strong) UIView *rightHand;

@property (nonatomic, strong) UIImageView *leftArm;
@property (nonatomic, strong) UIImageView *rightArm;

@property (nonatomic, strong) UIView *view1;


@property (nonatomic,assign)CGFloat leftArmX;
@property (nonatomic,assign)CGFloat leftArmY;
@property (nonatomic,assign)CGFloat rightArmX;
@property (nonatomic,assign)CGFloat rightArmY;

@property (nonatomic,assign)CGFloat viewFrameH;
@property (nonatomic,assign)CGFloat viewFrameW;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *backView = [UIView new];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(300);
    }];
    backView.backgroundColor = UIColorFromRGB(0xfe3e6f);
    
    UILabel *nameLabel = [UILabel new];
    [backView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(10);
        make.top.equalTo(backView).offset(15);
        make.width.mas_equalTo(60);
    }];
    nameLabel.text = @"用户名:";
    nameLabel.textAlignment = NSTextAlignmentRight;
    [nameLabel sizeToFit];
    
    UILabel *passwordLabel = [UILabel new];
    [backView addSubview:passwordLabel];
    [passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).offset(10);
        make.top.equalTo(nameLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(60);
    }];
    passwordLabel.text = @"密码:";
    passwordLabel.textAlignment = NSTextAlignmentRight;
    [passwordLabel sizeToFit];
    
    self.nameTextField = [UITextField new];
    [backView addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.top.equalTo(backView).offset(15);
        make.right.equalTo(backView.mas_right).offset(-10);
        make.height.equalTo(nameLabel.mas_height);
    }];
    self.nameTextField.backgroundColor = [UIColor whiteColor];
    self.nameTextField.layer.cornerRadius = 5.0;
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.passwordTextField = [UITextField new];
    [backView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordLabel.mas_right).offset(10);
        make.top.equalTo(self.nameTextField.mas_bottom).offset(15);
        make.right.equalTo(backView.mas_right).offset(-10);
        make.height.equalTo(nameLabel.mas_height);
    }];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.layer.cornerRadius = 5.0;
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.delegate = self;
    
    self.view1 = [UIView new];
    [self.view addSubview:self.view1];
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backView.mas_top);
        make.width.mas_equalTo(300 - 40);
        make.height.mas_equalTo(54*2-8);
        make.centerX.equalTo(backView);
    }];
//    view1.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
//    view1.clipsToBounds = YES;
    

    UIImageView *topImageView = [UIImageView new];
    [self.view1 addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view1.mas_bottom).offset(8);
        make.width.mas_equalTo(105.5*2);
        make.height.mas_equalTo(54*2);
        make.centerX.equalTo(self.view1);
    }];
    topImageView.image = [UIImage imageNamed:@"owl-login"];
    

    self.leftHand = [UIView new];
    [self.view1 addSubview:self.leftHand];
    [self.leftHand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view1);
        make.bottom.equalTo(self.view1.mas_bottom).offset(12.5);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(25);
    }];
    
    self.rightHand = [UIView new];
    [self.view1 addSubview:self.rightHand];
    [self.rightHand mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view1);
        make.bottom.equalTo(self.view1.mas_bottom).offset(12.5);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(25);
    }];
    
    
    UIBezierPath *ovalPath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 50, 25)];
    
    /**创建带形状的图层*/
    CAShapeLayer *shapeLayer=[CAShapeLayer layer];
    shapeLayer.frame=CGRectMake(0, 0, 50, 25);

    /**注意:图层之间与贝塞尔曲线之间通过path进行关联*/
    shapeLayer.path = ovalPath.CGPath;
    shapeLayer.fillColor = UIColorFromRGB(0x513627).CGColor;
    [self.leftHand.layer addSublayer:shapeLayer];
    
    CAShapeLayer *shapeLayer2 =[CAShapeLayer layer];
    shapeLayer2.frame=CGRectMake(0, 0, 50, 25);
    
    /**注意:图层之间与贝塞尔曲线之间通过path进行关联*/
    shapeLayer2.path = ovalPath.CGPath;
    shapeLayer2.fillColor = UIColorFromRGB(0x513627).CGColor;
    [self.rightHand.layer addSublayer:shapeLayer2];
    
    UIView *view2 = [UIView new];
    [self.view1 addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view1).offset(3);
        make.bottom.equalTo(self.view1.mas_bottom);
        make.width.mas_equalTo(40 * 2+15);
        make.height.mas_equalTo(40);
    }];
//    view2.backgroundColor = [UIColor colorWithRed:43 green:43 blue:43 alpha:0.3];
    view2.clipsToBounds = YES;
    
    self.leftArm = [UIImageView new];
    [view2 addSubview:self.leftArm];
    [self.leftArm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2);
        make.top.equalTo(view2);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(65);
    }];
    self.leftArm.image = [UIImage imageNamed:@"owl-login-arm"];

    
    UIImage *rightarmimage = [UIImage imageWithCGImage:[UIImage imageNamed:@"owl-login-arm"].CGImage scale:1 orientation:UIImageOrientationUpMirrored];
    
    self.rightArm = [UIImageView new];
    [view2 addSubview:self.rightArm];
    [self.rightArm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view2);
        make.top.equalTo(view2);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(65);
    }];
    self.rightArm.image = rightarmimage;
    
    
    [self.view1.superview layoutIfNeeded];
    
    
    
    
    self.leftArmX = self.leftArm.frame.origin.x;
    self.leftArmY = self.leftArm.frame.origin.y;
    //当前右手的位置
    self.rightArmX = self.rightArm.frame.origin.x;
    self.rightArmY = self.rightArm.frame.origin.y;
    
    self.viewFrameH = self.view1.frame.size.height;
    self.viewFrameW = self.view1.frame.size.width;
    NSLog(@"%f %f",self.leftArmX,self.viewFrameH);
    
    self.leftArmX = -self.leftArmX - 15;
    self.leftArmY = self.viewFrameH - self.leftArmY;
    self.rightArmX = self.viewFrameW - self.rightArmX - self.rightArm.frame.size.width +15;
    self.rightArmY = self.viewFrameH - self.rightArmY;
    //根据计算出的左右手的初始位置,设置初始位置左右手的偏移量
    self.rightArm.transform = CGAffineTransformMakeTranslation(self.rightArmX, self.rightArmY);
    self.leftArm.transform = CGAffineTransformMakeTranslation(self.leftArmX, self.leftArmY);
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

//方便调用,样式:[self.loginAnim startAnim:YES];
- (void)startAnim:(BOOL)isCoverd
{

 
    if (isCoverd) {
        //动画持续时间0.25秒
        [UIView animateWithDuration:0.25 animations:^{
            // 蒙眼
            self.rightArm.transform = CGAffineTransformTranslate(self.rightArm.transform, -self.rightArmX, -self.rightArmY);
            self.leftArm.transform = CGAffineTransformTranslate(self.leftArm.transform, -self.leftArmX, -self.leftArmY);
            //小圆点移动到眼睛的位置,30为根据图片显示位置手动调整的尺寸
            CGAffineTransform rightHand = CGAffineTransformTranslate(self.rightArm.transform, -self.rightArmX+90, -self.rightArmY+100);
            CGAffineTransform leftHand =  CGAffineTransformTranslate(self.leftArm.transform, -self.leftArmX+90, -self.leftArmY+100);
            //小圆点在移动的过程中逐渐减小
            self.rightHand.transform = CGAffineTransformScale(rightHand, 0.01, 0.01);
            self.leftHand.transform = CGAffineTransformScale(leftHand, 0.01, 0.01);
        }];
    }else
    {
        [UIView animateWithDuration:0.25 animations:^{
            //不蒙眼,也就是初始状态
            //两个手臂回到初始化状态
            self.rightArm.transform = CGAffineTransformMakeTranslation(self.rightArmX, self.rightArmY);
            self.leftArm.transform = CGAffineTransformMakeTranslation(self.leftArmX, self.leftArmY);
            //两个小圆点回到默认设置
            self.rightHand.transform = CGAffineTransformIdentity;
            self.leftHand.transform = CGAffineTransformIdentity;

        }];
    }
}

// 获取第一响应者时调用
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self startAnim:YES];
    return YES;
}

// 失去第一响应者时调用
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self startAnim:NO];
    return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
