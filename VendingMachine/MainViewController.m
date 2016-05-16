//
//  MainViewController.m
//  VendingMachine
//
//  Created by LEEJIHO on 2016. 5. 13..
//  Copyright © 2016년 LEEJIHO. All rights reserved.
//

#import "MainViewController.h"
#import "CustomButton.h"
#import "TrayBox.h"
#import "DrinkObject.h"
#import "Casher.h"

@interface MainViewController () <CustomButtonDelegate>

@property (nonatomic) TrayBox *trayBox;
@property (nonatomic) Casher *casher;

// 메뉴 영역
@property(nonatomic, weak) UIView *menuView;
// 500원 코인추가 영역
@property(nonatomic, weak) UIView *input500CoinArea;
@property(nonatomic, weak) UILabel *title500CoinLb;
@property(nonatomic, weak) UIButton *add500CoinBtn;
// 100원 코인추가 영역
@property(nonatomic, weak) UIView *input100CoinArea;
@property(nonatomic, weak) UILabel *title100CoinLb;
@property(nonatomic, weak) UIButton *add100CoinBtn;
// 돈 컨트롤 영역 (남은돈 표시, 반환버튼)
@property(nonatomic, weak) UIView *moneyControlArea;
@property(nonatomic, weak) UILabel *moneyTitleLb;
@property(nonatomic, weak) UITextField *remainMoneyShowTF;
@property(nonatomic, weak) UIButton *moneyChangeBtn;

// 상태 표시화면
@property(nonatomic, weak) UITextView *displayView;

@property(nonatomic) NSMutableArray *drinkBtnList;
@property(nonatomic) NSArray *drinkName;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.drinkBtnList = [[NSMutableArray alloc]initWithCapacity:4];
//    self.drinkName = [[NSArray alloc] initWithObjects:@"콜라", @"주스", @"초코빵", @"아이스초코", nil];
    self.trayBox = [[TrayBox alloc] init];
    self.casher = [[Casher alloc] init];
    [self createView];
    [self updateLayout];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UI객체 생성
