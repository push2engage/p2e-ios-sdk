//
//  TagViewController.m
//  P2EPush
//
//  Created by Push2Engage on 05/03/16.
//  Copyright © 2016 Push2Engage. All rights reserved.
//

#import "TagViewController.h"
#import <P2EPush/P2E.h>
#import "TagCell.h"

#define SCREENSIZE                              [UIScreen mainScreen].bounds.size
#define Generic                                 @"Generic"

@interface TagViewController ()

@property(nonatomic, strong) NSMutableArray *tagKeyArray;
@property(nonatomic, strong) NSMutableDictionary *tagArrayDictionary;

@end

@implementation TagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TagCell" bundle:nil] forCellReuseIdentifier:@"TagCell"];
    
    _tagKeyArray = [NSMutableArray new];
    _tagArrayDictionary = [NSMutableDictionary new];
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTagButtonTapped)];
    self.navigationItem.rightBarButtonItem = addBtn;    
    
    
    // Uncomment the following line to preserve selection between presentations.
     //self.clearsSelectionOnViewWillAppear = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.navigationItem.title = @"tahs";
    
    //self.navigationItem.hidesBackButton = YES;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self UpdateTableData];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)UpdateTableData {
    _tagKeyArray = [NSMutableArray new];
    _tagArrayDictionary = [NSMutableDictionary new];
    
    NSArray *genericTag = [Push getGenericTags];
    if (genericTag && genericTag.count) {
        [_tagKeyArray addObject:Generic];
        [_tagArrayDictionary setObject:genericTag forKey:Generic];
    }
    NSDictionary *groupTags = [Push getAllTags];
    if (groupTags && groupTags.count) {
        [_tagKeyArray addObjectsFromArray:groupTags.allKeys];
        [_tagArrayDictionary addEntriesFromDictionary:groupTags];
    }
    [self.tableView reloadData];
}

- (void)addTagButtonTapped {
    [self performSegueWithIdentifier:@"addTagController" sender:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //NSArray *genericTag = [Push getGenericTags];
    //NSInteger inte =
    return _tagKeyArray.count;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSArray *genericTag = [Push getGenericTags];
    NSArray *tagArray = [_tagArrayDictionary objectForKey:[_tagKeyArray objectAtIndex:section]];
    if (tagArray) {
        return tagArray.count;
    }
    return 0;
}

///*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSArray *genericTag = [Push getGenericTags];
    NSArray *tagArray = [_tagArrayDictionary objectForKey:[_tagKeyArray objectAtIndex:indexPath.section]];
    TagCell *tagCell = [tableView dequeueReusableCellWithIdentifier:@"TagCell" forIndexPath:indexPath];
    if (tagArray && (tagArray.count > indexPath.row)) {
        tagCell.tagName.text = [tagArray objectAtIndex:indexPath.row];
    }
    else {
        tagCell.tagName.text = @"no name";
    }
    // Configure the cell...
    
    return tagCell;
}
//*/
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *key = [_tagKeyArray objectAtIndex:indexPath.section];
    NSArray *tagArray = [_tagArrayDictionary objectForKey:key];
    if ([key isEqualToString:Generic]) {
        [Push removeTag:[tagArray objectAtIndex:indexPath.row]];
    }
    else {
        [Push removeTag:[tagArray objectAtIndex:indexPath.row] inGroup:key];
    }
    
    [self UpdateTableData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40.0)];
    view.backgroundColor = [UIColor lightGrayColor];
    UILabel *groupName = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 200, 30)];
    groupName.textAlignment = NSTextAlignmentLeft;
    groupName.text = [_tagKeyArray objectAtIndex:section];
    [view addSubview:groupName];
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
