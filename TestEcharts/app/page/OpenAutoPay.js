/**
 * Created by luo yu shi on 2017/2/9.
 * @flow
 */

'use strict';


import React, {Component} from 'react';

import {
    TouchableOpacity,
    Keyboard,
    dismissKeyboard,
    TextInput,
    ListView,
    Animated,
    Dimensions,
    Platform,
    View,
    Image,
    Text,
} from 'react-native';


import Button from 'chameleon-ui/lib/Button'
import BaseCom from 'chameleon-ui/lib/component/BaseCom'
import KeyboardAnimationView from 'chameleon-ui/lib/component/KeyboardAnimationView'

import styles from 'chameleon-ui/lib/css'
import Utils from 'chameleon-ui/lib/Utils/Utils'
import DebitDay from './DebitDay'

import fetch_server from 'chameleon-ui/lib/NetWork/fetch_server'
import BaseUrl from 'chameleon-ui/lib/BaseUrl'
import NetWorkHandle from './NetWorkHandle'
import Url from './Url'
import DeviceEnv from  'chameleon-ui/lib/DeviceEnv'
import NativeModule from  'chameleon-ui/lib/NativeModle/NativeModule'



var AnimatedButton = Animated.createAnimatedComponent(Button);


const deviceWidth = Dimensions.get('window').width;
const deviceHeight = Dimensions.get('window').height;


export default class OpenAutoPay extends BaseCom {

    constructor(props) {
        super(props);
        this.state = {
            selectDebitDayIndex: props.selectDebitDayIndex,
            debitDays: props.debitDays,
            closeHandle: props.closeHandle,
            openAgreement: true,
            agreementInfoVoList: [],
            openAutoPayTip: false,
            inputPassword: '',
            translateX: new Animated.Value(deviceWidth),

            translateInputY: new Animated.Value(-30),
            translateInputTextY: new Animated.Value(0),
            translateInputScale: new Animated.Value(16),
            translateHeight: 496,
            inputStart: false,
            inputFocus: false,
            agreement: false,
        }
        this.didUpdate = undefined;

        this.showKeyBordModeButton = false;
        if (Platform.OS === 'ios' && DeviceEnv.isIphoeOS6){
            this.showKeyBordModeButton = true;
        }

        this.inputChangeHeight = 44 -5;
        if (Platform.OS === 'web'){
            if (this.isAndroidBrowser()){
                this.inputChangeHeight = styles.pixelRatioSizeScale(30);
            } else {
                const base = 42 - 5;
                switch (styles.pixelRatio){
                    case 3:
                        this.inputChangeHeight = base*1.4;
                        break;
                    case 2:
                        this.inputChangeHeight = base;
                        break;
                    case 1:
                        this.inputChangeHeight = base*0.85;
                        break;
                    default:
                        this.inputChangeHeight = base;
                }

            }
        }
        // console.log('showKeyBordModeButton', this.showKeyBordModeButton, Platform.OS, deviceHeight, PixelRatio.get());
    }

    updateDebitDayIndex(selectDebitDayIndex, didUpdate) {
        if (this.state.selectDebitDayIndex == selectDebitDayIndex) {
            return;
        }
        this.setNewState({
            selectDebitDayIndex: selectDebitDayIndex,

        })
        this.didUpdate = didUpdate;
    }

    componentDidMount(){
        this.pressAgreement();
    }

    componentDidUpdate() {
        super.componentDidUpdate();
        if (this.didUpdate) {
            this.didUpdate();
        }
    }

    render() {
        const {openAgreement, openAutoPayTip, translateHeight} = this.state;

        let heightStyle = {height: this.isAndroidBrowser()?400: 500};
        let infoComp = null;
        if (openAutoPayTip) {
            infoComp = this.renderAutoPayTip();
        } else {
            infoComp = this.renderUserInfo();
            // if (this.isAndroidBrowser()){
            //     heightStyle = {};
            // }
        }
        return (
            <KeyboardAnimationView style={[heightStyle, {backgroundColor: '#f5f5f5', width: deviceWidth}]}
                                   disableAnimation={false}
                                   inputResponderView={this.inputResponderView}
                //inputStart={this.inputStart}
                //inputEnd={this.inputEnd}
                                   offsetY={this.showKeyBordModeButton ? 0 : 6.67}
                                   ref={view => { this._refKeyboardAnimationView = view; }}>
                {this.renderTitle()}
                {openAgreement? this.renderAgreement() : null}
                {infoComp}
            </KeyboardAnimationView>
        );
        // return (
        //     <Animated.View style={{flex: 1, backgroundColor: 'rgba(0, 0, 0, 0)', flexDirection: 'column-reverse', transform:[{translateY: translateY,}]}}>
        //         <View style={{backgroundColor: '#fff',}}>
        //             {this.renderTitle()}
        //             {infoComp}
        //             {openAgreement? this.renderAgreement() : null}
        //         </View>
        //     </Animated.View>
        // );
    }

