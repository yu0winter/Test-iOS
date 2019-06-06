/**
 * Created by luo yu shi on 2017/1/10.
 * @flow
 */

'use strict';

/**
 * 需求文档 http://cf.jd.com/pages/viewpage.action?pageId=78645997
 * 接口文档 cf.jd.com/pages/viewpage.action?pageId=76054559
 */


import React, { Component } from 'react';

import {
    ListView,
    Animated,
    Dimensions,
    Platform,
    StyleSheet,
    View,
    Text,
    Image,
} from 'react-native';
import {Echarts, echarts} from 'react-native-secharts';

//
import Button from 'chameleon-ui/lib/Button'
import ImageAutoSize from './ImageAutoSize'
import styles from 'chameleon-ui/lib/css'
import RecordActionPage from 'chameleon-ui/lib/RecordActionPage'

// import BaseUrl from 'chameleon-ui/lib/BaseUrl'
import TopFullScreenView from 'chameleon-ui/lib/TopFullScreenView'
import DeviceEnv from 'chameleon-ui/lib/DeviceEnv'
import Utils from 'chameleon-ui/lib/Utils/Utils'
import NetWorkHandle from './NetWorkHandle'
import Url from './Url'
import ButtonBurying from 'chameleon-ui/lib/ButtonBurying'
import BankCell from './BankCell'

const deviceWidth = Dimensions.get('window').width;
const deviceHeight = Dimensions.get('window').height;

// import SortableListView from 'chameleon-ui/lib/component/SortableListview'
import SortableList from './SortableList';
import TriangleView from 'chameleon-ui/lib/component/TriangleView'
// import ActionSheet from 'chameleon-ui/lib/component/ActionSheet'
import SMSVerifyNumber from 'chameleon-ui/lib/component/SMSVerifyNumber'
import Switch from 'chameleon-ui/lib/component/Switch/Switch'
import NativeModule from 'chameleon-ui/lib/NativeModle/NativeModule'
import BasePage from 'chameleon-ui/lib/RecordActionPage/BasePage'
import NavigationBarEvent from 'chameleon-ui/lib/Navigator/NavigationBarEvent'
import DebitDay from './DebitDay'
import OpenAutoPay from './OpenAutoPay'
import BuryingPoint from './BuryingPoint'
import PageConfig from '../PageConfig'


const ELE_COMMAND_TITLE = 0; // 标题
const ELE_COMMAND_AUTO_STATE = 1; // 自动还款
const ELE_COMMAND_WhithDebt = 2; // 白条-还款项
const ELE_COMMAND_GoldDebt = 3; // 金条、贷款-还款项
const ELE_COMMAND_XJK = 4; // 小金库
const ELE_COMMAND_BANK = 5; // 银行卡
const ELE_COMMAND_XJK_Transferin = 6; // 小金库转入/开户
const ELE_COMMAND_MANGER = 7; // 管理银行卡
const ELE_COMMAND_FOOT = 8; // 我的客服


const AUTO_BANK_OPENED = 0; //已开启
const AUTO_BANK_OPEN = 1; //待开启
const AUTO_BANK_DISABLE = 2; //不支持

export default class AutoRepay extends RecordActionPage {
  render() {

    const c1 = new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
        offset: 0,
        color: '#1a98f8'
    }, {
        offset: 1,
        color: '#fff'
    }]);

    const c2 = new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
        offset: 0,
        color: '#99d9ea'
    }, {
        offset: 1,
        color: '#3fa7dc'
    }]);

    const option = {
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b}: {c} ({d}%)"
        },
        title: {
            text: '资产配比总额',
            left: 'center',
            top: '40%',
            padding: [12, 0],
            textStyle: {
                color: '#666',
                fontSize: 13,
                align: 'center'
            }
        },
        legend: {
            data: ['100000'],
            left: 'center',
            top: '50%',
            icon: 'none',
            align: 'center',
            textStyle: {
                color: "#333",
                fontSize: 30,
            },
            formatter: function() {

                return (100000);
            },
        },
        series: [{
            name: '访问来源',
            type: 'pie',
            radius: ['50%', '70%'],
            avoidLabelOverlap: false,
            label: {
                normal: {
                    show: true,
                },
                // 高亮项
                emphasis: {
                    show: true,
                    textStyle: {
                        fontSize: '30',
                        fontWeight: 'bold'
                    }
                }
            },
            labelLine: {
                normal: {
                    show: true
                }
            },
            color: [c1, c2],
            data: [
                { value: 70, name: '稳健户70% >\n货基/固定收益产品' },
                { value: 30, name: '进取户30%>\n沪深股票/港股通' },
            ].sort(function(a, b) { return a.value - b.value; }),
        }]
    };

    const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        // alignItems: 'center',
        backgroundColor: '#F5FCFF',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    instructions: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
    },
    });
    return (
        <View style={styles.container}>
      <Echarts ref="echarts1" option={option} onPress={this.onPress} height={150} />
      <Echarts ref="echarts2" option={lineGraphData} onPress={this.onPress} height={200} />
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.ios.js
        </Text>
        <Text style={styles.instructions}>
          还需要默认高亮某个数据。取消点击效果？
        </Text>
      </View>
    );
}
onPress = (e) => {
    console.log(e)
}
}







