const path = require('path');
const webpack = require('webpack');
const package = require('./../package.json');
const HasteResolverPlugin = require('node-haste-webpack-plugin');
const ModuleAlias = require('chameleon-web/web/alias.js');
const chameleonWebPath = path.resolve(process.cwd(), 'node_modules/chameleon-web/*');
const chameleonUIPath = path.resolve(process.cwd(), 'node_modules/chameleon-ui/*')
var fs = require('fs');
var prodTargetBasename = '';
var outputDist = 'src_dist';
var mkdirFn = function (p, mode, made) {
  if (mode === undefined) {
    mode = 0777 & (~process.umask());
  }
  if (!made)
    made = null;
  if (typeof mode === 'string')
    mode = parseInt(mode, 8);
  p = path.resolve(p);
  if (!fs.existsSync(p)) {
    try {
      fs.mkdirSync(p, mode);
      made = made || p;
    } catch (err0) {
      switch (err0.code) {
        case 'ENOENT':
          made = mkdirFn(path.dirname(p), mode, made);
          mkdirFn(p, mode, made);
          break;
        default:
          var stat;
          try {
            stat = fs.statSync(p);
          } catch (err1) {
            throw err0;
          }
          if (!stat.isDirectory())
            throw err0;
          break;
      }
    }
    return made;
  }
}
var entryFn = function () {
  var htmlTem = fs.readFileSync(path.join(__dirname, 'src/index.html'));
  var prodTargetName = '../app/PageConfig.js';
  var prodTargetDir = path.dirname(prodTargetName);
  prodTargetBasename = package.name;
  if (fs.existsSync(path.join(__dirname, prodTargetName))) {
    mkdirFn(path.join(__dirname, outputDist + '/' + prodTargetBasename))
    var pageConfig = require(prodTargetName);
    var pageConfigResult = {}
    for (var i in pageConfig) {
      var page_key = pageConfig[i].page_key;
      pageConfigResult.index = path.join(__dirname, path.join(prodTargetDir, './index.js'));
    }
    fs.writeFileSync(path.join(__dirname, outputDist + '/' + prodTargetBasename + '/index.html'), htmlTem)
    // console.log(pageConfigResult);
    return pageConfigResult; //开始执行webpack
  } else {
    console.log(prodTargetDir + " 项目没有'PageConfig.js'文件，请检查后重试！");
    process.exit();
  }
}
module.exports = {
  // devServer: {
  //   contentBase: path.join(__dirname, 'src')
  // },
  // entry: [
  //   path.join(__dirname, '../index.web.js')
  // ],
  entry: entryFn(),
  // devtool: 'cheap-module-source-map',
  module: {
    loaders: [{
      test: /\.js$/,
      include: [
        path.resolve(process.cwd()),
        path.resolve(process.cwd(), 'app'),
        chameleonWebPath,
        chameleonUIPath
      ],
      loader: 'babel-loader',
      query: {
        cacheDirectory: true
      }
    }, {
      test: /\.(gif|jpe?g|png|svg)$/,
      loader: 'url-loader',
      query: {
        name: '[name].[hash:16].[ext]'
      }
    }]
  },
  output: {
    path: path.join(__dirname, outputDist),
    // publicPath: '../src/'
    filename: prodTargetBasename + '/bundle.js',
    // filename: '[name].[chunkhash].js',
  },
  plugins: [
    // new webpack.optimize.CommonsChunkPlugin('vendor',  'vendor.js'),
    new HasteResolverPlugin({
      platform: 'web',
      nodeModules: ['chameleon-web'],
      cacheDirectory: './web/src_dev_temp'
    }),
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify('production'),
      'process.env.NODE_ENV_EX': JSON.stringify(process.env.NODE_ENV_EX || 'dev')
      // 'process.env.NODE_ENV_EX': JSON.stringify(process.env.NODE_ENV_EX || 'production')
    }),
    //Dedupe
    // new webpack.optimize.DedupePlugin(),
    //UglifyJs
    new webpack
    .optimize
    .UglifyJsPlugin({
      // beautify: true,
      minimize: true,
      compress: {
        drop_console: true,
        unused: true,
        dead_code: true,
        warnings: false
      },
      comments: false,
      mangle: {
        except: [
          '$super',
          '$',
          'exports',
          'require',
          'module',
          '_'
        ]
      }
    }),
    // new WebpackMd5Hash(),
    // new CommonsChunkPlugin({
    //   name: ["react-native",],
    // }),
    //预发线上环境替换
    // new ReplaceBundleStringPlugin([{
    //   partten: /msinner\.jr\.jd\.com/g,
    //   replacement: function () {
    //     var str = '';
    //     if (process.env.NODE_ENV_EX == 'm') {
    //       str = 'ms.jr.jd.com'
    //     } else if (process.env.NODE_ENV_EX == 'minner') {
    //       str = 'msinner.jr.jd.com'
    //     }
    //     return str;
    //   }
    // }])
  ],
  resolve: {
    alias: ModuleAlias
  },
  externals: {
    // Use external version of React
    //react和react-dom 必须同时过滤掉，react-dom里还是引用react
    "react": "React",
    "react-dom": "ReactDOM",
  }
};
