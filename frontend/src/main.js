import { createApp } from 'vue'
import App from './App.vue'
import { createRouter, createWebHistory } from 'vue-router'
import './index.css'
import MainPage from './views/MainPage.vue'
import AuthPage from './views/AuthPage.vue'
import RegisterPage from './views/RegisterPage.vue'
import cardPage from './views/cardPage.vue'
import cartPage from '@/components/custom/profile/cartPage.vue'
import { createPinia } from 'pinia'
import MainAdminPanel from './views/mainAdminPanel.vue'
import reviewsPanel from './views/reviewsPanel.vue'
import ComponentsViews from './views/componentsViews.vue'
import componentsPage from './views/componentsPage.vue'
import addComponentsPage from './views/addComponentsPage.vue'

const router = createRouter({
  routes: [
    {
      path: '/authPage',
      component: AuthPage
    },
    {
      path: '/',
      component: MainPage
    },
    {
      path: '/RegisterPage',
      component: RegisterPage
    },
    {
      path: '/cardPage/:id',
      name: cardPage,
      component: cardPage
    },
    {
      path: '/cartPage',
      name: cartPage,
      component: cartPage
    },
    {
      path: '/mainAdmin',
      name: MainAdminPanel,
      component: MainAdminPanel
    },
    {
      path: '/reviewsPanel',
      name: reviewsPanel,
      component: reviewsPanel
    },
    {
      path: '/componentsView',
      name: ComponentsViews,
      component: ComponentsViews
    },
    {
      path: '/componentsPage/:id',
      name: componentsPage,
      component: componentsPage
    },
    {
      path: '/addComponentsPage',
      name: addComponentsPage,
      component: addComponentsPage
    }
  ],
  history: createWebHistory()
})

const app = createApp(App)

const pinia = createPinia()

app.use(router).use(pinia)
app.mount('#app')
