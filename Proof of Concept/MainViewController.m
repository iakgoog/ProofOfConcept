//
//  MainViewController.m
//  Proof of Concept
//
//  Created by Sutthinart Khunvadhana on 26/12/16.
//  Copyright © 2016 Sutthinart Khunvadhana. All rights reserved.
//

#import "MainViewController.h"
#import "TableViewCell.h"
#import "Item.h"
#import "ItemManager.h"
#import "ItemCommunicator.h"

static NSString *CellIdentifier = @"CellIdentifier";
static NSString *const FeedURLString = @"https://dl.dropboxusercontent.com/u/746330/facts.json";

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource, ItemManagerDelegate> {
    UITableView *_tableView;
    UINavigationBar *_navbar;
    NSArray *_itemsArray;
    UIImage *_defaultImage;
    NSMutableSet *_deadLinks;
    ItemManager *_manager;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _defaultImage = [UIImage imageNamed:@"CanadaFlagBW.jpg"];
    _deadLinks = [NSMutableSet set];
    
    _tableView = [self makeTableView];
    [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [self.view addSubview:_tableView];
    
    _navbar = [self makeNavigationBar];
    [_navbar.topItem setTitle:@"Title"];
    [self.view addSubview:_navbar];
    
    _manager = [[ItemManager alloc] init];
    _manager.communicator = [[ItemCommunicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    
    [self renderTable];
    
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

- (void)renderTable {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_manager fetchItems:FeedURLString];
}

#pragma mark - ItemManagerDelegate

- (void)didReceiveItems:(NSArray *)items title:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        _itemsArray = items;
        [_navbar.topItem setTitle:title];
        NSLog(@"_itemsArray count => %lu", (unsigned long)[_itemsArray count]);
        [_tableView reloadData];
    });
}

- (void)fetchItemsFailedWithError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"Error %@; %@", error, [error localizedDescription]);
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (_itemsArray.count > 0) {
        Item *item = _itemsArray[indexPath.row];
        
        cell.titleLabel.text = item.title;
        cell.bodyLabel.text = item.descriptionText;
        
        if (item.image) {
            cell.iconImage.image = item.image;
        } else {
            cell.iconImage.image = _defaultImage;
        }
        
        // start downloading image
        if (item.imageUrl.length > 0 && item.image == nil) {
            if (![_deadLinks containsObject:item.imageUrl]) {
                NSURL *imageUrl = [NSURL URLWithString:item.imageUrl];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSURLSessionDownloadTask *downloadImageTask = [[NSURLSession sharedSession] downloadTaskWithURL:imageUrl completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        if (error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                cell.iconImage.image = _defaultImage;
                            });
                        } else {
                            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                CGImageRef cgref = [image CGImage];
                                CIImage *cim = [image CIImage];
                                
                                if (cim == nil && cgref == NULL) {
                                    NSLog(@"no underlying data of %@", imageUrl);
                                    [_deadLinks addObject:item.imageUrl];
                                } else {
                                    item.image = image;
                                    cell.iconImage.image = image;
                                }
                            });
                        }
                        
                    }];
                    
                    [downloadImageTask resume];
                    
                });
            }
        }
    }
    
    // Ensure that fresh created cell will be added constraints
    [cell setNeedsUpdateConstraints];
    
    return cell;
}

@end
