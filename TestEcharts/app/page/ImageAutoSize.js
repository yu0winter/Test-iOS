
import React, { Component } from 'react';

import {
  View,
    Image,
} from 'react-native';
import BaseCom from 'chameleon-ui/lib/component/BaseCom'

export default class ImageAutoSize extends BaseCom {

    static propTypes = {};
  constructor(props) {
    super(props);
    this.state = {
      width : props.width || -1,
      height: props.height || -1,
      imageUrl:props.imageUrl || '',
      maxWidth:props.maxWidth||-1,
      maxHeight:props.maxHeight||-1,
    }
  }

  componentDidMount() {
    this.loadImage();
  }

  loadImage () {
    Image.getSize(this.state.imageUrl,(width,height) =>{
        width = width/2.0;
        height = height/2.0;
        if (this.state.maxWidth > -1 && width > this.state.maxWidth) {
          width = this.state.maxWidth;
        }
        if (this.state.maxHeight > -1 && height > this.state.maxHeight) {
          height = this.state.maxHeight;
        }
        this.setState({width,height});
    });
  }  

  render() {
    return (
      <Image source={{ uri: this.state.imageUrl }}
        style={{
          width: this.state.width,
          height: this.state.height,
          resizeMode: 'cover'
        }}
      />
    );
  }
}