//
//  SQLiteQueryClass.h
//  FindTheDriver
//
//  Created by mac on 28/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#ifndef SQLiteQueryClass_h
#define SQLiteQueryClass_h

// Event Table
#define EVENT_TABLE @"create table EventTable(_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,time DATE,endtime DATE,eventtype TEXT,place TEXT,notes TEXT,latitude TEXT,longitude TEXT)"
#define EVENT_TABLE_INSERT @"insert into EventTable (time,endtime,eventtype,place,notes,latitude,longitude) values (?,?,?,?,?,?,?)"
#define EVENT_TABLE_SELECT @"select * from EventTable"
#define EVENT_TABLE_FOURTEENDAYS @"SELECT DISTINCT Date(et.time) as day,UPPER((case cast (strftime('%w', et.time) as integer) when 0 then 'Sunday'  when 1 then 'Monday'  when 2 then 'Tuesday'  when 3 then 'Wednesday'  when 4 then 'Thursday'  when 5 then 'Friday'  else 'Saturday' end) || ' ' || substr ('--JanFebMarAprMayJunJulAugSepOctNovDec', strftime ('%m', et.time) * 3, 3) || ' ' || strftime ('%d', et.time)) as DayName , coalesce((SELECT  SUM((julianday(ett.endtime) - julianday(ett.time)) * 24) from EventTable ett where julianday(ett.time) = julianday(et.time) and (eventtype = 'driving') group by julianday(ett.time))  , 0) as hoursDriven, coalesce((SELECT  SUM((julianday(ett.endtime) - julianday(ett.time)) * 24) from EventTable ett where julianday(ett.time) = julianday(et.time) and (ett.eventtype = 'on_duty' ) group by julianday(ett.time))  , 0) as hoursOnDuty FROM EventTable et order by et.time desc  limit 14"

static NSString *event_Table_time=@"time";
static NSString *event_Table_endtime=@"endtime";
static NSString *event_Table_eventtype=@"eventtype";
static NSString *event_Table_place=@"place";
static NSString *event_Table_notes=@"notes";
static NSString *event_Table_latitude=@"latitude";
static NSString *event_Table_longitude=@"longitude";

#endif /* SQLiteQueryClass_h */
