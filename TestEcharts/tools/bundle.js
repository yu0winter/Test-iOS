/**
 * Created by luo yu shi on 2017/5/4.
 * @flow
 */

'use strict';

var colors = require("colors")
var fs = require('fs');
var process = require('child_process');
var path = require('path');
var inquirer = require('inquirer');

var archiver = require('archiver');

//根文件目录
var root = '../app/';
var zipPath = path.join(__dirname, '../zip_bundle/');
var source = path.join(__dirname, root);
var sourceDir = [];

var packageInfo = require('../package.json');

deleteFolderRecursive(zipPath);
mkdir(zipPath);

fs.readdirSync(source).forEach(function (dirname) {
    if (fs.statSync(source + '/' + dirname).isDirectory()) {
        sourceDir.push({name: dirname, value: dirname})
    }
});
//
// inquirer.prompt([
//     {
//         type: 'list',
//         name: 'dirTargetName',
//         message: '请选择要发布的项目文件夹',
//         choices: sourceDir,
//         pageSize: 12
//     }
// ])
//     .then(function (answers) {

        var bundleName = packageInfo.name;
        var bundleJS = root  + '/index.js';
        var bundlePageConfig = root  + '/PageConfig.js';

        bundleJS = path.join(__dirname, bundleJS);


        console.log('生成 web =============================================');
        bundleH5(bundleJS, bundleName, bundlePageConfig, function () {
            var bundleFileNameIos = `${bundleName}.bundle`;
            console.log('生成 iOS =============================================');
            bundleFile(bundleJS, bundleFileNameIos, zipPath, 'ios', function () {

                var bundleFileNameAndroid = `${bundleName}.android.bundle`;
                console.log('生成 android =============================================');
                bundleFile(bundleJS, bundleFileNameAndroid, zipPath, 'android', function () {

                    console.log('=============================================');
                    console.log("业务文件:" + bundleFileNameIos.green);
                    mkZipFile(zipPath + bundleName + '.ios.bundle.zip', zipPath + bundleFileNameIos, bundleFileNameIos);
                    shasum256(zipPath + bundleFileNameIos);

                    console.log('=============================================');
                    console.log("业务文件:" + bundleFileNameAndroid.green);
                    mkZipFile(zipPath + bundleName + '.android.bundle.zip', zipPath + bundleFileNameAndroid, bundleFileNameAndroid);
                    shasum256(zipPath + bundleFileNameAndroid);

                    var jumpData = {

                        //需要登录
                        jumpType : '需要登录 8 不需要登录 7',
                        //线上
                        '线上jumpUrl': `https://m.jr.jd.com/rn/${bundleName}/index.html?RN=${bundleName}&sid=`,
                        //预发
                        '预发jumpUrl': `http://minner.jr.jd.com/rn/${bundleName}/index.html?RN=${bundleName}&sid=`,
                    }
                    console.log("业务入口配置\n", jumpData);
                });
            });
        });


    //
    // });


//
function bundleFile(bundleJS, bundleFileName, zipPath, platform, callback) {
    // var exeStr = "react-native bundle --entry-file " + bundleJS + " --bundle-output " + zipPath + bundleName + ".bundle --platform ios --assets-dest " + zipPath + " --dev false";

    var cmd = `react-native bundle --entry-file ${bundleJS} --bundle-output ${zipPath}${bundleFileName} --platform ${platform} --dev false --assets-dest ${zipPath}${platform}_res/`;


    // console.log(cmd);
    var ls = process.exec(cmd, [], function (err, out) {
        console.log(out);
        if (err) {
            console.log(err)
        } else {
            callback && callback();
        }
    });

    // ls.stdout.on('data', function (data) {
    //     console.log(data);
    // });
    //
    // ls.stderr.on('data', function (data) {
    //     console.log(data);
    // });
    //
    // ls.on('exit', function (code) {
    // });

}

function bundleH5(bundleJS, bundleName, bundlePageConfig, callback) {

    var cmd = `rm -rf web/src_dist/ && NODE_ENV_EX=m BABEL_ENV=production NODE_ENV=production  webpack --config web/webpack.config.prod.js -p `
        // cmd += `&& jdf u -c web/src_dist `;

    // if (bundleName == 'AutoRepay'){
    //     cmd += '/export/App/m.jr.jd.com/jdbt/autopayment/rn-web';
    // } else {
    //     cmd += '/export/App/m.jr.jd.com/rn';
    // }
    // cmd += ' 172.23.182.136';

    console.log('bundleH5 CMD', cmd);
    fs.writeFileSync(path.join(__dirname, '../web/.prodTargetName'), bundlePageConfig);

    var ls = process.exec(cmd, [], function (err, out) {
        console.log(out);
        if (err) {
            console.log(err)
        } else {
        }
        callback && callback();
    });
    // callback && callback();
    // var ls = process.exec(cmd, [], function (err, out) {
    //     console.log(out);
    //     if (err) {
    //         console.log(err)
    //     } else {
    //         callback && callback();
    //     }
    // });
}


function deleteFolderRecursive(path) {
    if (fs.existsSync(path)) {
        fs.readdirSync(path).forEach(function (file, index) {
            var curPath = path + "/" + file;
            if (fs.lstatSync(curPath).isDirectory()) { // recurse
                deleteFolderRecursive(curPath);
            } else { // delete file
                fs.unlinkSync(curPath);
            }
        });
        fs.rmdirSync(path);
    }
};

function mkdir(path) {
    if (!fs.existsSync(path)) {
        fs.mkdirSync(path)
    }
}

var mkZipFile = function (targetFile, outPutPathAndFileName, fileName, callback) {
    console.log("压缩文件:" + outPutPathAndFileName);
    var output = fs.createWriteStream(targetFile);
    var archive = archiver('zip');

    archive.on('error', function (err) {
        throw err;
    });

    archive.pipe(output);
    archive.file(outPutPathAndFileName, {
        name: fileName
    });
    archive.finalize();
    callback && callback()
}

var shasum256 = function (d) {
    /*var crypto = require('crypto'),
     stream =fs.ReadStream(d);
     hash = crypto.createVerify('sha256');

     return hash.update(stream).digest('hex');*/


    //var filePath = 'PageExample.bundle';

    //var fs = require('fs');
    // console.log("sha256文件地址:" + d)
    var crypto = require('crypto'),
        stream = fs.readFileSync(d),
        /*buffer=new Buffer(d),
         bundle = new Uint8Array(stream),*/
        //arrBUffer=new ArrayBuffer(stream.length),
        sha256 = '';
    // view=new Uint8Array(arrBUffer);
    /*for(var a =0;a<stream.length;a++){
     view[a]=stream[a]
     };*/
    sha256 = crypto.createHash('sha256').update(stream).digest('hex');
    //console.log("@@@@@@@@@@@@@@@@@@@"+typeof stream)


    console.log("sha256加密串:" + sha256.green)
    return (sha256);
}