    renderTitle = () => {
        const {openAgreement, openAutoPayTip, closeHandle} = this.state;
        const close_64 = DebitDay.cole_base64;
        const left_back_64 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAFgAAABYCAMAAABGS8AGAAAAFVBMVEUAAABmZmZmZmZmZmZmZmZmZmZmZmaAqJDbAAAABnRSTlMAV/x/gCvgt/MzAAAAPklEQVR42u3XsQEAEAwAwRDsP7IVFEJzN8D3HwAAH82o0XoWddfQ1dXV1dU9CWcoKysrKytfKY+yHQMAeGgDlq4B2vwztf4AAAAASUVORK5CYII=';

        let title = '';
        let showLeft = false;
        if (openAgreement) {
            title = '相关协议';
        } else if (openAutoPayTip) {
            title = '';
        } else {
            title = '开启自动还款';
            showLeft = true;
        }

        let leftBt = null;
        if (showLeft) {
            leftBt = (
                <Image source={{uri: left_back_64}}
                       style={[{
                           resizeMode: 'cover',
                           width: 48,
                           height: (48),
                           alignSelf: 'center',
                           marginTop: 0,
                           right: 0,
                       }]}/>
            );
        }

        return (
            <View style={{
                height: (70),
                backgroundColor: '#f5f5f5',
                flexDirection: 'row',
                justifyContent: 'space-between',
                paddingRight: 6,
            }} >
                <Button index={-1} onPress={this.pressJumpPre} style={{alignSelf: 'center', justifyContent: 'center',width: 48, height: 48,}}>
                    {leftBt}
                </Button>
                <Text style={[styles.PingFangSCRegular, {fontSize: 18, color: '#333', alignSelf: 'center',}]}>
                    {title}
                </Text>
                <Button index={-1} onPress={closeHandle} style={{alignSelf: 'center', justifyContent: 'center', width: 48, height: 48,}}>
                    <Image source={{uri: close_64}}
                           style={[{
                               resizeMode: 'cover',
                               width: 18,
                               height: (18),
                               alignSelf: 'center',
                               marginTop: 0,
                               right: 0,
                           }]}/>
                </Button>
            </View>
        );
    }

