//
//  Casher.h
//  VendingMachine
//
//  Created by LEEJIHO on 2016. 5. 13..
//  Copyright © 2016년 LEEJIHO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrinkObject.h"

@interface Casher : NSObject

// 동전 추가 메소드
- (void)addCoin500;
- (void)addCoin100;
- (NSInteger)inputMoney;

//@property (nonatomic, readonly) NSInteger inputMoney;

// 음료수사는 메소드
- (BOOL)buyDrink:(DrinkObject *) drink;

// 돈 거슬러줄(동전 List)
// {@"500" : count, @"100" : count}
- (NSDictionary *)changeMoney;

@end
