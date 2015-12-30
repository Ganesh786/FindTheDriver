//
//  DeleteDocumentView.h
//  FindTheDriver
//
//  Created by mac on 24/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeleteDocumentViewProtocol <NSObject>
-(void)deleteDocumentConfirmed;
-(void)deleteDocumentCancelled;
@end
@interface DeleteDocumentView : UIView
@property(nonatomic,weak)id<DeleteDocumentViewProtocol> delegate;
-(id)initWithFrame:(CGRect)frame;
@end
