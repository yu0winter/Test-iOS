#!/usr/bin/env node
// import {generateBorder} from "../../chameleon-ui/src/UIBase/index";

/**
 * Created by tangqi on 2017/08/21.
 * @flow
 * 在图片所在目录生成图片对应的base64 js文件，目前支持png文件和jpg图片。
 * 根目录执行：node ./tool/imgToJs.js
 * 图片引用事例：
 * import img  from "./love_gray.png.js";
 * let img = require('./love_gray.png.js').default;
 */

const fs = require('fs');
const path = require('path');

const glob = require('glob');  // 遍历文件库
const inquirer = require('inquirer');  // 命令行交互库
const base64Img = require('base64-img');

const rootPath = "../app/";
const sourcePath = path.join(__dirname, rootPath);

let sourceDir = [];

// 遍历项目目录
fs.readdirSync(sourcePath).forEach(function (dirname) {
  if (fs.statSync(sourcePath + '/' + dirname).isDirectory()) {
    // sourceDir.push({name: dirname, value: dirname})
      generateImgToJs(dirname);
  }
});

// 转换图片为base64 js
function converImgToJs(imgPath, jsPath) {
  base64Img.base64(imgPath, function (err, data) {
    if (err) {
      console.log(err);
    }
    let str = `module.exports = '${data}'`;
    console.log('生成:' + jsPath);
    fs.writeFileSync(jsPath, str);
  })
}
//
// inquirer.prompt([
//   {
//     type: 'list',
//     name: 'dirTargetName',
//     message: '请选择要生成图片js的目录',
//     choices: sourceDir,
//     pageSize: 12
//   }
// ]).then(function (answers) {
//   let bundleName = answers.dirTargetName;
//
// });


function generateImgToJs(bundleName){
    let projectPath = path.join(sourcePath, bundleName);
    console.log('开始转换图片');
    // 遍历 png 图片
    glob("**/*.png", {cwd: projectPath}, function (er, files) {
        for (let i = 0; i < files.length; i++) {
            let rPath = files[i];
            let imgPath = path.join(projectPath, rPath);
            let jsPath = imgPath + '.js';
            converImgToJs(imgPath, jsPath)
        }
    });
    // 遍历 jpg 图片
    glob("**/*.jpg", {cwd: projectPath}, function (er, files) {
        for (let i = 0; i < files.length; i++) {
            let rPath = files[i];
            let imgPath = path.join(projectPath, rPath);
            let jsPath = imgPath + '.js';
            converImgToJs(imgPath, jsPath)
        }
    });
}
