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

const router = createRouter({
  routes: [
    {
      path: '/',
      component: AuthPage
    },
    {
      path: '/MainPage',
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
    }
  ],
  history: createWebHistory()
})

const app = createApp(App)

const pinia = createPinia()

app.use(router).use(pinia)
app.mount('#app')
