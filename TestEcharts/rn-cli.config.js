
'use strict';
var blacklist = require('metro-bundler/src/blacklist');
module.exports = {
    getBlacklistRE(platform) {
        return blacklist(platform, [
            /node_modules\/chameleon-web\/.*/,
            // /app\/lib\/Navigator\/Navigator33\/.*/,
        ]);
    }
};
