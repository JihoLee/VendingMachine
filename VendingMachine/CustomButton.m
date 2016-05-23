//
//  CustomButton.m
//  VendingMachine
//
//  Created by LEEJIHO on 2016. 5. 13..
//  Copyright © 2016년 LEEJIHO. All rights reserved.
//

#import "CustomButton.h"

@interface CustomButton()

@property(nonatomic, weak) UIImageView *drinkImage;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UIButton *actionButton;

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
        UIImageView *drinkImage = [[UIImageView alloc] init];
        [self addSubview:drinkImage];
        self.drinkImage = drinkImage;
    }
    
    {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
    
        titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton addTarget:self action:@selector(onTouchUpInsideActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:actionButton];
    self.actionButton = actionButton;
    
}

- (void)updateLayout {
    [self.drinkImage setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height -22)];
    [self.titleLabel setFrame:CGRectMake(0, self.frame.size.height-22, self.frame.size.width, 22)];
    [self.actionButton setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    
}

- (void)setTitle:(NSString *)title {
    
    [self.titleLabel setText:title];
    
}

- (void)setImageWithName:(NSString *)imageName {
    
    [self.drinkImage setImage:[UIImage imageNamed:imageName]];
}

- (void)onTouchUpInsideActionBtn:(UIButton *)sender {
    
    if([self.delegate respondsToSelector:@selector(didSelectCustomButton:)]) {
        
        [self.delegate didSelectCustomButton:self];
    }
    
}

@end