    renderUserInfo = () => {
        const {realNameInfo, jumpPassword} = this.props;
        const {inputPassword, translateX, translateInputTextY, translateInputY, translateInputScale, inputStart, inputFocus} = this.state;

        var userName = realNameInfo.censoredName;//'*钰';
        var userID = realNameInfo.censoredCertificateNo;//'140**********2027';
        var buttonEnable = !!inputPassword && inputPassword.length >= 1;
        var buttonColor = buttonEnable ? '#508CEE' : '#ccc';

        var lineHeight = {height: styles.pixelRatioSize(0.5)};

        const LineComp = <View className="jrm-border-1px" style={[lineHeight, {marginLeft: 16, backgroundColor: '#eee',}]}/>;

        // var showInputPassword = '';
        // for (var i = 0; i < inputPassword.length; ++i){
        //     showInputPassword += '*';
        // }

        let Comp = Animated.View;
        let styleAnimate = {
            transform:[{translateX: translateX,}], position: 'absolute', left: 0, right: 0, top: 70, bottom: 0,
        };
        if (Platform.OS == 'web'){
            Comp = Animated.View;
            styleAnimate = {
                position: 'absolute', left: translateX, width: deviceWidth, top: 70, bottom: 0,
            };
        } else {
            Comp = AnimatedButton;
        }

        return (
            <Comp activeOpacity={1} style={[{backgroundColor: '#f5f5f5', }, styleAnimate]} onPress={this.cancelCall}>
                <View style={{backgroundColor: '#fff',}} ref={view => { this._refMoveView = view; }}>
                    <View style={{marginHorizontal: 16, height: 70, }}>
                        <Text style={[styles.PingFangSCRegular, {fontSize: 12, color: '#508CEE', marginTop: 12.5,}]}>
                            {'姓名'}
                        </Text>
                        <Text style={[styles.PingFangSCRegular, {fontSize: 16, color: '#999', marginTop: 14,}]}>
                            {userName}
                        </Text>
                    </View>
                    {LineComp}
                    <View style={{marginHorizontal: 16, height: 70, }}>
                        <Text style={[styles.PingFangSCRegular, {fontSize: 12, color: '#508CEE', marginTop: 12.5,}]}>
                            {'身份证号'}
                        </Text>
                        <Text style={[styles.PingFangSCRegular, {fontSize: 16, color: '#999', marginVertical: 14,}]}>
                            {userID}
                        </Text>
                    </View>
                    {LineComp}
                    <View style={{marginHorizontal: 16, height: 70, flexDirection: 'row', justifyContent: 'center',}} >
                        <View style={{flex: 1, }}>

                            <Animated.View style={{flex: 1, transform:[{translateY: 5,}],}}>
                                <TextInput style={[styles.PingFangSCRegular, {
                                    fontSize: 16,
                                    color: '#444',
                                    flex: 1,
                                    height: 42, marginTop: 28,
                                }]}
                                           ref={(e)=>{
                                               this.refTextInputPassW = e;
                                           }}
                                           placeholder={!inputStart ? '请输入支付密码' : ''}
                                           placeholderTextColor={'#CCC'}
                                           onChangeText={this.onChangeTextPassword}
                                           keyboardType={'default'} multiline={false}
                                           onFocus={this.inputFocus}
                                           onBlur={this.inputBlur}
                                           maxLength={20} password={true} secureTextEntry={true} underlineColorAndroid={'transparent'}
                                           value={inputPassword}
                                />
                            </Animated.View>
                            <Animated.Text style={[styles.PingFangSCRegular, {
                                fontSize: translateInputScale,
                                color: '#508CEE',
                                alignSelf: 'flex-start',
                                transform:[{translateY: translateInputY,}],
                                backgroundColor: 'transparent',
                            }]}>
                                {inputStart ? '请输入支付密码' : ''}
                            </Animated.Text>
                        </View>
                        <View style={{backgroundColor: '#eee', width: 0.5, height: 26, alignSelf: 'center',}}/>
                        <TouchableOpacity onPress={jumpPassword} style={{justifyContent: 'center', }}>
                            <Text style={[styles.PingFangSCRegular, {
                                fontSize: 16,
                                color: '#508CEE',
                                marginLeft: 16,
                                alignSelf: 'center',
                            }]}>
                                {'忘记密码'}
                            </Text>
                        </TouchableOpacity>
                    </View>

                </View>
                <TouchableOpacity activeOpacity={buttonEnable? 0.8: 1} enable={buttonEnable} ref={view => { this._refMoveViewButton = view; }}
                                  style={[{
                                      backgroundColor: buttonColor,
                                      height: 45,
                                      justifyContent: 'center',
                                      marginTop: 30,
                                      marginHorizontal: 16,
                                  },]}
                                  onPress={this.pressOpen} >
                    <Text style={[styles.PingFangSCRegular, {color: '#FFFFFF', fontSize: 17, alignSelf: 'center',}]}
                    >
                        {'确认开启'}
                    </Text>
                </TouchableOpacity>
                {/*<View style={{justifyContent: 'center', marginTop: 20,}} >*/}
                    {/*<Text style={[styles.PingFangSCRegular, {fontSize: 12, color: '#999', alignSelf: 'center'}]}>*/}
                        {/*{'点击确认开启，意味着您已经阅读并同意 '}*/}
                        {/*<Text onPress={this.pressAgreement}>*/}
                            {/*<Text style={{color: '#508CEE'}}>{'相关协议'}</Text>*/}
                        {/*</Text>*/}
                    {/*</Text>*/}
                {/*</View>*/}
                {/*<View style={{height: inputFocus? 0 : 96}} />*/}
            </Comp>
        );

    }

