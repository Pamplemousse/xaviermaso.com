var path = require('path')
var webpack = require('webpack')
var merge = require('webpack-merge')
var HtmlWebpackPlugin = require('html-webpack-plugin')
var MiniCssExtractPlugin = require('mini-css-extract-plugin')
var CopyWebpackPlugin = require('copy-webpack-plugin')
var TerserPlugin = require('terser-webpack-plugin')
var OptimizeCSSAssetsPlugin = require('css-minimizer-webpack-plugin')

console.log('WEBPACK GO!')

// detemine build env
var TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? 'production' : 'development'

// common webpack config
var commonConfig = {
  output: {
    path: path.resolve(__dirname, 'dist/'),
    filename: '[contenthash].js'
  },

  resolve: {
    modules: ['node_modules'],
    extensions: ['.js', '.elm']
  },

  module: {
    noParse: /\.elm$/,
    rules: [
      {
        test: /\.(eot|svg|ttf|woff(2)?)(\?v=\d+\.\d+\.\d+)?/,
        type: 'asset/inline'
      }
    ]
  },

  plugins: [
    new HtmlWebpackPlugin({
      template: path.join(__dirname, 'front', 'static', 'index.html'),
      inject: 'body',
      filename: 'index.html'
    }),
    new webpack.EnvironmentPlugin({
      NODE_ENV: 'development'
    })
  ]
}

// additional webpack settings for prod env (when invoked via 'npm run dev')
if (TARGET_ENV === 'development') {
  console.log('Serving locally...')

  module.exports = merge(commonConfig, {
    entry: [
      path.join(__dirname, 'front', 'static', 'index.js')
    ],

    devServer: {
      static: [
        {
          directory: path.join(__dirname, 'front', 'static'),
          watch: true
        },
        {
          directory: path.join(__dirname, 'front', 'static', 'documents'),
          watch: true
        }
      ],
      hot: true,
      host: '127.0.0.1',
      port: 8080
    },

    mode: 'development',

    module: {
      rules: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          use: [
            {
              loader: 'elm-reloader'
            },
            {
              loader: 'elm-webpack-loader',
              options: {
                debug: true
              }
            }
          ]
        },
        {
          test: /\.(css|scss)$/,
          use: [
            { loader: 'style-loader', options: { sourceMap: true } },
            { loader: 'css-loader', options: { sourceMap: true } },
            { loader: 'postcss-loader', options: { sourceMap: true } },
            { loader: 'sass-loader', options: { sourceMap: true } }
          ]
        }
      ]
    }
  })
}

// additional webpack settings for prod env (when invoked via 'npm run build')
if (TARGET_ENV === 'production') {
  console.log('Building for prod...')

  module.exports = merge(commonConfig, {
    entry: path.join(__dirname, 'front', 'static', 'index.js'),

    mode: 'production',

    module: {
      rules: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          use: {
            loader: 'elm-webpack-loader',
            options: {
              optimize: true
            }
          }
        },
        {
          test: /\.(css|scss)$/,
          use: [
            MiniCssExtractPlugin.loader,
            'css-loader',
            'postcss-loader',
            'sass-loader'
          ]
        }
      ]
    },

    optimization: {
      minimizer: [
        new TerserPlugin({
          terserOptions: {
            compress: {
              pure_funcs: ['F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9', 'A2', 'A3', 'A4', 'A5', 'A6', 'A7', 'A8', 'A9'],
              pure_getters: true,
              keep_fargs: false,
              unsafe_comps: true,
              unsafe: true
            }
          }
        }),
        new OptimizeCSSAssetsPlugin({})
      ]
    },

    plugins: [
      new CopyWebpackPlugin({
        patterns: [
          {
            from: path.join(__dirname, 'front', 'static', 'img'),
            to: path.join('static', 'img')
          },
          {
            from: path.join(__dirname, 'front', 'static', 'documents', 'xaviermaso.pdf'),
            to: 'xaviermaso.pdf'
          },
          {
            from: path.join(__dirname, 'front', 'static', 'documents', 'internship_report_2018.pdf'),
            to: 'internship_report_2018.pdf'
          },
          {
            from: path.join(__dirname, 'front', 'static', 'img', 'favicon.ico')
          }
        ]
      }),

      // extract CSS into a separate file
      new MiniCssExtractPlugin({
        filename: '[contenthash].css',
        chunkFilename: '[id].[contenthash].css'
      })
    ]
  })
}
