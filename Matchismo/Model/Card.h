//
//  Card.h
//  Matchismo
//
//  Created by Sesha Sai Bhargav Bandla on 31/01/15.
//  Copyright (c) 2015 nivansys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property(strong,nonatomic)NSString *contents;
@property(nonatomic,getter=isChosen) BOOL chosen;
@property(nonatomic,getter=isMatched) BOOL matched;
-(int)match:(NSArray *)othercards;
@end