    renderAgreement = () => {
        const {agreementInfoVoList, translateX, closeHandle} = this.state;
        return (
            <View style={{backgroundColor: '#f5f5f5', position: 'absolute', left: 0, right: 0, top: 70, bottom: 0,}}>
                <View>
                    {
                        agreementInfoVoList.map((info, index)=> {
                            return (
                                <View key={index}>
                                    <Button index={index} info={info} style={{
                                        height: 56,
                                        backgroundColor: '#fff',
                                        paddingLeft: 16,
                                        justifyContent: 'center'
                                    }}
                                            onPress={this.pressAgreementInfo}>
                                        <Text style={[styles.PingFangSCMedium, {fontSize: 16, color: '#444',}]}>
                                            {info.name}
                                        </Text>
                                    </Button>
                                    {index < agreementInfoVoList.length - 1 ? <View style={{backgroundColor: '#eee', height: styles.pixelRatioSize(0.5), marginLeft: 16,}}/> : null}
                                </View>
                            );
                        })
                    }
                </View>
                <View style={{position: 'absolute', left: 0 ,right: 0, bottom: 0}}>
                    <View style={{flexDirection: 'row', backgroundColor: '#fff',}}>
                        <Button onPress={()=>{
                            closeHandle && closeHandle();
                        }} style={{width: styles.deviceWidth/2, justifyContent: 'center', height: 50,}}>
                            <Text style={[styles.PingFangSCMedium, {fontSize: 17, color: '#666', alignSelf: 'center',}]}>
                                {'不同意'}
                            </Text>
                        </Button>
                        <View style={{height: 50, width: 0.5, backgroundColor: '#eee'}} />
                        <Button onPress={()=>{
                            this.setState({
                                agreement: true,
                            }, ()=>{
                                // this.pressOpen();

                                translateX.setValue(deviceWidth);
                                Animated.timing(translateX, {
                                    toValue: 0,
                                    duration: 200,
                                }).start(()=>{
                                    this.setNewState({
                                        openAgreement: false,
                                    });
                                });
                            });
                        }} style={{width: styles.deviceWidth/2, justifyContent: 'center', height: 50, }}>
                            <Text style={[styles.PingFangSCMedium, {fontSize: 17, color: '#508cee', alignSelf: 'center',}]}>
                                {'同意'}
                            </Text>
                        </Button>
                    </View>

                    <View style={{width: styles.deviceWidth, height: Utils.iPhoneXBottomBar()}} />
                </View>
            </View>
        );
    }

    renderAutoPayTip = () => {
        var base64_img = 'data:image/png;base64,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';
        return (
            <View style={{backgroundColor: '#fff', flex: 1,}}>
                <Image source={{uri: base64_img}}
                       style={[{
                           resizeMode: 'cover',
                           width: styles.pixelScaleHeight(120),
                           height: styles.pixelScaleHeight(120),
                           alignSelf: 'center',
                           marginTop: 0,
                           right: 0,
                       }]}/>
                <Text style={[styles.PingFangSCRegular, {
                    fontSize: 18,
                    color: '#333',
                    marginTop: styles.pixelScaleHeight(12),
                    alignSelf: 'center',
                }]}>
                    {'自动还款已开启'}
                </Text>
                <Text style={[styles.PingFangSCRegular, {
                    fontSize: 14,
                    color: '#666',
                    marginHorizontal: 50,
                    marginTop: styles.pixelScaleHeight(12),
                    alignSelf: 'center',
                    textAlign: 'center',
                    lineHeight: 24,
                }]}>
                    {'自动还款服务将于当日生效，每笔账单最后还款日前一天系统自动扣款，暂不支持从信用卡扣款。'}
                </Text>
                <Button style={[{
                    backgroundColor: '#508cee',
                    height: 45,
                    justifyContent: 'center',
                    marginTop: styles.pixelScaleHeight(44),
                    marginHorizontal: 16,
                },]}
                        onPress={this.pressOpenDoing}>
                    <Text style={[styles.PingFangSCRegular, {color: '#FFFFFF', fontSize: 17, alignSelf: 'center',}]}>
                        {'我知道了'}
                    </Text>
                </Button>
            </View>
        );
    }



    onChangeTextPassword = (e) => {
        // console.log('onChangeTextPassword', e);
        this.setNewState({
            inputPassword: e,
        })
    }

    pressOpen = () => {
        const {inputPassword, agreement} = this.state;
        // console.log('pressOpen', inputPassword);

        const signAuto = () =>{

            if (!inputPassword || inputPassword.length <= 0){
                // Utils.dialogOperator(2, '请输入支付密码');
                return;
            }

            this.signAutoRepayment(inputPassword, (res_data)=> {
                if (res_data.issuccess == 1) {
                    this.setNewState({
                        openAutoPayTip: true,
                        openAgreement: false,
                    })
                }
            });
        };

        if (Platform.OS == 'web'){
            document.activeElement.blur();
        }

        if (agreement){

            signAuto();
        }


    }

    pressOpenDoing = () => {
        const {closeHandle} = this.state;

        if (closeHandle) {
            closeHandle(true);
        }

    }

