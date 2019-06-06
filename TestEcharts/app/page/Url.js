/**
 * Created by luo yu shi on 2017/2/13.
 * @flow
 */

'use strict';
import React, { Component } from 'react';
import {
    Platform,
} from 'react-native';

const isWeb = Platform.OS === 'web' ? true : false;


module.exports = {
    get baseUrl(){
        if (isWeb){
            return 'gw/generic/bt/h5/m/';
        }
        return 'gw/generic/bt/na/m/';
    },

    get userQualiVerify(){
        return this.baseUrl + 'userQualiVerify';
    },

    get getAutoRepaymentInfo(){
        return this.baseUrl + 'getAutoRepaymentInfo';
    },

    get getRealNameInfo(){
        return this.baseUrl + 'getRealNameInfo';
    },

    get closeAutoRepayment(){
        return this.baseUrl + 'closeAutoRepayment';
    },

    get modifyCardOrder(){
        return this.baseUrl + 'modifyCardOrder';
    },

    get bankCardApply(){
        return this.baseUrl + 'bankCardApply';
    },

    get bankCardVerify(){
        return this.baseUrl + 'bankCardVerify';
    },

    get signAutoRepayment(){
        return this.baseUrl + 'signAutoRepayment';
    },

    get modifyRepaymentOrder(){
        return this.baseUrl + 'modifyRepaymentOrder';
    },

    get modifyRepaymentCycle(){
        return this.baseUrl + 'modifyRepaymentCycle';
    },


    get changeAutoRepayType(){
        return this.baseUrl + 'changeAutoRepayType';
    },

}