- (void)createView {
    
    
    UIView *menuView = [[UIView alloc] init];
    [menuView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:menuView];
    self.menuView = menuView;
    {
        for (int i = 0; i < maximumDrinkCount; i++) {
            DrinkObject *drinkData = [self.trayBox.drinkKinds objectAtIndex:i];
            CustomButton *drinkBtn = [[CustomButton alloc] init];
            [drinkBtn setBackgroundColor:[UIColor clearColor]];
            drinkBtn.tag = i;
            drinkBtn.delegate = self;
            [drinkBtn setTitle:drinkData.name];
            [drinkBtn setImageWithName:[NSString stringWithFormat:@"drink%d", i+1]];
            [menuView addSubview:drinkBtn];
            
            
            
            [self.drinkBtnList addObject:drinkBtn];
            
        }
        
    }
    
    UIView *input500CoinArea = [[UIView alloc] init];
    [input500CoinArea setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:input500CoinArea];
    self.input500CoinArea = input500CoinArea;
    {
        UILabel *title500CoinLb = [[UILabel alloc] init];
        title500CoinLb.text = @"500원";
        title500CoinLb.textColor = [UIColor blackColor];
        title500CoinLb.textAlignment = NSTextAlignmentRight;
        [input500CoinArea addSubview:title500CoinLb];
        self.title500CoinLb = title500CoinLb;
        
        UIButton *add500CoinBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        add500CoinBtn.tag = 500;
        [add500CoinBtn addTarget:self action:@selector(onTouchupInsideAddCoin:) forControlEvents:UIControlEventTouchUpInside];
        [input500CoinArea addSubview:add500CoinBtn];
        self.add500CoinBtn = add500CoinBtn;
    }
    
    UIView *input100CoinArea = [[UIView alloc] init];
    [input100CoinArea setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:input100CoinArea];
    self.input100CoinArea = input100CoinArea;
    {
        UILabel *title100CoinLb = [[UILabel alloc] init];
        title100CoinLb.text = @"100원";
        title100CoinLb.textColor = [UIColor blackColor];
        title100CoinLb.textAlignment = NSTextAlignmentRight;
        [input100CoinArea addSubview:title100CoinLb];
        self.title100CoinLb = title100CoinLb;
        
        UIButton *add100CoinBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        add100CoinBtn.tag = 100;
        [add100CoinBtn addTarget:self action:@selector(onTouchupInsideAddCoin:) forControlEvents:UIControlEventTouchUpInside];
        [input100CoinArea addSubview:add100CoinBtn];
        self.add100CoinBtn = add100CoinBtn;
    }
    
    UIView *moneyControlArea = [[UIView alloc] init];
    [moneyControlArea setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:moneyControlArea];
    self.moneyControlArea = moneyControlArea;
    {
        UILabel *moneyTitleLb = [[UILabel alloc] init];
        moneyTitleLb.text = @"Money : ";
        moneyTitleLb.textColor = [UIColor blackColor];
        moneyTitleLb.textAlignment = NSTextAlignmentRight;
        [moneyControlArea addSubview:moneyTitleLb];
        self.moneyTitleLb = moneyTitleLb;
        
        UITextField *remainMoneyShowTF = [[UITextField alloc] init];
        remainMoneyShowTF.userInteractionEnabled = NO;
        remainMoneyShowTF.borderStyle = UITextBorderStyleLine;
        remainMoneyShowTF.textAlignment = NSTextAlignmentCenter;
        [moneyControlArea addSubview:remainMoneyShowTF];
        self.remainMoneyShowTF = remainMoneyShowTF;
        
        UIButton *moneyChangeBtn = [[UIButton alloc] init];
        [moneyChangeBtn setTitle:@"반환" forState:UIControlStateNormal];
        [moneyChangeBtn addTarget:self action:@selector(onTouchupInsideMoneyChangeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [moneyChangeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [moneyChangeBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [moneyControlArea addSubview:moneyChangeBtn];
        self.moneyChangeBtn = moneyChangeBtn;

    }
    
    UITextView *displayView = [[UITextView alloc] init];
    [displayView setBackgroundColor:[UIColor grayColor]];
    [displayView setTextColor:[UIColor whiteColor]];
    displayView.editable = NO;
    [self.view addSubview:displayView];
    self.displayView = displayView;
    
    
    
}

// UI 레이아웃 수정
- (void)updateLayout {
    
    const CGFloat SIDEMARGIN = 30.f;
    NSInteger offsetY = 20;
    
    [self.menuView setFrame:CGRectMake(SIDEMARGIN, offsetY, self.view.frame.size.width - SIDEMARGIN*2, 370)];
    offsetY += self.menuView.frame.size.height + 10;
    {
        
        CGSize drinkBtnSize = CGSizeMake(140, 175);
        for (int i = 0; i < self.drinkBtnList.count; i++) {
            // 좌표
            NSInteger row = i / 2;
            NSInteger col = i % 2;
            CustomButton *drinkBtn = self.drinkBtnList[i];
            
            [drinkBtn setFrame:CGRectMake(10 + (col*drinkBtnSize.width) + (col*20), row*drinkBtnSize.height + (row*20), drinkBtnSize.width, drinkBtnSize.height)];
            [drinkBtn updateLayout];
        }
        
    }
    
    [self.input500CoinArea setFrame:CGRectMake(SIDEMARGIN, offsetY, self.view.frame.size.width - SIDEMARGIN*2, 30)];
    
    offsetY += self.input500CoinArea.frame.size.height;
    {
        [self.title500CoinLb setFrame:CGRectMake(0, 0, 265, self.input500CoinArea.frame.size.height)];
        [self.add500CoinBtn setFrame:CGRectMake(270, 0, 30, 30)];
    }
    
    [self.input100CoinArea setFrame:CGRectMake(SIDEMARGIN, offsetY, self.view.frame.size.width - SIDEMARGIN*2, 30)];
    offsetY += self.input100CoinArea.frame.size.height + 10;
    {
        [self.title100CoinLb setFrame:CGRectMake(0, 0, 265, self.input100CoinArea.frame.size.height)];
        [self.add100CoinBtn setFrame:CGRectMake(270, 0, 30, 30)];
    }
    
    [self.moneyControlArea setFrame:CGRectMake(SIDEMARGIN, offsetY, self.view.frame.size.width - SIDEMARGIN*2, 30)];
    offsetY += self.moneyControlArea.frame.size.height + 10;
    {
        [self.moneyTitleLb setFrame:CGRectMake(0, 0, 61, 30)];
        [self.remainMoneyShowTF setFrame:CGRectMake(63, 0, 200, 30)];
        [self.moneyChangeBtn setFrame:CGRectMake(270, 0, 35, 30)];
    }
    
    [self.displayView setFrame:CGRectMake(SIDEMARGIN, offsetY, self.view.frame.size.width - SIDEMARGIN*2, 145)];
    offsetY += self.displayView.frame.size.height;
    
    {
        
        
    }
    
}

- (void)onTouchupInsideAddCoin:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    
    if(tag == 500) {
        [self.casher addCoin500];
    
    }
    else if(tag == 100) {
        
        [self.casher addCoin100];
    }
    else {
        NSLog(@"tag값이 잘못되었습니다.");
    }
    
//    self.displayView.text = [self.displayView.text stringByAppendingString:[NSString stringWithFormat:@"%zd원이 추가되었습니다.\n", tag]];
    
    self.remainMoneyShowTF.text = [NSString stringWithFormat:@"%zd", self.casher.inputMoney];
    
}

- (void)onTouchupInsideMoneyChangeBtn:(UIButton *)sender {
    
    NSDictionary *dic = [self.casher changeMoney];
    
    NSNumber *coin100 = [dic objectForKey:@"100"];
    NSNumber *coin500 = [dic objectForKey:@"500"];

    
    NSInteger changeMoney = coin100.integerValue * 100 + coin500.integerValue * 500;
    
    if(changeMoney == 0) {
        self.displayView.text = [self.displayView.text stringByAppendingString:@"거스름돈이 없습니다.\n"];
    }
    else {
       self.displayView.text = [self.displayView.text stringByAppendingString:[NSString stringWithFormat:@"거스름돈은 : %zd원입니다. (500원 : %@개, 100원 : %@개)\n",changeMoney, coin500, coin100]];
    }
    
    
    
    
    self.remainMoneyShowTF.text = @"0";

}

- (void)didSelectCustomButton:(CustomButton *)customBtn {
    
    
    DrinkObject *drinkObj = [self.trayBox.drinkKinds objectAtIndex:customBtn.tag];
    
    if([self.casher buyDrink:drinkObj]) {
        
        NSString *successMsg = [NSString stringWithFormat:@"%@ 1개가 나왔습니다.\n", drinkObj.name];
        [self.displayView setText:[self.displayView.text stringByAppendingString:successMsg]];
        [self.remainMoneyShowTF setText:[NSString stringWithFormat:@"%zd", self.casher.inputMoney]];
        
    }
    else {
        [self.displayView setText:[self.displayView.text stringByAppendingString:@"잔액이 부족합니다.\n"]];
    }
}

@end