    pressAgreement = () => {
        this.getAgreementInfo((res_data)=> {
            const {translateX} = this.state;

            this.setNewState({
                openAgreement: true,
                agreementInfoVoList: res_data.agreementInfoVoList,
            });

            // translateX.setValue(deviceWidth);
            // Animated.timing(translateX, {
            //     toValue: 0,
            //     duration: 200,
            // }).start();
        });
    }

    pressJumpPre = () => {
        const {openAgreement} = this.state;
        if (openAgreement){
            return;
        }

        const {translateX} = this.state;
        translateX.setValue(0);
        Animated.timing(translateX, {
            toValue: deviceWidth,
            duration: 200,
        }).start(() => {
            this.setNewState({
                openAgreement: true,
            });
        });
    }


    pressAgreementInfo = (e) => {
        const {info} = e.props;
        NativeModule.jumpNativePage(2, info.url_native, '', {});
    }




    signAutoRepayment = (pwd, openHandle) => {
        //签约自动还款
        NetWorkHandle.servicePostData(Url.signAutoRepayment, {pwd: pwd}, openHandle);
    }

    getAgreementInfo = (handle) => {
        var Url =  BaseUrl.Url.domains +  'jrpmobile/btapply/agreement/getAgreementInfo?_=1486699025670';
        var queryParams = {
            "clientType": "sms",
            "agreementNos": ["4516131116171454", "6511731122175135"],
            "sourceType": "H5",
        };
        fetch_server.server_fetch_native(Url, queryParams,
            //errorHandle
            ()=> {

            },
            //successHandle
            (res_data)=> {
                if (res_data.issuccess == 1) {
                    handle && handle(res_data);
                } else if (res_data.issuccess == 3) {
                    // console.warn('userQualiVerify res_data', res_data);
                } else {
                    console.warn('errorCode:' + res_data.issucces + 'message' + res_data.error_msg);
                }
            },
        );
    }

    inputResponderView = () => {
        if (this.showKeyBordModeButton){
            return this._refMoveViewButton;
        }
        return  this._refMoveView;
    }

    cancelCall = () => {
        if (Platform.OS == 'web'){
            dismissKeyboard && dismissKeyboard();
        } else {
            Keyboard.dismiss();
        }
        // if (this._refKeyboardAnimationView && this._refKeyboardAnimationView.dismissKeyboard){
        //     this._refKeyboardAnimationView.dismissKeyboard();
        // } else {
        //     Keyboard.dismiss();
        // }
    }

    inputStart = (time) => {
        const {translateInputTextY, translateInputY, translateInputScale, inputPassword, translateHeight} = this.state;

        // if (this.showKeyBordModeButton){
        //     this.setNewState({
        //         translateHeight: deviceHeight,
        //     })
        // }
        if (!inputPassword || inputPassword.length <= 0){
            this.setNewState({
                inputStart: true,
            });

            translateInputY.setValue(-0);
            Animated.timing(translateInputY, {
                toValue: -this.inputChangeHeight,
                duration: time*0.5,
            }).start();


            translateInputTextY.setValue(0);
            Animated.timing(translateInputTextY, {
                toValue: 5,
                duration: time*0.5,
            }).start();

            translateInputScale.setValue(16);
            Animated.timing(translateInputScale, {
                toValue: 12,
                duration: time*0.5,
            }).start();
        }
    }

    inputEnd = (time) => {
        const {translateInputTextY, translateInputY, translateInputScale, inputPassword,translateHeight} = this.state;
        // this.setNewState({
        //     translateHeight: 496,
        // })
        if (!inputPassword || inputPassword.length <= 0){

            this.setNewState({
                inputStart: false,
            });
            translateInputY.setValue(-this.inputChangeHeight);
            Animated.timing(translateInputY, {
                toValue: -30,
                duration: time*0.5,
            }).start();


            translateInputTextY.setValue(0);
            Animated.timing(translateInputTextY, {
                toValue: 5,
                duration: time*0.5,
            }).start();


            translateInputScale.setValue(12);
            Animated.timing(translateInputScale, {
                toValue: 16,
                duration: time*0.5,
            }).start();
        }

    }

    inputFocus = (e) => {
        this.inputStart(200);
        if (this.isAndroidBrowser()){
            this.setNewState({
                inputFocus: true,
            })
        }
    }

    inputBlur = (e) => {
        this.inputEnd(200);
        if (this.isAndroidBrowser()){
            this.setNewState({
                inputFocus: false,
            })
        }
    }

    isAndroidBrowser = () => {
        // alert(/(Android)/i.test(navigator.userAgent));
        if (Platform.OS == 'web' && /(Android)/i.test(navigator.userAgent)){
            return true;
        }
        return false;
    }
}