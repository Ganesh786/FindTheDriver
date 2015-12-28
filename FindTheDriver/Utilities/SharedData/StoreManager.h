//
//  StoreManager.h
//  MedicineXpress
//
//  Created by Shuchi on 04/06/15.
//  Copyright (c) 2015 Neevtech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface StoreManager : NSObject

@property(nonatomic,strong)NSArray *regVehiclesArray;
+ (StoreManager *)sharedStoreManager;

@end
