import $ from 'jquery'

export default {
  request({ url, data, method }) {
    return $.ajax({ url, method, data })
  },
  update(url, data) {
    return this.request({ url, data, method: 'PATCH' })
  },
}
