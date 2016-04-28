
//  Created by OSX on 06/04/16.
//  Copyright © 2016 Vijayvir. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LeoKitHttp : NSObject<NSURLSessionDelegate>

typedef void (^completionBlock) ( NSDictionary *resultdict,NSURLResponse *response, NSData *data, NSError *error);
typedef void (^failureBlock) ( NSDictionary *resultdict,NSURLResponse *response, NSData *data, NSError *error);



+(void)sendMultipleImagesWithFileArray:(NSArray*)arr_fileName  successBlock:(completionBlock)completionBlockService
                       failureBlock:(failureBlock)failureBlockService;





+(void)sendRequestPost:(NSDictionary*)dict
                 successBlock:(completionBlock)completionBlock
                 failureBlock:(failureBlock)failure;


@end
