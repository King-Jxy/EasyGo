#import <Foundation/Foundation.h>
#import "BaseModel.h"


@interface CityListModel : BaseModel
@property (nonatomic, strong)NSArray* result;
//@property (nonatomic, strong)NSDictionary* result_ArrayItem;
@property (nonatomic, strong)NSString* resultcode;
@property (nonatomic, strong)NSString* reason;
@property (nonatomic, strong)NSNumber* error_code;
@end

@interface CityListDataModel : BaseModel
@property (nonatomic, strong)NSString* district;
@property (nonatomic, strong)NSString* ID;
@property (nonatomic, strong)NSString* province;
@property (nonatomic, strong)NSString* city;
@end



// {
// "id":"1", /*城市ID*/
//"province":"北京",/*省份名称*/
//"city":"北京",	/*城市*/
//"district":"北京"	/*城市/区名称*/
//}
