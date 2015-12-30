//
//  StoreManager.m
//
//

#import "StoreManager.h"
#import "FMDB.h"

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

-(FMDatabase*)database{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"database.sqlite"];
   return [FMDatabase databaseWithPath:path];
}

#pragma mark:- Event Table

-(void)writeEventTable:(NSDate*)time endTime:(NSDate*)endtime eventType:(NSString*)eventtype place:(NSString*)place notes:(NSString*)notes latitude:(NSString*)latitude longitude:(NSString*)longitude{
    FMDatabase *database =[self database];
    [database open];
    [database executeUpdate:EVENT_TABLE];
    [database executeUpdate:EVENT_TABLE_INSERT,time,endtime,eventtype,place,notes,latitude,longitude];
    [database close];
}

-(NSMutableArray*)getEventTableData{
    NSMutableArray *eventDataArray=[[NSMutableArray alloc]init];
    FMDatabase *database =[self database];
    [database open];
    FMResultSet *results = [database executeQuery:EVENT_TABLE_SELECT];
    while ([results next])
    {
        NSMutableDictionary *eventDict=[[NSMutableDictionary alloc]init];
        [eventDict setValue:[results dateForColumn:event_Table_time] forKey:event_Table_time];
        [eventDict setValue:[results dateForColumn:event_Table_endtime] forKey:event_Table_endtime];
        [eventDict setValue:[results stringForColumn:event_Table_eventtype] forKey:event_Table_eventtype];
        [eventDict setValue:[results stringForColumn:event_Table_place] forKey:event_Table_place];
        [eventDict setValue:[results stringForColumn:event_Table_notes] forKey:event_Table_notes];
        [eventDict setValue:[results stringForColumn:event_Table_latitude] forKey:event_Table_latitude];
        [eventDict setValue:[results stringForColumn:event_Table_longitude] forKey:event_Table_longitude];
        [eventDataArray addObject:eventDict];
    }
    [database close];
    return eventDataArray;
}

-(NSMutableArray*)getEventTableLastFourteenDaysData{
    NSMutableArray *eventDataArray=[[NSMutableArray alloc]init];
    FMDatabase *database =[self database];
    [database open];
    FMResultSet *results = [database executeQuery:EVENT_TABLE_FOURTEENDAYS];
    while ([results next])
    {
        NSMutableDictionary *eventDict=[[NSMutableDictionary alloc]init];
        [eventDict setValue:[results dateForColumn:event_Table_time] forKey:event_Table_time];
        [eventDict setValue:[results dateForColumn:event_Table_endtime] forKey:event_Table_endtime];
        [eventDict setValue:[results stringForColumn:event_Table_eventtype] forKey:event_Table_eventtype];
        [eventDict setValue:[results stringForColumn:event_Table_place] forKey:event_Table_place];
        [eventDict setValue:[results stringForColumn:event_Table_notes] forKey:event_Table_notes];
        [eventDict setValue:[results stringForColumn:event_Table_latitude] forKey:event_Table_latitude];
        [eventDict setValue:[results stringForColumn:event_Table_longitude] forKey:event_Table_longitude];
        [eventDataArray addObject:eventDict];
    }
    [database close];
    return eventDataArray;
}

@end
