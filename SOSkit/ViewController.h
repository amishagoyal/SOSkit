//
//  ViewController.h
//  SOSkit
//
//  Created by Amisha Goyal on 9/23/14.
//  Copyright (c) 2014 Salesforce. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *resultTableView;
@end
