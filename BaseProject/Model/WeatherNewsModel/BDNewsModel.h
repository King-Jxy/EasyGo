//
//  BDNewsModel.h
//  BaseProject
//
//  Created by jake on 15/10/29.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseModel.h"

@class BDNewsDataModel,BDCommentModel;
@interface BDNewsModel : BaseModel
@property (nonatomic, assign) double aerrno;
@property (nonatomic, strong) BDNewsDataModel *data;
@end


@interface BDNewsDataModel : BaseModel
@property (nonatomic, assign) BOOL hasmore;
@property (nonatomic, strong) NSString *maxsourcets;
@property (nonatomic, strong) NSString *st;
@property (nonatomic, assign) double total;
@property (nonatomic, strong) NSArray *anews;
@end

@interface BDNewsDetailModel : BaseModel
@property (nonatomic, strong) NSArray *imageurls;
@property (nonatomic, strong) NSString *sourcets;
@property (nonatomic, strong) NSString *nid;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) BDCommentModel *comment;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *site;
@property (nonatomic, strong) NSArray *related;
@property (nonatomic, strong) NSString *ts;
@property (nonatomic, strong) NSString *abs;
@property (nonatomic, strong) NSString *nType;
@property (nonatomic, strong) NSArray *content;
@end


@interface BDCommentModel : BaseModel
@property (nonatomic, assign) double count;
@end

@interface BDImageUrlModel : BaseModel
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) double width;
@property (nonatomic, assign) double height;

+ (id)prase:(NSArray *)imageUrls;
@end
