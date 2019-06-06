/**
 * Created by luo yu shi @ zhongshu on 2018/1/11.
 * @flow
 */

'use strict';




import React, {Component} from 'react';

import {
    View,
    Image,
    Text,
} from 'react-native';

//
import styles from 'chameleon-ui/lib/css'
import RecordActionPage from 'chameleon-ui/lib/RecordActionPage'
import NavigationBarEvent from 'chameleon-ui/lib/Navigator/NavigationBarEvent'
import Utils from 'chameleon-ui/lib/Utils/Utils'
import NetWorkHandle from './NetWorkHandle'
import Url from './Url'
import BankCell from './BankCell'



const strArray = [
    '最后还款日如全额扣款失败，将尝试扣收最低还款额',
    '剩余金额自本期账单最后还款日次日起，按0.05%/日计息',
];

export default class PageDeduct extends RecordActionPage {

    constructor(props) {
        super(props);
        this.state = {
            autoRepayType: props.pageParam.autoRepayType,
        }
    }

    render(){

        const {autoRepayType} = this.state;

        const rightRender = ()=>{
            return (
                <Image source={{uri: require('../img/duigou.png.js')}}
                       style={[{
                           resizeMode: 'cover',
                           width: 22,
                           height: 22,
                           alignSelf: 'center',
                       }]}/>
            );
        };

        const rightRenderEmpty = ()=>{
            return (
                <View style={[{
                           width: 22,
                           height: 22,
                           alignSelf: 'center',
                       }]}/>
            );
        };

        return (
            <View style={[styles.pageStyle,]}>
                {this.renderText('白条扣款方式')}
                <BankCell disable={autoRepayType == 0} disableLine={true}
                          style={{height: autoRepayType == 0 ? 70: 65}}
                          leftTitle={'全额还款'} rightTitle={''}
                          onPress={()=>{
                              this.changeAutoRepayType(0);
                          }}
                          rightRender={autoRepayType  == 0 ? rightRender : rightRenderEmpty}
                          bottomRender={()=>{
                              if (autoRepayType == 0){
                                  return (
                                      <Text style={[styles.PingFangSCRegular, {color: '#999', fontSize: 12, marginTop: 6.5}]}>
                                          {strArray[0]}
                                      </Text>
                                  );
                              }
                          }}
                />
                <View style={{backgroundColor: '#fff'}}>
                    <View style={{backgroundColor: '#eee', height: styles.pixelRatioSize(0.5), marginLeft: 16,}}/>
                </View>
                <BankCell disable={autoRepayType == 1}
                          disableLine={true}
                          style={{backgroundColor: '#fff', height: autoRepayType == 1 ? 70: 65}}
                          leftTitle={'按账单最低还款额还款'} rightTitle={''}
                          onPress={()=>{
                              this.changeAutoRepayType(1);
                          }}
                          rightRender={autoRepayType == 1 ? rightRender : rightRenderEmpty}
                          bottomRender={()=>{
                              if (autoRepayType == 1){
                                  return (
                                      <Text style={[styles.PingFangSCRegular, {color: '#999', fontSize: 12, marginTop: 6.5}]}>
                                          {strArray[1]}
                                      </Text>
                                  );
                              }
                          }}
                />
            </View>
        );
    }


    componentWillMount() {
        super.componentWillMount();
        NavigationBarEvent.changeHeadBarShowLine(false);
        NavigationBarEvent.changeHeadBarTitleStyle([styles.PingFangSCRegular, {color: '#666',}]);
        NavigationBarEvent.refreshHeadBar();
    }


    renderText = (text) => {
        return (
            <Text style={[styles.PingFangSCRegular, {color: '#999999', fontSize: 12, marginVertical: 12,  paddingHorizontal: 16,}]} >
                {text}
            </Text>
        );
    }


    changeAutoRepayType = (autoRepayType) => {
        if (autoRepayType == this.state.autoRepayType){
            return;
        }
        // 是否按周还款
        //
        // 0：全额还款 1：最低还款
        NetWorkHandle.servicePostData(Url.changeAutoRepayType, {autoRepayType: autoRepayType}, (res_data)=>{
            if (res_data.issuccess){
                NetWorkHandle.handleEventList().emit({autoRepayType: autoRepayType});
                this.setState({
                    autoRepayType: autoRepayType,
                });


                Utils.dialogOperator(2, '修改成功');
            }
        });
    }

}