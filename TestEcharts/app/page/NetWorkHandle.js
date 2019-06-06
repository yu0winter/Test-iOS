/**
 * Created by luo yu shi on 2017/2/13.
 * @flow
 */

'use strict';

import {
    Platform,
} from 'react-native';

import Utils from 'chameleon-ui/lib/Utils/Utils'
import HandleEventList from 'chameleon-ui/lib/Utils/HandleEventList'
import Alert from 'chameleon-ui/lib/Alert'
import NetWork from 'chameleon-ui/lib/NetWork'

const isWeb = Platform.OS === 'web' ? true : false;

module.exports = {

    alert(title, message, callbackOrButtons){
        if (isWeb){
            Alert.alert(title, message, callbackOrButtons);
        } else {
            Utils.alert(title, message, callbackOrButtons);
        }
    },

    errorHandle(errorCode, errorMsg) {
        if (errorCode == 3){
            NetWork.jumpWebLogin();
            return;
        }
        if (errorMsg){
            var errorMsg = '' + errorMsg;
            Utils.dialogOperator(2, errorMsg);
        }
    },

    servicePostData(functionId, parameters, handle, errorHandle) {
        NetWork.servicePostData(functionId, parameters,
            //handle success
            (res_data) => {
                // console.warn(functionId, res_data);
                //统一成功标志
                if (res_data.issuccess == 1) {
                    if (handle) {
                        handle(res_data);
                    }
                } else if (res_data.issuccess == 3){
                    this.alert(res_data.resultMsg);
                } else {
                    errorHandle && errorHandle(res_data.issucces, res_data.error_msg);
                    this.errorHandle(res_data.issucces, res_data.error_msg);
                }
            },
            //handle error
            (errorCode, errorMsg)=> {
                errorHandle && errorHandle(errorCode, errorMsg);
                this.errorHandle(errorCode, errorMsg);
            }

        );
    },

    handleEventList(){
        if (!this._handleEventList){
            this._handleEventList = new HandleEventList();
        }
        return this._handleEventList;
    }

}