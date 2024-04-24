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

    <div class="flex mt-28 ml-5 mr-5 h-[400px] gap-20 justify-between border-2">
      <!-- Левый блок с описанием-->
      <div class="h-[200px] w-[800px] ml-5 mt-5 bg-white flex flex-col">
        <h1 @click="goToBack" class="font-bold text-xl text-gray-400 cursor-pointer">
          Вернуться к покупкам
        </h1>
        <h1 class="font-bold text-2xl">Корзина</h1>

        <div class="flex mt-5 gap-12">
          <img
            class="border-gray-400 border-2"
            alt="Пусто"
            style="width: 300px; height: 200px; object-fit: cover"
          />

          <div class="flex flex-col">
            <p>Оперативная память</p>
          </div>
        </div>
      </div>

      <!-- Правый блок с корзиной-->
      <div class="h-[200px] w-[200px] flex flex-col bg-white justify-center items-center">
        <div class="flex flex-col gap-2">
          <p>
            6000
            <span class="text-gray-400">руб</span>
          </p>
          <Button> Сделать заказ </Button>
        </div>

        <div class="flex gap-5 justify-center items-center mt-2">
          <Button @click="countMinus" variant="outline" class="bg-white border-0 text-black"
            >-</Button
          >
          <p>1</p>
          <Button @click="countPlus" variant="outline" class="bg-white border-0 text-black"
            >+</Button
          >
        </div>
      </div>
    </div>
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

const router = useRouter()

const goToBack = () => {
  router.push('/MainPage')
}

const goToLogOut = () => {
  localStorage.clear()
  router.push('/')
}

console.log(localStorage)
</script>

<style lang="scss" scoped></style>
