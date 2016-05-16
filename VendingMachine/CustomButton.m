//
//  CustomButton.m
//  VendingMachine
//
//  Created by LEEJIHO on 2016. 5. 13..
//  Copyright © 2016년 LEEJIHO. All rights reserved.
//

#import "CustomButton.h"

@interface CustomButton()

@property(nonatomic, weak) UIImageView *drinkImg;
@property(nonatomic, weak) UILabel *titleLb;
@property(nonatomic, weak) UIButton *actionBtn;

@end

@implementation CustomButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    
    {
        UIImageView *drinkImg = [[UIImageView alloc] init];
        [self addSubview:drinkImg];
        self.drinkImg = drinkImg;
    }
    
    {
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.textColor = [UIColor blackColor];
    
        titleLb.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleLb];
        self.titleLb = titleLb;
    }
    
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionBtn addTarget:self action:@selector(onTouchUpInsideActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:actionBtn];
    self.actionBtn = actionBtn;
    
}

- (void)updateLayout {
    [self.drinkImg setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height -22)];
    [self.titleLb setFrame:CGRectMake(0, self.frame.size.height-22, self.frame.size.width, 22)];
    [self.actionBtn setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    
}

- (void)setTitle:(NSString *)title {
    
    [self.titleLb setText:title];
    
}

- (void)setImageWithName:(NSString *)imageName {
    
    [self.drinkImg setImage:[UIImage imageNamed:imageName]];
}

- (void)onTouchUpInsideActionBtn:(UIButton *)sender {
    
    if([self.delegate respondsToSelector:@selector(didSelectCustomButton:)]) {
        
        [self.delegate didSelectCustomButton:self];
    }
    
}

@end