function randomData() {
    now = new Date(+now + oneDay);
    value = value + Math.random() * 21 - 10;
    return {
        name: now.toString(),
        value: [
            [now.getFullYear(), now.getMonth() + 1, now.getDate()].join('/'),
            Math.round(value)
        ]
    }
}

var data = [];
var now = +new Date(1997, 9, 3);
var oneDay = 24 * 3600 * 1000;
var value = Math.random() * 1000;
for (var i = 0; i < 1000; i++) {
    data.push(randomData());
}

var base = +new Date(1968, 9, 3);
var dateInfo = [];
var firstLine = [];
var secondLine = [];
for (var i = 1; i < 50; i++) {
    var now = new Date(base += oneDay);
    dateInfo.push([now.getFullYear(), now.getMonth() + 1, now.getDate()].join('-'));

    var value1 = Math.random() - 0.5;
    firstLine.push(value1);
    var value2 = value1 + Math.random() * 0.2;
    secondLine.push(value2);
}

console.log(dateInfo);
var firstName = "firstName";
var secondName = "secondName";

const lineGraphData = {
    title: {
        show: false
    },
    tooltip: {
        trigger: 'axis',
        backgroundColor: "#4D7BFE",
        padding: [2, 8, 2, 8],
        borderRadius: 0,
        position: function(p) {
            // 位置回调
            let xPosition = 0;
            if (p[0] > 175) {
                xPosition = p[0] - 132;
            } else {
                xPosition = p[0] - 4;
            }
            return [xPosition + 10, 10];

        },
        // formatter: "{b} <br/>{a0} {c0}%  <br/>{a1} {c1}%",

        formatter: "{b} <br/>{a0} {c0}%  <br/>{a1} {c1}%",
        textStyle: {
            color: '#222',
            fontFamily: 'fontFamilyDINAlternateBold'
        },
        axisPointer: {
            backgroundColor: "#4D7BFE",
            padding: [2, 10, 2, 10],
            borderRadius: 0,
            textStyle: {
                color: '#fff',
                fontSize: '14'
            },
            lineStyle: {
                color: '#4D6BFE',
                width: 0.5,
                type: 'solid'
            }
        }
    },
    legend: {},
    grid: {
        left: 6,
        right: 16,
        bottom: 0,
        height: '90%',
        containLabel: true
    },
    toolbox: {
        feature: {
            saveAsImage: {
                show: false
            }
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        splitLine: {
            show: false
        },
        axisLabel: {
            show: false
        },
        axisTick: {
            show: false

        },
        axisLine: {
            lineStyle: {
                color: '#f5f5f5',
                lineWidth: 0.2
            },
            lineWidth: 0.2
        },
        splitArea: {
            interval: 100
        },
        data: dateInfo,
    },
    yAxis: {
        type: 'value',
        axisLabel: {
            formatter: '{value}%',
            margin: 4,
            textStyle: {
                color: '#afafaf',
                fontSize: '12',
                fontFamily: 'DINAlternate-Bold'
            }
        },
        splitLine: {
            show: true,
            lineStyle: {
                color: '#f5f5f5',
                lineWidth: 2.5
            }
        },
        splitNumber: 3,
        // min:Math.min(Math.min.apply(null, firstLine),Math.min.apply(null, secondLine)),
        axisTick: {
            show: false
        },
        scale: true,
        axisLine: {
            show: false
        }
    },
    series: [{
            name: firstName,
            type: 'line',
            itemStyle: {
                normal: {
                    borderColor: "#FF801A"
                }
            },
            showSymbol: false,
            lineStyle: {
                normal: {
                    color: '#FF801A',
                    width: 1,
                    opacity: 1
                }
            },
            data: firstLine,
        },
        {
            name: secondName,
            type: 'line',

            itemStyle: {
                normal: {
                    borderColor: "#4D7BFE"
                }
            },
            showSymbol: false,
            lineStyle: {
                normal: {
                    color: '#4D7BFE',
                    width: 1,
                    opacity: 1
                }
            },
            data: secondLine,
        }
    ]
}