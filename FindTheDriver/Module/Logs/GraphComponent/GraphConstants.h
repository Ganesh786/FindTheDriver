//
//  GraphConstants.h
//  FindTheDriver
//
//  Created by mac on 19/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#ifndef GraphConstants_h
#define GraphConstants_h

#define GRID_TOPVIEW_HT 20
#define GRID_LEFTVIEW_WT 30
#define GRID_RIGHTVIEW_WT 30

#define GRID_BOX_HT 25
#define GRID_BOX_WT (([[UIScreen mainScreen]bounds].size.width-(GRID_LEFTVIEW_WT+GRID_RIGHTVIEW_WT))/24)

#define GRAPH_VIEW_HT (GRID_BOX_HT*4+GRID_TOPVIEW_HT)

#endif /* GraphConstants_h */
