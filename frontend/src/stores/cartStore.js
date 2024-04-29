import { defineStore } from 'pinia'

export const useCartStore = defineStore('CartStore', {
  state: () => ({
    carts: []
  }),
  actions: {
    addToCart(item, router) {
      item.countPlus = 1
      this.carts.push(item)
      router.push('/cartPage')
    },
    deleteCart(id) {
      this.carts = this.carts.filter((el) => el.id_components !== id)
    },
    clearCart() {
      this.carts = []
    }
  }
})
