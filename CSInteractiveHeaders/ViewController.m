//
//  ViewController.m
//  CSInteractiveHeaders
//
//  Created by Dana Buehre on 2/17/20.
//  Copyright © 2020 CreatureCoding. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+InteractiveHeader.h"
#import "UINavigationBar+InteractiveHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.tableView addHeaderWithImage:[UIImage imageNamed:@"banner.jpg"] height:300];
    [self.tableView.interactiveHeader setUseAlphaFade:YES];
    [self.tableView.interactiveHeader setLabelOffset:22];
    [self.tableView.interactiveHeader.titleLabel setText:@"CSInteractiveHeaders"];
    [self.tableView.interactiveHeader.subtitleLabel setText:@"By: CreatureSurvive"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"View Source" style:UIBarButtonItemStyleDone target:self action:@selector(viewSource)];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setScrollView:self.tableView];
    [self.navigationController.navigationBar setScrollTintColor:UIColor.darkTextColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Section %ld Row %ld", (long)indexPath.section, (long)indexPath.row];
    cell.detailTextLabel.text = @"sub diddley sublabel";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)viewSource {
    NSURL *source = [NSURL URLWithString:@"https://github.com/CreatureSurvive/CSInteractiveHeaders"];
    [[UIApplication sharedApplication] openURL:source options:@{} completionHandler:nil];
}

@end
