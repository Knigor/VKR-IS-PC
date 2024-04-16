<template>
  <div class="flex items-center gap-10">
    <siteLogo></siteLogo>
    <div class="h-16 border-l border-orange-300"></div>
    <div class="relative w-full max-w-sm items-center">
      <Input
        v-model="query"
        id="search"
        type="search"
        placeholder="Поиск по товару..."
        class="pl-10 min-w-96"
      />
      {{ query }}
      <span class="absolute start-0 inset-y-2 flex px-2">
        <Search class="size-6 text-muted-foreground" />
      </span>
    </div>
    <div class="flex xl:mr-5 xl:ml-96 3xl:ml-90 intems-center gap-4">
      <button variant="link">Корзина</button>
      <ShoppingCart />
      <button @click="goToLogOut" variant="link">Выйти</button>
      <LogOut @click="goToLogOut" />
    </div>
  </div>
</template>

<script setup>
import siteLogo from './siteLogo.vue'
import { Search } from 'lucide-vue-next'
import { Input } from '@/components/ui/input'
import { ShoppingCart, LogOut } from 'lucide-vue-next'
import { Button } from '@/components/ui/button'
import { useRoute, useRouter } from 'vue-router'
import { ref } from 'vue'

const router = useRouter()

const query = ref('')

const goToLogOut = () => {
  router.push('/')
}
</script>

<style lang="scss" scoped></style>
