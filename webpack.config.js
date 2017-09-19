const merge = require('webpack-merge');
const path = require('path');
const UglifyJsPlugin = require('webpack-uglify-js-plugin');

var baseConfig = require(path.resolve(__dirname, 'node_modules/patternslib/webpack/base.config.js'));


module.exports = merge(baseConfig, {
    entry: {
        "bundle": path.resolve(__dirname, "bundle-config.js"),
        "bundle.min": path.resolve(__dirname, "bundle-config.js")
    },
    output: {
        filename: "[name].js",
        path: path.resolve(__dirname, 'bundles')
    },
    resolve: {
        // This line is important to supply the patternslib source files
        modules: [
                  path.resolve(__dirname, 'node_modules/patternslib/src'),
                  path.resolve(__dirname, 'src'),
                  'node_modules'
        ],
        alias: {
            // put any additional patterns here
        }
    },
    plugins: [
        new UglifyJsPlugin({
            cacheFolder: path.resolve(__dirname, '../cache/'),
            debug: true,
            include: /\.min\.js$/,
            minimize: true,
            sourceMap: true,
            output: {
              comments: false
            },
            compressor: {
              warnings: false
            }
        }),
    ],
});


