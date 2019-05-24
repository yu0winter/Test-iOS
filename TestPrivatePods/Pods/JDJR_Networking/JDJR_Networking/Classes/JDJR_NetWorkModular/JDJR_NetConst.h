//
//  JDJR_NetConst.h
//  Pods
//
//  Created by 成勇 on 2018/9/4.
//

#ifndef JDJR_NetConst_h
#define JDJR_NetConst_h

typedef void (^JDJR_ProgressBlock)(NSProgress *progress);
typedef id (^JDJR_ResponseFilterBlock)(id _Nullable responseObject ,NSError * _Nullable __autoreleasing *error);
typedef void (^JDJR_SuccessBlock)(id _Nullable responseObject);
typedef void (^JDJR_FailureBlock)(NSError * _Nullable error);

#endif /* JDJR_NetConst_h */
