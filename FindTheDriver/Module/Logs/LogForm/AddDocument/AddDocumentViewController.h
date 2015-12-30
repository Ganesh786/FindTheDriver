//
//  AddDocumentViewController.h
//  FindTheDriver
//
//  Created by mac on 26/12/15.
//  Copyright © 2015 Endeavour. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddDocumentViewController : UIViewController
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingTableView *tableView;
@property(nonatomic,strong)NSString *docTypeString;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtnOutlet;
- (IBAction)cancelBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *saveBtnOutlet;
- (IBAction)saveBtnAction:(id)sender;
@end
