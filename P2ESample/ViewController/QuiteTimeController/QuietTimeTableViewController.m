//
//  QuietTimeTableViewController.m
//  P2EPush
//
//  Created by Push2Engage on 08/03/16.
//  Copyright © 2016 Push2Engage. All rights reserved.
//

#import "QuietTimeTableViewController.h"
#import <P2EPush/P2E.h>
#import <ActionSheetPicker-3.0/ActionSheetDatePicker.h>

@class AbstractActionSheetPicker;

#define SCREENSIZE                              [UIScreen mainScreen].bounds.size

static NSString *const startTtime = @"Set Start Time";
static NSString *const endTtime =   @"Set End Time";

@interface QuietTimeTableViewController ()

@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) NSDate *startDate;
@property(nonatomic, strong) NSDate *endDate;
@property(nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;

@end

@implementation QuietTimeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _startDate = [self getFromTime];
    _endDate = [self getToTime];
    _dataArray = @[startTtime,endTtime];
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"QuietTimeCell"];
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(updateQuiteTime)];
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

///*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"QuietTimeCell"];
    
    NSString *cellText = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = cellText;
    if ([cellText isEqualToString:startTtime]) {
        cell.detailTextLabel.text = [self getDateStringFromDate:_startDate];
    }
    else if ([cellText isEqualToString:endTtime]) {
       cell.detailTextLabel.text = [self getDateStringFromDate:_endDate];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
    
    // Configure the cell...
    
    return cell;
}
// */

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self selectADate:indexPath];
}

#pragma mark - Private Methods
-(NSDate *)getFromTime {
    
    NSInteger hours = 23;
    NSInteger mintues = 0;
    
    NSDictionary *quietDic = [Push getQuietTime];
    if (quietDic && [quietDic objectForKey:@"startTime"]) {
        NSArray *time = [[quietDic objectForKey:@"startTime"] componentsSeparatedByString:@":"];
        hours = [[time objectAtIndex:0] integerValue];
        mintues = [[time objectAtIndex:1] integerValue];
    }
    
    NSDate * now = [[NSDate alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents * comps = [cal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [comps setHour:hours];
    [comps setMinute:mintues];
    [comps setSecond:0];
    NSDate * date = [cal dateFromComponents:comps];
    
    return date;
}

-(NSDate *)getToTime {
    NSInteger hours = 7;
    NSInteger mintues = 0;
    
    NSDictionary *quietDic = [Push getQuietTime];
    if (quietDic && [quietDic objectForKey:@"endTime"]) {
        NSArray *time = [[quietDic objectForKey:@"endTime"] componentsSeparatedByString:@":"];
        hours = [[time objectAtIndex:0] integerValue];
        mintues = [[time objectAtIndex:1] integerValue];
    }
    
    NSDate * now = [[NSDate alloc] init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents * comps = [cal components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:now];
    [comps setHour:hours];
    [comps setMinute:mintues];
    [comps setSecond:0];
    NSDate * date = [cal dateFromComponents:comps];
    
    return date;
}

- (void)selectADate:(NSIndexPath*)anIndexPath {
    UITableViewCell *cell =(UITableViewCell*)[self.tableView cellForRowAtIndexPath:anIndexPath];
    
    NSDate *selectedDateForPicker;
    NSString *timing = nil;
    
    if(anIndexPath.row == 0) {
        selectedDateForPicker = _startDate;
        timing = @"Start Time";
    }
    else {
        selectedDateForPicker = _endDate;
        timing = @"End Time";
    }
    
    _actionSheetPicker = [[ActionSheetDatePicker alloc] initWithTitle:timing datePickerMode:UIDatePickerModeTime selectedDate:selectedDateForPicker target:self action:@selector(dateWasSelected:element:) origin:cell.textLabel];
    
    self.actionSheetPicker.hideCancel = NO;
    [self.actionSheetPicker showActionSheetPicker];
    
}

- (void)dateWasSelected:(NSDate *)selectedDate element:(id)element {
    NSString *cellText =[(UILabel*)element text];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_dataArray indexOfObject:cellText] inSection:0];

    UITableViewCell *cell =(UITableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    NSString *theDate = [self getDateStringFromDate:selectedDate];
    cell.detailTextLabel.text = theDate;
    
    if ([cellText isEqualToString:startTtime]){
        _startDate = selectedDate;
    }
    else {
        _endDate = selectedDate;
    }
    //[self updateQuiteTime];
}

-(NSString *)getDateStringFromDate :(NSDate *)dateValue {
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setTimeStyle:NSDateFormatterShortStyle];
    [timeFormat setDateFormat:@"hh:mm a"];
    timeFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSString *theDate = [timeFormat stringFromDate:dateValue];
    return theDate;
}

- (void)updateQuiteTime {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsFrom = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:_startDate];
    NSInteger startHour = [componentsFrom hour];
    NSInteger startMinute = [componentsFrom minute];
    
    NSDateComponents *componentsTo = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:_endDate];
    NSInteger endHour = [componentsTo hour];
    NSInteger endMinute = [componentsTo minute];
    
    [Push enableQuiteTimeStartHour:startHour startMinute:startMinute endHour:endHour endMinute:endMinute];
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
