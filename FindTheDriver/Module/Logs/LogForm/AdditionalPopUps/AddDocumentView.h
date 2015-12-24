//
//  AddDocumentView.h
//  FindTheDriver
//
//  Created by mac on 24/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddDocumentViewProtocol <NSObject>
-(void)selectedDocumentType:(NSString*)docType;
@end
@interface AddDocumentView : UIView{
    NSArray *textDataArray;
    NSArray *imageDataArray;
}
@property(nonatomic,weak)id<AddDocumentViewProtocol> delegate;
-(id)initWithFrame:(CGRect)frame;
@end
