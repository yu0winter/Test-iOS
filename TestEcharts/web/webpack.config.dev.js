const path = require('path');
const webpack = require('webpack');
const HasteResolverPlugin = require('node-haste-webpack-plugin');
const ModuleAlias = require('chameleon-web/web/alias');
const chameleonWebPath = path.resolve(process.cwd(), 'node_modules/chameleon-web/*');
const chameleonUIPath = path.resolve(process.cwd(), 'node_modules/chameleon-ui/*')
module.exports = {
  devServer: {
    contentBase: path.join(__dirname, 'src')
  },
  entry: [path.join(__dirname, '../index.web.js')],
  debug: true,
  devtool: 'inline-source-map',
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
    filename: 'bundle.js'
  },
  plugins: [
    new HasteResolverPlugin({
      platform: 'web',
      nodeModules: ['chameleon-web'],
      cacheDirectory: './web/src_dev_temp'
    }),
    new webpack.DefinePlugin({
      'process.env.NODE_ENV': JSON.stringify(process.env.NODE_ENV || 'production'), //development
      'process.env.NODE_ENV_EX': JSON.stringify(process.env.NODE_ENV_EX || 'dev') //development
    }),
    new webpack
    .optimize
    .DedupePlugin(),
    new webpack
    .optimize
    .OccurenceOrderPlugin()
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
