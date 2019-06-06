/**
 * Created by luo yu shi on 2017/2/9.
 * @flow
 */

'use strict';

import React, {Component} from 'react';

import {
    View,
    Image,
    Text,
} from 'react-native';


import Button from 'chameleon-ui/lib/Button'
import BaseCom from 'chameleon-ui/lib/component/BaseCom'

import styles from 'chameleon-ui/lib/css'

export default class DebitDay extends BaseCom {

    static get cole_base64(){
        return 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA3FpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDE0IDc5LjE1MTQ4MSwgMjAxMy8wMy8xMy0xMjowOToxNSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDplNjJmZDE0Yi04YzBjLTY2NDQtOTViMy02NTVlODQ4NWM5YzciIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6QkY3RkMwM0QyRjg0MTFFNTlDQUJERURCRTk5Qjc0MjciIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6QkY3RkMwM0MyRjg0MTFFNTlDQUJERURCRTk5Qjc0MjciIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIChXaW5kb3dzKSI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOmU2MmZkMTRiLThjMGMtNjY0NC05NWIzLTY1NWU4NDg1YzljNyIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDplNjJmZDE0Yi04YzBjLTY2NDQtOTViMy02NTVlODQ4NWM5YzciLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz7N0Uc4AAABJUlEQVR42rzXwQnCMBTG8fTDFZyiLlF7cQK9OYFOo5dePbqAN+sO1SkcQt+DFEpI0iYvSeBJIdL/D8UUq67raqXUheZA81Vl1prmRnMCvVxpGpqn3igR59aO2wzY03xoNgUQY5xbb5oj9MfeFECY8S23oTdzI6xx3sDkTbkQzrgJyIHwxm2AlIjZuAuQAjGND664DyBBmPHWd8Bh5mahiKD4EkAIIji+FLAEERUPAfgQ0XFeq8Cf1ojoJwgVG48B2BAqNh76FZjrN7muYm8C4Qk3SE9MCOOt9NiGMP6VHtsQxsXPDiSIixBIFI9GIOWDJQaBxPFgBDLEXYjehkCmuA1R2xDIGF+EQOb4LAIF4l4E9L/U3HEX4s6AM82jQNxEvLj9F2AA1yCtHkDTstkAAAAASUVORK5CYII=';
    }
    constructor(props) {
        super(props);
        this.state = {
            selectDebitDayIndex: props.selectDebitDayIndex,
            debitDays: props.debitDays,
            closeHandle: props.closeHandle,
        }
        this.didUpdate = undefined;
    }

    updateDebitDayIndex(selectDebitDayIndex, didUpdate){
        if (this.state.selectDebitDayIndex == selectDebitDayIndex){
            return;
        }
        this.setNewState({
            selectDebitDayIndex: selectDebitDayIndex,
        })
        this.didUpdate = didUpdate;
    }

    componentDidUpdate(){
        super.componentDidUpdate();
        if (this.didUpdate){
            this.didUpdate();
        }
    }

