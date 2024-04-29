<template>
  <div class="flex flex-col">
    <div class="flex items-center gap-10 mt-5 ml-5">
      <siteLogo></siteLogo>
      <div class="h-16 border-l border-orange-300"></div>
      <div class="relative w-full max-w-sm items-center">
        <Input
          id="search"
          type="search"
          placeholder="Поиск по товару..."
          class="pl-10 min-w-[100px]"
        />

        <span class="absolute start-0 inset-y-2 flex px-2">
          <Search class="size-6 text-muted-foreground" />
        </span>
      </div>
      <div class="flex xl:mr-10 xl:ml-96 3xl:ml-90 intems-center gap-4">
        <button variant="link">Корзина</button>
        <ShoppingCart />
        <button @click="goToLogOut" variant="link">Выйти</button>
        <LogOut @click="goToLogOut" />
      </div>
    </div>

    <div
      v-if="isVisible == 'A'"
      class="flex mt-16 ml-5 mb-12 mr-5 h-[400px] gap-20 justify-between"
    >
      <!-- Левый блок с описанием-->
      <div class="h-[200px] w-[800px] ml-5 mt-5 gap-6 bg-white flex flex-col">
        <h1 @click="goToBack" class="font-bold text-xl w-[230px] text-gray-400 cursor-pointer">
          Вернуться к покупкам
        </h1>

        <h1 class="font-bold text-2xl">Корзина</h1>
        <p>{{ cartStore.carts[0] }}</p>

        <div v-for="cart in cartStore.carts" :key="cart.id" class="flex mt-5 gap-12">
          <img
            class="border-gray-400 h-[150px] w-[150px]"
            :src="`/images/${cart.img_components}`"
            alt="Пусто"
          />

          <div class="flex flex-col">
            <p>
              {{ cart.name_components }}
            </p>
          </div>
          <div>
            <div class="flex gap-5 justify-center mt-2">
              <Button
                @click="() => countMinus(cart)"
                variant="outline"
                class="bg-white border-0 text-black"
                >-</Button
              >
              <p class="flex pt-2">{{ cart.countPlus }}</p>

              <Button
                @click="() => countPlus(cart)"
                variant="outline"
                class="bg-white border-0 text-black"
                >+</Button
              >
              <div class="pt-2">
                <CircleX
                  @click="cartStore.deleteCart(cart.id_components)"
                  size="20px"
                  class="cursor-pointer"
                />
              </div>
            </div>
            <p class="flex gap-2 items-center ml-4 mt-2">
              {{ cart.price_components }} <span class="text-gray-400">руб</span>
            </p>
          </div>
        </div>
      </div>

      <!-- Правый блок с корзиной-->
      <div class="h-[200px] w-[200px] flex flex-col bg-white justify-center items-center">
        <div class="flex flex-col gap-2">
          <p>
            {{ totalAmount }}
            <span class="text-gray-400">руб</span>
          </p>

          <Sheet>
            <SheetTrigger as-child>
              <Button> Сделать заказ </Button>
            </SheetTrigger>
            <SheetContent>
              <SheetHeader>
                <SheetTitle>Введите номер телефона</SheetTitle>
                <SheetDescription>
                  Ваш номер телефона нужен для того, чтобы в дальнейшем с вами связался
                  администратор магазина
                </SheetDescription>
              </SheetHeader>
              <div class="grid gap-4 py-4">
                <div class="flex w-full max-w-sm items-center gap-1.5">
                  <Input id="phone" type="phone" placeholder="+7 (800)-555-35-35" />
                </div>
              </div>
              <SheetFooter>
                <SheetClose as-child>
                  <Button @click="getOrder" type="submit"> Сделать заказ </Button>
                </SheetClose>
              </SheetFooter>
            </SheetContent>
          </Sheet>
        </div>
      </div>

      <Toaster />
    </div>
    <div v-else-if="isVisible == 'B'">Корзина пуста, добавьте как минимум один товар</div>
    <div v-else-if="isVisible == 'C'">Ваш заказ оформлен</div>
  </div>
</template>

<script setup>
import { ScrollArea } from '@/components/ui/scroll-area'
import { Cpu } from 'lucide-vue-next'
import { AspectRatio } from '@/components/ui/aspect-ratio'
import Button from '@/components/ui/button/Button.vue'
import { ref, onMounted, computed } from 'vue'
import axios from 'axios'
import siteLogo from '@/components/custom/profile/siteLogo.vue'
import { Search } from 'lucide-vue-next'
import { Input } from '@/components/ui/input'
import { ShoppingCart, LogOut } from 'lucide-vue-next'
import { useRoute, useRouter } from 'vue-router'
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue
} from '@/components/ui/select'
import { CircleX } from 'lucide-vue-next'
import { Label } from '@/components/ui/label'
import {
  Sheet,
  SheetClose,
  SheetContent,
  SheetDescription,
  SheetFooter,
  SheetHeader,
  SheetTitle,
  SheetTrigger
} from '@/components/ui/sheet'
import Toaster from '@/components/ui/toast/Toaster.vue'
import { useToast } from '@/components/ui/toast/use-toast'

import { useCartStore } from '@/stores/cartStore'

const router = useRouter()
const cartStore = useCartStore()

const { toast } = useToast()

let isVisible = ref('A')

console.log(cartStore.carts.length)

const getOrder = () => {
  try {
    console.log('Клик')

    if (cartStore.carts.length == 0) {
      isVisible.value = 'B'
    } else {
      cartStore.clearCart()
      isVisible.value = 'C'
    }
  } catch (error) {
    console.log(error.message)
  }
}

// console.log(cartStore.carts[0].price_components)

const countPlus = (cartItem) => {
  if (cartItem.countPlus < cartItem.stock) {
    cartItem.countPlus++
  }
}

const countMinus = (cartItem) => {
  if (cartItem.countPlus > 1) {
    cartItem.countPlus--
  }
}

const totalAmount = computed(() => {
  return cartStore.carts.reduce((total, cartItem) => {
    const itemTotal = cartItem.price_components * cartItem.countPlus
    return total + itemTotal
  }, 0)
})

const goToBack = () => {
  localStorage.setItem('pageReloaded', false)
  router.push('/MainPage')
}

const goToLogOut = () => {
  localStorage.clear()
  router.push('/')
}

const goToOrder = () => {
  router.push('/orderPage')
}
</script>

<style lang="scss" scoped></style>
