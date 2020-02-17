//
//  ViewController.h
//  CSInteractiveHeaders
//
//  Created by Dana Buehre on 2/17/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

