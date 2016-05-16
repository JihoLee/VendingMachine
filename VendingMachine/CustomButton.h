//
//  CustomButton.h
//  VendingMachine
//
//  Created by LEEJIHO on 2016. 5. 13..
//  Copyright © 2016년 LEEJIHO. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomButtonDelegate;

@interface CustomButton : UIView

@property (nonatomic, weak, nullable) id <CustomButtonDelegate> delegate;

- (void)updateLayout;
- (void)setTitle:(nullable NSString *)title;
- (void)setImageWithName:(nullable NSString *)imageName;

@end

@protocol CustomButtonDelegate <NSObject>

- (void)didSelectCustomButton:(nullable CustomButton *)customBtn;

@end
