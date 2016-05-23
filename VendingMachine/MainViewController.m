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
@property(nonatomic, weak) IBOutlet UIView *menuView;
// 500원 코인추가 영역
@property(nonatomic, weak) IBOutlet UIView *input500CoinArea;
@property(nonatomic, weak) UILabel *title500CoinLabel;
@property(nonatomic, weak) UIButton *add500CoinButton;
// 100원 코인추가 영역
@property(nonatomic, weak) IBOutlet UIView *input100CoinArea;
@property(nonatomic, weak) UILabel *title100CoinLabel;
@property(nonatomic, weak) UIButton *add100CoinButton;
// 돈 컨트롤 영역 (남은돈 표시, 반환버튼)
@property(nonatomic, weak) IBOutlet UIView *moneyControlArea;
@property(nonatomic, weak) UILabel *moneyTitleLabel;
@property(nonatomic, weak) UITextField *remainMoneyShowTextField;
@property(nonatomic, weak) UIButton *moneyChangeButton;

// 상태 표시화면
@property(nonatomic, weak) UITextView *displayView;

@property(nonatomic) NSMutableArray *drinkButtonList;
@property(nonatomic) NSArray *drinkName;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.drinkButtonList = [[NSMutableArray alloc]initWithCapacity:4];
    //    self.drinkName = [[NSArray alloc] initWithObjects:@"콜라", @"주스", @"초코빵", @"아이스초코", nil];
    self.trayBox = [[TrayBox alloc] init];
    self.casher = [[Casher alloc] init];
    [self createView];