    render(){
        const { selectDebitDayIndex, debitDays, closeHandle } = this.state;
        const close_64 = DebitDay.cole_base64;
        const select_64 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAZCAYAAABQDyyRAAAABGdBTUEAALGPC/xhBQAAAxxJREFUSA29Vs9rE0EUnjeNiLVCslARFAUFDwoevAjqtYo9SNKagz8K1UOh1KpNQqFQaC0UhHZTm1ahoFhFBa1m48EiFlp78FrqP+BBDxYK7iYNVs12n28WN+xOtqSNpiHLvPfNN+97O/PeJIxt8acfkYvHkQ04xlaM0ZdYs6gajwBYjvSuC81iJtVOoH8OA4Wv+jPGsAUROyLD+m2hCdUWFvHbJnDbct54QcIRtx4A3KxxA9WwO1O4fWlVTyNj5+X4dBRfqroD0STuMFHPILIzPuIT6ViovWo10PIEd5povPUTp9K7L8TpCLAqO3DtIe7SDX2axE/Lb84AxjLx0A0H/+8JtI7oQWMN35HACUekOALcJfGuok9GMQFxXmJiKgarbsJm7Ggyq5hozVC1Hy9dB2omEUrIuF0Ddo+i/qpAj7Bl0kb8aGql3rSsOT9xesshP3ERl9MCWFzQHzNkjeL5tGBMCmwjog4nei+/p/C78AEZHnMwZwTO7mgJpdvx5ZFHksYoCV9yJkj8so05QJmxKfVjn/mzME+0IzIVgA9qMaVHxt0+pzP47gZsG7EzrOp9JbgENI3rB7Dwa56SPixNUXHBgBYP9sq47Ntb3aTqYxai/ePgIXDWmYkp4x7srxNOGYdYwZql3dsvzwOHPi0WGpBxP99OQJx5JKk/dR+FTaaLggNeSceU5+7FETVHb2zOUp/vdePCpuu1V4srgzK+nm93gbiRdteFWmnfpj1ESoy+k81qttHBm5MrRxmatO0+4oz1bEZcxPRUO/1q1S7n9fcU/JQjaJOArQIPNKC1lidf9Hm9e97mcN6txYJDMl7O9yQgyOImy66x+ZKWAjCITKWCihyUdjCuxUNJGd+IX5KAWCT6mlrrI4kdLB8EbtElM1qe58+wa0CemuqoW+IcGqigvslzHl90yT+Ii1i+CYiJ113BzwFgZ6msDeF7PqI7OOtYr0U93DKO7xG411xQcydNZs5Qi9bauBBn0J6OByfcvErtsgmIwOGR7DmwrDf0tyrAEdrSieCDSgUrXhcezl6ky+pqxQHWWfgH3MA0bI67NXEAAAAASUVORK5CYII=';

        return (
            <View style={{backgroundColor: '#fff', }}>
                <View style={{height: 70, backgroundColor: '#f5f5f5', flexDirection: 'row', justifyContent: 'space-between', paddingLeft: 16, }}>
                    <Text style={[styles.PingFangSCRegular, {fontSize: 16, color: '#333', alignSelf: 'center',}]}>
                        {'请选择扣款日期'}
                    </Text>
                    <Button index={-1} onPress={closeHandle} style={{alignSelf: 'center', width: 48, height: 48, justifyContent: 'center',}}>
                        <Image source={{uri: close_64}}
                               style={[{resizeMode: 'cover', width: 18, height: 18, alignSelf: 'center', marginTop: 0, right: 0, }]}/>
                    </Button>
                </View>
                {
                    debitDays.map((debitDay, index)=>{
                        return (
                            <View key={index}>
                                <Button index={index} debitDay={debitDay} style={{height: 70, backgroundColor: '#fff', flexDirection: 'row', justifyContent: 'space-between', }}
                                        onPress={closeHandle}>
                                    <View style={{justifyContent: 'center', marginLeft: 16, }}>
                                        <Text style={[styles.PingFangSCMedium, {fontSize: 16, color: '#444',}]}>
                                            {debitDay.title}
                                        </Text>
                                        <Text style={[styles.PingFangSCRegular, {fontSize: 12, color: '#999', marginTop: 8, }]}>
                                            {debitDay.desc}
                                        </Text>
                                    </View>
                                    {selectDebitDayIndex == index ? <Image source={{uri: select_64}}
                                                                           style={[{resizeMode: 'cover', width: 16, height: 12, alignSelf: 'center', marginRight: 16,  }]}/> : null}
                                </Button>
                                {index > debitDays.length - 2 ? null : <View style={{backgroundColor: '#eee', height: 0.5, marginLeft: 16, }}/>}
                            </View>
                        );
                    })
                }
                <View style={{height: 70, backgroundColor: '#f5f5f5', }}/>
            </View>
        );
    }
}