//
//  TrayBox.m
//  VendingMachine
//
//  Created by LEEJIHO on 2016. 5. 13..
//  Copyright © 2016년 LEEJIHO. All rights reserved.
//

#import "TrayBox.h"



@interface TrayBox()

@property (nonatomic, nullable) NSArray *nameList;
@property (nonatomic, nullable) NSArray *costList;
@property (nonatomic) NSArray *drinkKinds;


@end

@implementation TrayBox
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nameList = @[@"콜라", @"주스", @"초코빵", @"아이스초코"];
        self.costList = @[@1000, @2500, @1500, @4500];
        
        [self createTray];
    }
    return self;
}


- (void) createTray {
    
    NSMutableArray *drinkList = [[NSMutableArray alloc] init];
    for (int i = 0; i < maximumDrinkCount; i++) {
        NSString *drinkName = _nameList[i];
        NSInteger drinkCost = ((NSNumber *) _costList[i]).integerValue;
        DrinkObject *drink = [[DrinkObject alloc] initWithName:drinkName cost:drinkCost];
        [drinkList addObject:drink];
    }
    
    self.drinkKinds = [[NSArray alloc] initWithArray:drinkList];
    
}
@end