//    [self updateLayout];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// UI객체 생성
- (void)createView {
    
    
//    UIView *menuView = [[UIView alloc] init];
//    [menuView setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:menuView];
//    self.menuView = menuView;
    {
        for (int i = 0; i < maximumDrinkCount; i++) {
            DrinkObject *drinkData = [self.trayBox.drinkKinds objectAtIndex:i];
            CustomButton *drinkBtn = [[CustomButton alloc] init];
            [drinkBtn setBackgroundColor:[UIColor clearColor]];
            drinkBtn.tag = i;
            drinkBtn.delegate = self;
            [drinkBtn setTitle:drinkData.name];
            [drinkBtn setImageWithName:[NSString stringWithFormat:@"drink%d", i+1]];
            [self.menuView addSubview:drinkBtn];
            [self.drinkButtonList addObject:drinkBtn];
            
        }
        
    }
    
//    UIView *input500CoinArea = [[UIView alloc] init];
//    [input500CoinArea setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:input500CoinArea];
//    self.input500CoinArea = input500CoinArea;
    {
        UILabel *title500CoinLabel = [[UILabel alloc] init];
        title500CoinLabel.text = @"500원";
        title500CoinLabel.textColor = [UIColor blackColor];
        title500CoinLabel.textAlignment = NSTextAlignmentRight;
        [self.input500CoinArea addSubview: title500CoinLabel];
        self.title500CoinLabel = title500CoinLabel;
        
        UIButton *add500CoinButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        add500CoinButton.tag = 500;
        [add500CoinButton addTarget:self action:@selector(onTouchupInsideAddCoin:) forControlEvents:UIControlEventTouchUpInside];
        [self.input500CoinArea addSubview:add500CoinButton];
        self.add500CoinButton = add500CoinButton;
    }
    
    //    UIView *input100CoinArea = [[UIView alloc] init];
    //    [input100CoinArea setBackgroundColor:[UIColor clearColor]];
    //    [self.view addSubview:input100CoinArea];
    //    self.input100CoinArea = input100CoinArea;
    {
        UILabel *title100CoinLabel = [[UILabel alloc] init];
        title100CoinLabel.text = @"100원";
        title100CoinLabel.textColor = [UIColor blackColor];
        title100CoinLabel.textAlignment = NSTextAlignmentRight;
        [self.input100CoinArea addSubview:title100CoinLabel];
        self.title100CoinLabel = title100CoinLabel;
        
        UIButton *add100CoinButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        add100CoinButton.tag = 100;
        [add100CoinButton addTarget:self action:@selector(onTouchupInsideAddCoin:) forControlEvents:UIControlEventTouchUpInside];
        [self.input100CoinArea addSubview:add100CoinButton];
        self.add100CoinButton = add100CoinButton;
    }
    
//    UIView *moneyControlArea = [[UIView alloc] init];
//    [moneyControlArea setBackgroundColor:[UIColor clearColor]];
//    [self.view addSubview:moneyControlArea];
//    self.moneyControlArea = moneyControlArea;
    {
        UILabel *moneyTitleLabel = [[UILabel alloc] init];
        moneyTitleLabel.text = @"Money : ";
        moneyTitleLabel.textColor = [UIColor blackColor];
        moneyTitleLabel.textAlignment = NSTextAlignmentRight;
        [self.moneyControlArea addSubview:moneyTitleLabel];
        self.moneyTitleLabel = moneyTitleLabel;
        
        UITextField *remainMoneyShowTextField = [[UITextField alloc] init];
        remainMoneyShowTextField.userInteractionEnabled = NO;
        remainMoneyShowTextField.borderStyle = UITextBorderStyleLine;
        remainMoneyShowTextField.textAlignment = NSTextAlignmentCenter;
        [self.moneyControlArea addSubview:remainMoneyShowTextField];
        self.remainMoneyShowTextField = remainMoneyShowTextField;
        
        UIButton *moneyChangeButton = [[UIButton alloc] init];
        [moneyChangeButton setTitle:@"반환" forState:UIControlStateNormal];
        [moneyChangeButton addTarget:self action:@selector(onTouchupInsideMoneyChangeButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [moneyChangeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [moneyChangeButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        [self.moneyControlArea addSubview:moneyChangeButton];
        self.moneyChangeButton = moneyChangeButton;
        
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
        
        CGSize drinkButtonSize = CGSizeMake(140, 175);
        for (int i = 0; i < self.drinkButtonList.count; i++) {
            // 좌표
            NSInteger row = i / 2;
            NSInteger col = i % 2;
            CustomButton *drinkButton = self.drinkButtonList[i];
            
            [drinkButton setFrame:CGRectMake(10 + (col*drinkButtonSize.width) + (col*20), row*drinkButtonSize.height + (row*20), drinkButtonSize.width, drinkButtonSize.height)];
            [drinkButton updateLayout];
        }
        
    }
    
    [self.input500CoinArea setFrame:CGRectMake(SIDEMARGIN, offsetY, self.view.frame.size.width - SIDEMARGIN*2, 30)];
    
    offsetY += self.input500CoinArea.frame.size.height;
    {
        [self.title500CoinLabel setFrame:CGRectMake(0, 0, 265, self.input500CoinArea.frame.size.height)];
        [self.add500CoinButton setFrame:CGRectMake(270, 0, 30, 30)];
    }
    
    [self.input100CoinArea setFrame:CGRectMake(SIDEMARGIN, offsetY, self.view.frame.size.width - SIDEMARGIN*2, 30)];
    offsetY += self.input100CoinArea.frame.size.height + 10;
    {
        [self.title100CoinLabel setFrame:CGRectMake(0, 0, 265, self.input100CoinArea.frame.size.height)];
        [self.add100CoinButton setFrame:CGRectMake(270, 0, 30, 30)];
    }
    
    [self.moneyControlArea setFrame:CGRectMake(SIDEMARGIN, offsetY, self.view.frame.size.width - SIDEMARGIN*2, 30)];
    offsetY += self.moneyControlArea.frame.size.height + 10;
    {
        [self.moneyTitleLabel setFrame:CGRectMake(0, 0, 61, 30)];
        [self.remainMoneyShowTextField setFrame:CGRectMake(63, 0, 200, 30)];
        [self.moneyChangeButton setFrame:CGRectMake(270, 0, 35, 30)];
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
    
    self.remainMoneyShowTextField.text = [NSString stringWithFormat:@"%zd", self.casher.inputMoney];
    
}

- (void)onTouchupInsideMoneyChangeButton:(UIButton *)sender {
    
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
    
    
    
    
    self.remainMoneyShowTextField.text = @"0";
    
}

- (void)didSelectCustomButton:(CustomButton *)customBtn {
    
    
    DrinkObject *drinkObject = [self.trayBox.drinkKinds objectAtIndex:customBtn.tag];
    
    if([self.casher buyDrink:drinkObject]) {
        
        NSString *successMsg = [NSString stringWithFormat:@"%@ 1개가 나왔습니다.\n", drinkObject.name];
        [self.displayView setText:[self.displayView.text stringByAppendingString:successMsg]];
        [self.remainMoneyShowTextField setText:[NSString stringWithFormat:@"%zd", self.casher.inputMoney]];
        
    }
    else {
        [self.displayView setText:[self.displayView.text stringByAppendingString:@"잔액이 부족합니다.\n"]];
    }
}

@end
