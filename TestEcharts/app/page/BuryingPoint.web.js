/**
 * Created by luo yu shi on 2017/2/15.
 * @flow
 */

'use strict';


module.exports = {


    clickBtAutoPayStateOpen() {
        const key = 'pageclick|keycount|zidonghuank_kai|1';
        // console.log('WEB clickBtAutoPayStateOpen', key);
        return key;
    },

    clickBtAutoPayStateClose() {
        const key = 'pageclick|keycount|zidonghuank_guan|2';
        // console.log('WEB clickBtAutoPayStateClose', key);
        return key;
    },

    clickBtDebitDay() {
        const key = 'pageclick|keycount|zidonghuank_koukuanriqi|3';
        // console.log('WEB clickBtDebitDay', key);
        return key;
    },

    clickAddBank() {
        const key = 'pageclick|keycount|zidonghuank_tianjiaka|6';
        // console.log('WEB clickAddBank', key);
        return key;
    },

    clickAddXJK() {
        const key = 'pageclick|keycount|zidonghuank_xiaojinku|4';
        // console.log('WEB clickAddXJK', key);
        return key;
    },

    clickQues() {
        const key = 'pageclick|keycount|zidonghuank_wenti|7';
        // console.log('WEB clickQues', key);
        return key;
    },
    // 白条还款方式
    clickRepaymentType(type) {
        return 'pageclick|keycount|20181121_xfjr_autorepayment|01';
    },
    // 小金库优惠信息
    clickXJK_Tip(param) {
        if (param.bankCardName && param.bankCardName.indexOf('理财金') != -1) {
            return 'pageclick|keycount|20181121_xfjr_autorepayment|03';
        } else {
            return 'pageclick|keycount|20181121_xfjr_autorepayment|02';
        }
    },
    // 小金库开户
    clickOpenXJK(tip) {
        return 'pageclick|keycount|20181121_xfjr_autorepayment|04';
    },
};