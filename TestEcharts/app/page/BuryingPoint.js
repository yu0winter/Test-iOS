/**
 * Created by luo yu shi on 2017/2/15.
 * @flow
 */

'use strict';

import SAS from 'chameleon-ui/lib/NativeModle/sas'

module.exports = {
    // 自动还款开启
    clickBtAutoPayStateOpen(){
        var key = 'zdhk4001';
        // console.log('clickBtAutoPayStateOpen', key);
        this.record(key);
    },
    // 自动还款关闭
    clickBtAutoPayStateClose(){
        var key = 'zdhk4002';
        // console.log('clickBtAutoPayStateClose', key);
        this.record(key);
    },
    // 扣款日期
    clickBtDebitDay(){
        var key = 'zdhk4003';
        // console.log('clickBtDebitDay', key);
        this.record(key);
    },
    // 添加银行卡（旧版，小金库开户也用该埋点）
    clickAddBank(){
        var key = 'zdhk4005';
        // console.log('clickAddBank', key);
        this.record(key);
    },
    // 未用到
    clickAddXJK(){
        var key = 'zdhk4006';
        // console.log('clickAddXJK', 'zdhk4006');
        this.record(key);
    },
    // 白条还款方式
    clickRepaymentType(type) {
        var bid = "XFJR_AutoRepayment0001";
        var par = { "matid": type? type +'':''};
        var ctp = "AutoRepay";
        SAS.setLandmineWithEidNew(bid, '', '', ctp, par, '');
    },
        // 小金库优惠信息
    clickXJK_Tip(param) {
        var bid = "XFJR_AutoRepayment0002";
        var par = param;
        var ctp = "AutoRepay";
        SAS.setLandmineWithEidNew(bid, '', '', ctp, par, '');
    },
    // 小金库开户
    clickOpenXJK(tip) {
        var bid = "XFJR_AutoRepayment0003";
        var par = { "matid": tip? tip +'':''};
        var ctp = "AutoRepay";
        SAS.setLandmineWithEidNew(bid, '', '', ctp, par, '');
    },
    // 我的客服
    clickQues(){
        var key = 'zdhk4007';
        // console.log('clickQues', key);
        this.record(key);
    },

    record(key){
        SAS.tencentCloudEvent(key, '', '');
        SAS.setLandmineWithEid(key, '', '');
    }



};