//
//  StoreManager.m
//
//

#import "StoreManager.h"

@implementation StoreManager

- (id)init {
    if (self = [super init]) {
       // Allocate array
    }
    return self;
}

+(StoreManager*) sharedStoreManager{
    static StoreManager *sharedInstance=nil;
    static dispatch_once_t  oncePredecate;
    dispatch_once(&oncePredecate,^{
        sharedInstance=[[StoreManager alloc] init];
        
    });
    return sharedInstance;
}





@end
