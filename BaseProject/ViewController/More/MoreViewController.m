//
//  MoreViewController.m
//  WeatherNews
//
//  Created by jake on 15/11/7.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MoreViewController.h"
#import "DetailFunctionViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"携程旗下";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailFunctionViewController *dfvc;
    NSString *path;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            path = @"http://m.ctrip.com/html5/flight?allianceid=283778&sid=735700";
            dfvc = [[DetailFunctionViewController alloc]initWithURL:[NSURL URLWithString:path]];
            break;
        case 1:
            path = @"http://m.ctrip.com/webapp/hotel/?city=2&day=1&allianceid=283778&sid=735700&popup=close";
            dfvc = [[DetailFunctionViewController alloc]initWithURL:[NSURL URLWithString:path]];
            break;
        case 2:
            path = @"http://m.ctrip.com/webapp/bus/bus/index?bus=1&utmSource=zs&ad=close&popup=close";
            dfvc = [[DetailFunctionViewController alloc]initWithURL:[NSURL URLWithString:path]];
            break;
        case 3:
            path = @"http://m.ctrip.com/webapp/train/home/index?allianceid=283778&sid=732699";
            dfvc = [[DetailFunctionViewController alloc]initWithURL:[NSURL URLWithString:path]];
            break;
        case 4:
            path = @"http://m.ctrip.com/webapp/car/com/index?allianceid=283778&sid=735700";
            dfvc = [[DetailFunctionViewController alloc]initWithURL:[NSURL URLWithString:path]];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:dfvc animated:YES];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
