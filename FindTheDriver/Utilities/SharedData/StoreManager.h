//
//  StoreManager.h
//  MedicineXpress
//
//  Created by Shuchi on 04/06/15.
//  Copyright (c) 2015 Neevtech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreManager : NSObject

@property(nonatomic,strong)NSArray *regVehiclesArray;

+ (StoreManager *)sharedStoreManager;

//Event Table
-(void)writeEventTable:(NSDate*)time endTime:(NSDate*)endtime eventType:(NSString*)eventtype place:(NSString*)place notes:(NSString*)notes latitude:(NSString*)latitude longitude:(NSString*)longitude;
-(NSMutableArray*)getEventTableData;
-(NSMutableArray*)getEventTableLastFourteenDaysData;

@end
