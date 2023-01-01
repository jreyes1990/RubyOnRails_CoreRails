const {environment} = require('@rails/webpacker')
const webpack = require('webpack')
environment.plugins.prepend('Provide', new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'startbootstrap-sb-admin-2/vendor/jquery/jquery',
        Popper: ['popper.js', 'default'],
        Rails: '@rails/ujs'
    })
)

environment.config.merge(
    module.exports = {
        resolve: {
            alias: {
                jquery: 'startbootstrap-sb-admin-2/vendor/jquery/jquery',
            }
        }
    }
)
module.exports = environment
