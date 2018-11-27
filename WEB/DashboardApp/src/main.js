import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './App.vue'
import GetId from './components/GetId.vue'
import Dashboard from './components/Dashboard.vue'
import Finish from './components/Finish.vue'
import Host from './components/host.vue'
Vue.use(VueRouter)
Vue.config.productionTip = false
const routes = [
  { path: '/', component: GetId },
  { path: '/dashboard/:serverdp', component: Dashboard },
  { path: '/finish/', component: Finish },
  { path: '/host/', component: Host }


]
const router = new VueRouter({
  routes
})
new Vue({
  render: h => h(App),
  router: router,
}).$mount('#app')
