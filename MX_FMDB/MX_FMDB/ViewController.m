//
//  ViewController.m
//  MX_FMDB
//
//  Created by maguanxiao on 16/4/14.
//  Copyright © 2016年 MX. All rights reserved.
//

#import "ViewController.h"
#import "MXDB.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@",NSHomeDirectory());
    [MXDB open];
    [MXDB createTbName:TB_name_student keys:@[@"name varchar(20)",@"age integer",@"sex integer"]];
//    [MXDB insertTbName:TB_name_student keys:@[@"name",@"age",@"sex"] values:@[@"'zzr'",@18,@1]];
//    [MXDB deleteTbNmae:TB_name_student sql:@"id > 2"];
    [MXDB updataTbName:TB_name_student sql:@"id = 1" keys:@[@"name"] values:@[@"'卡啊'"]];
//    NSDictionary *dit = [MXDB selectDictInfoTbName:TB_name_student sql:@"id = 1" keys:@[@"name",@"age",@"sex"]];
//    NSArray *array = [MXDB selectArrayInfoTbName:TB_name_student sql:@"id > 1" keys:@[@"name",@"age",@"sex"]];
    [MXDB insertTbName:TB_name_student dict:@{@"name":@"SSSS",@"age":@19,@"sex":@1}];
    [MXDB close];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
