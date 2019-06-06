/**
 * Created by luo yu shi on 2017/1/10.
 * @flow
 */

'use strict';

import React, { Component } from 'react';

import {
    View,
    Image,
    Text,
    Animated,
    Dimensions,
    Platform,
} from 'react-native';

//
import Button from 'chameleon-ui/lib/Button'
import BaseCom from 'chameleon-ui/lib/component/BaseCom'
import styles from 'chameleon-ui/lib/css'
import JRTouchableOpacity from '../JRTouchableOpacity'

const deviceWidth = Dimensions.get('window').width;
const deviceHeight = Dimensions.get('window').height;


export default class BankCell extends BaseCom {

    static get CellHeight(){
        return 56;
    }
    // static propTypes = {
    //
    //     bankData: React.PropTypes.object.isRequired,
    //     // selectItem: React.PropTypes.func.isRequired,
    // };
    //

    static defaultProps = {
        active: false,
    };

    static propTypes = {};

    constructor(props) {
        super(props);
        this.state = {
            active: props.active,
        };
    }

    // shouldComponentUpdate(nextProps, nextState){
    //     return  nextProps.disable != this.props.disable ||
    //             nextProps.meatData != this.props.meatData ||
    //             nextProps.leftTitle != this.props.leftTitle ||
    //             nextProps.rightRender != this.props.rightRender ||
    //             nextProps.rightTitle != this.props.rightTitle;
    // }

    componentWillReceiveProps(nextProps) {
        if (nextProps.active != this.state.active){
            this.setState({
                active: nextProps.active,
            });
        }
    }

    render(){
        const {disable, meatData, onPress, leftTitle,leftRender, repayType, rightTitle, rightRender, bottomRender, disableLine, sortingEnabled} = this.props;
        const {active} = this.state;
        // console.log('[render] BankCell', leftTitle);

        var testStyle = styles.PingFangSCMedium;
        if (Platform.OS == 'android'){
            testStyle = styles.PingFangSCRegular;
        }

        var lineHeight = {height: styles.pixelRatioSize(0.5)};
        // if (Platform.OS == 'web'){
        //     lineHeight = {
        //         height: 1,
        //         // transform:[{scaleY: 0.5, }]
        //     };
        // }

        var rightComponent = undefined;

        if (rightRender){
            rightComponent = rightRender(this);
        } else {
            rightComponent = (
                <View style={{flexDirection: 'row', overflow: 'visible',}}>
                  <Text style={[styles.PingFangSCRegular, {color: '#999', fontSize: 16, alignSelf: 'center', overflow: 'visible',}]}>
                      { rightTitle }
                  </Text>
                  <Image source={styles.base64Img('iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABGdBTUEAALGPC/xhBQAAANZJREFUSA3N1LEVwiAQgOFAJnAiW0vr9NDoCnaOEAugs2QKt3AMNwDvChqfXA64IjR5L/D+j+SFTNMeh/f+yN2X5i4s65xza875FUK4lHvUtRnQWr8xmFJaOYii9NochhHAeQCvxphHbW0XgDEu0g1wkSGAgwwDW4gIQCFiQA0RBf4hzQcNI9SA8/GB+YRr4MQfRAH4jSxKqSe0NVxv1tq72Csqcdj1XOL4FCJALS4CUPFhYCs+BHDi3QA33gW0xBFoPgfwCZ5+P0UMiY0Y4wxPcRYLjoa+872d9nrgfKMAAAAASUVORK5CYII=')}
                         style={[{resizeMode: 'cover', width: 12, height: 12, alignSelf: 'center', marginLeft: 6, overflow: 'visible',}]}/>
                </View>
            );
        }

        if (sortingEnabled){
            rightComponent = (
                <View style={{justifyContent: 'center'}}>
                    <View style={{backgroundColor: '#ddd', width: 16, height: 2}}/>
                    <View style={{backgroundColor: '#ddd', width: 16, height: 2, marginTop: 2,}}/>
                    <View style={{backgroundColor: '#ddd', width: 16, height: 2, marginTop: 2,}}/>
                </View>
            );
        }

        var Comp = disable ? Animated.View : JRTouchableOpacity;
        var sortHandlers = this.props.enableSort ? this.props.sortHandlers : {};
        var lineComp = active || disableLine ? null :
            <View className="jrm-border-1px"
                           style={[
                               //this.props.lineStyle,
                               lineHeight, {backgroundColor: '#eee', width: deviceWidth - 16, position: 'absolute', left: 16, bottom: 0, overflow: 'visible',}]}
            />;

        var style = {
            height: BankCell.CellHeight,
            backgroundColor: '#fff',
            flexDirection: 'row',
            paddingHorizontal: 16,
            justifyContent: 'space-between',
            overflow: 'visible',
        };


        var activeLineComp = [];
        var activeShadow = [];
        if (active){
            style = {...style,
                backgroundColor: '#f5f5f5',
                ...Platform.select({
                    ios: {
                        shadowColor: '#777',
                        shadowOpacity: 1,
                        shadowOffset: {height: 1.5, width: 0},
                        shadowRadius: 3,
                    },

                    android: {
                        elevation: 0,
                    },
                })
            };

            activeLineComp.push(
                <View className="jrm-border-1px"
                      key="1"
                      style={[
                          //this.props.lineStyle,
                          lineHeight, {backgroundColor: '#aaa', width: deviceWidth, position: 'absolute', left: 0, bottom: 0, overflow: 'visible',}]}
                />
            );
            activeLineComp.push(
                <View className="jrm-border-1px"
                      key="2"
                      style={[
                          //this.props.lineStyle,
                          lineHeight, {backgroundColor: 'rgba(204, 204, 204, 0.75)', width: deviceWidth, position: 'absolute', left: 0, top: 0, overflow: 'visible',}]}
                />
            );

            activeShadow.push(
                <View style={{position: 'absolute', left:0, right: 0, top: 0, bottom:0,

                }}/>
            );
        }

        return (
            <Comp {...this.props} meatData={meatData} style={[style, this.props.style, {width: deviceWidth}]}
                  onPress={onPress}
                  { ...sortHandlers }
            >
                <View style={{flex: 1, justifyContent: 'center'}}>
                    <View style={{flexDirection: 'row'}}>
                        <Text style={[testStyle, {color: '#444', fontSize: 16, alignSelf: 'center', backgroundColor: 'transparent' }]}>
                            {leftTitle}
                        </Text>
                        {leftRender && leftRender()}
                        {
                            //已支持小金库零用钱还款
                            // repayType == 'xjk' ?
                            //     <Text style={[styles.PingFangSCMedium, {marginLeft: 7, paddingVertical: 5, paddingHorizontal: 7, backgroundColor: '#f2f2f2', color: '#999', fontSize: 12, alignSelf: 'center', overflow: 'visible',}]}>
                            //         { '仅支持小金库零用钱还款' }
                            //     </Text> : null
                        }
                    </View>
                    {bottomRender && bottomRender()}
                </View>
                {rightComponent}
                {lineComp}
                {activeLineComp}
            </Comp>
        );

        // {disabled ? null: <Text style={[styles.PingFangSCRegular, {color: '#999999', fontSize: 12, marginTop: 4, }]}>{bankDetail}</Text>}
    }
}