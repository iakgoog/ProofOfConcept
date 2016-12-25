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

static NSString *CellIdentifier = @"CellIdentifier";

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    UINavigationBar *_navbar;
    NSArray *_itemsArray;
    UIImage *_defaultImage;
    NSMutableSet *_deadLinks;
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
    NSString *jsonString = @"{\"title\":\"About Canada\",\"rows\":[{\"title\":\"Beavers\",\"description\":\"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony\",\"imageHref\":\"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg\"},{\"title\":\"Flag\",\"description\":null,\"imageHref\":\"http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png\"},{\"title\":\"Transportation\",\"description\":\"It is a well known fact that polar bears are the main mode of transportation in Canada. They consume far less gas and have the added benefit of being difficult to steal.\",\"imageHref\":\"http://1.bp.blogspot.com/_VZVOmYVm68Q/SMkzZzkGXKI/AAAAAAAAADQ/U89miaCkcyo/s400/the_golden_compass_still.jpg\"},{\"title\":\"Hockey Night in Canada\",\"description\":\"These Saturday night CBC broadcasts originally aired on radio in 1931. In 1952 they debuted on television and continue to unite (and divide) the nation each week.\",\"imageHref\":\"http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg\"},{\"title\":\"Eh\",\"description\":\"A chiefly Canadian interrogative utterance, usually expressing surprise or doubt or seeking confirmation.\",\"imageHref\":null},{\"title\":\"Housing\",\"description\":\"Warmer than you might think.\",\"imageHref\":\"http://icons.iconarchive.com/icons/iconshock/alaska/256/Igloo-icon.png\"},{\"title\":\"Public Shame\",\"description\":\" Sadly it's true.\",\"imageHref\":\"http://static.guim.co.uk/sys-images/Music/Pix/site_furniture/2007/04/19/avril_lavigne.jpg\"},{\"title\":null,\"description\":null,\"imageHref\":null},{\"title\":\"Space Program\",\"description\":\"Canada hopes to soon launch a man to the moon.\",\"imageHref\":\"http://files.turbosquid.com/Preview/Content_2009_07_14__10_25_15/trebucheta.jpgdf3f3bf4-935d-40ff-84b2-6ce718a327a9Larger.jpg\"},{\"title\":\"Meese\",\"description\":\"A moose is a common sight in Canada. Tall and majestic, they represent many of the values which Canadians imagine that they possess. They grow up to 2.7 metres long and can weigh over 700 kg. They swim at 10 km/h. Moose antlers weigh roughly 20 kg. The plural of moose is actually 'meese', despite what most dictionaries, encyclopedias, and experts will tell you.\",\"imageHref\":\"http://caroldeckerwildlifeartstudio.net/wp-content/uploads/2011/04/IMG_2418%20majestic%20moose%201%20copy%20(Small)-96x96.jpg\"},{\"title\":\"Geography\",\"description\":\"It's really big.\",\"imageHref\":null},{\"title\":\"Kittens...\",\"description\":\"Éare illegal. Cats are fine.\",\"imageHref\":\"http://www.donegalhimalayans.com/images/That%20fish%20was%20this%20big.jpg\"},{\"title\":\"Mounties\",\"description\":\"They are the law. They are also Canada's foreign espionage service. Subtle.\",\"imageHref\":\"http://3.bp.blogspot.com/__mokxbTmuJM/RnWuJ6cE9cI/AAAAAAAAATw/6z3m3w9JDiU/s400/019843_31.jpg\"},{\"title\":\"Language\",\"description\":\"Nous parlons tous les langues importants.\",\"imageHref\":null}]}";
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    _itemsArray = [self itemsFromJSON:parsedObject];
    [_navbar.topItem setTitle:[self titleFromJSON:parsedObject]];
    
    [_tableView reloadData];
}

- (NSArray *)itemsFromJSON:(NSDictionary *)parsedObject {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    NSArray *rows = [parsedObject valueForKey:@"rows"];
    
    for (NSDictionary *itemDic in rows) {
        Item *item = [[Item alloc] init];
        
        BOOL isTitleNull = [itemDic[@"title"] isKindOfClass:[NSNull class]];
        BOOL isDescriptionNull = [itemDic[@"description"] isKindOfClass:[NSNull class]];
        BOOL isImageNull = [itemDic[@"imageHref"] isKindOfClass:[NSNull class]];
        
        // If all fields are NULL, the item will not be added
        if (isTitleNull && isDescriptionNull && isImageNull) {
            continue;
        }
        
        NSString *titleText = (isTitleNull) ? @"" : itemDic[@"title"];
        NSString *descriptionText = (isDescriptionNull) ? @"" : itemDic[@"description"];
        NSString *imageUrl = (isImageNull) ? @"" : itemDic[@"imageHref"];
        
        [item setTitle:titleText];
        [item setDescriptionText:descriptionText];
        [item setImageUrl:imageUrl];
        
        [items addObject:item];
    }
    
    return items;
}

- (NSString *)titleFromJSON:(NSDictionary *)parsedObject {
    NSString *title = [parsedObject valueForKey:@"title"];
    return title;
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
