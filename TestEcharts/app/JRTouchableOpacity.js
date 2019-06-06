/**
 * Created by luo yu shi on 2017/7/28.
 * @flow
 */

'use strict';
import React, { Component } from 'react';

import {
    TouchableOpacity,
    View,
    Platform,
} from 'react-native'


export default class JRTouchableOpacity extends Component{


    static propTypes = {
        enable: React.PropTypes.bool,
    };

    static defaultProps = {
        activeOpacity: 0.9,
        enable: true,
        backgroundColor: '#7e7e7e',
    };


    constructor(props) {
        super(props);
        this.state = {

        };
    }

    render(){
        const { children, ...otherProps,} = this.props;
        return (
            <View style={{backgroundColor:this.props.backgroundColor}}>
                <TouchableOpacity
                    {...otherProps}
                    activeOpacity={this.props.activeOpacity}
                    onPress={this.onPress}
                    ref={(view) => { this._refView = view; }}
                >
                    {children}
                </TouchableOpacity>
            </View>

        )
    }

    onPress = () => {
        if (!this.props.enable){
            console.log('this Button disable enable=false');
            return;
        }
        // if (__DEV__){
        //     console.warn('onPress', this.props);
        // }
        if (__DEV__){
            this.props.onPress && this.props.onPress(this._refView);
        } else {
            try {
                this.props.onPress && this.props.onPress(this._refView);
            } catch (e) {
                console.log('onPress handle error', e);
            }
        }

    }
}