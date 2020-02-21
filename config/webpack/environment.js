const webpack = require('webpack')
const { environment } = require('@rails/webpacker')

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    jquery: 'jquery',
    Popper: '@popperjs/core',
    moment: 'moment',
  }),
)

module.exports = environment
