//
//  MainViewController.m
//  Proof of Concept
//
//  Created by Sutthinart Khunvadhana on 26/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import "MainViewController.h"

static NSString *CellIdentifier = @"CellIdentifier";

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    UINavigationBar *_navbar;
    NSArray *_itemsArray;
    UIImage *_defaultImage;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [self makeTableView];
    [self.view addSubview:_tableView];
    
    _navbar = [self makeNavigationBar];
    [_navbar.topItem setTitle:@"Title"];
    [self.view addSubview:_navbar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)makeTableView
{
    CGFloat x = 0;
    CGFloat y = 64;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height - 64;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 80;
    
    tableView.sectionFooterHeight = 22;
    tableView.sectionHeaderHeight = 22;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

- (UINavigationBar *)makeNavigationBar {
    CGFloat x = 0;
    CGFloat y = 20;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 44;
    UINavigationBar *navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(x, y, width, height)];
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    [navbar pushNavigationItem:navItem animated:NO];
    
    return navbar;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return cell;
}

@end
