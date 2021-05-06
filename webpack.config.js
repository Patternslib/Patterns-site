// Organised as described in https://simonsmith.io/organising-webpack-config-environments/
process.traceDeprecation = true;
const path = require("path");
const webpack = require("webpack");
const webpack_helpers = require("patternslib/webpack/webpack-helpers");

// plugins
const { CleanWebpackPlugin } = require("clean-webpack-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const DuplicatePackageCheckerPlugin = require("duplicate-package-checker-webpack-plugin");
const CopyPlugin = require("copy-webpack-plugin");
const VueLoaderPlugin = require("vue-loader/lib/plugin");

module.exports = (env) => {
    const mode = env.NODE_ENV;

    const config = {
        mode: mode,
        entry: {
            "bundle": path.resolve(__dirname, "bundle-config.js"),
            "bundle-polyfills": path.resolve(__dirname, "node_modules/patternslib/src/polyfills.js"), // prettier-ignore
        },
        externals: [
            {
                window: "window",
            },
        ],
        output: {
            filename: "[name].js",
            chunkFilename: "chunks/[id].[contenthash].js",
            path: path.resolve(__dirname, "assets/script"),
            // publicPath set in bundle entry points via __webpack_public_path__
            // See: https://webpack.js.org/guides/public-path/
            // publicPath: "/assets/script/",
        },
        optimization: {
            minimize: true,
            minimizer: [
                new TerserPlugin({
                    include: /(\.min\.js$)/,
                    extractComments: false,
                    terserOptions: {
                        output: {
                            comments: false,
                        },
                    },
                }),
            ],
        },
        module: {
            rules: [
                {
                    test: /\.js$/,
                    exclude: /node_modules\/(?!(patternslib|pat-.*)\/).*/,
                    loader: "babel-loader",
                },
                {
                    test: /\.vue$/,
                    loader: "vue-loader",
                },
                {
                    test: /\.html$/i,
                    use: "raw-loader",
                },
                {
                    test: require.resolve("jquery"),
                    use: [
                        {
                            loader: "expose-loader",
                            query: "$",
                        },
                        {
                            loader: "expose-loader",
                            query: "jQuery",
                        },
                    ],
                },
                {
                    test: /showdown-prettify/,
                    use: [
                        {
                            loader:
                                "imports-loader?showdown,google-code-prettify",
                        },
                    ],
                },
                {
                    test: /\.css$/,
                    use: [
                        {
                            loader: "style-loader",
                            options: {
                                insert: webpack_helpers.top_head_insert,
                            },
                        },
                        "css-loader",
                    ],
                },
                {
                    test: /\.modernizrrc\.js$/,
                    loader: "webpack-modernizr-loader",
                },
            ],
        },
        resolve: {
            alias: {
                modernizr$: path.resolve(__dirname, ".modernizrrc.js"),
                vue$: "vue/dist/vue.esm.js",
            },
        },
        plugins: [
            new CopyPlugin({
                patterns: [
                    { from: path.resolve(__dirname, "node_modules/patternslib/src/polyfills-loader.js"), }, // prettier-ignore
                ],
            }),
            new CleanWebpackPlugin(),
            new webpack.IgnorePlugin(/^\.\/locale$/, /moment$/),
            new webpack.ProvidePlugin({
                $: "jquery",
                jQuery: "jquery",
                jquery: "jquery",
            }),
            new DuplicatePackageCheckerPlugin({
                verbose: true,
                emitError: true,
            }),
            new VueLoaderPlugin(),
        ],
    };
    if (mode === "production") {
        config.entry["bundle.min"] = config.entry["bundle"];
        config.entry["bundle-polyfills.min"] = config.entry["bundle-polyfills"];
        config.output.chunkFilename = "chunks/[id].[contenthash].min.js";
    }
    return config;
};
