<template>
  <div class="flex flex-col">
    <div class="flex items-center gap-10 mt-5 ml-5">
      <siteLogo></siteLogo>
      <div class="h-16 border-l border-orange-300"></div>
      <div class="relative w-full max-w-sm items-center">
        <Input
          v-model="query"
          id="search"
          type="search"
          placeholder="Поиск по товару..."
          class="pl-10 min-w-[100px]"
        />

        <span class="absolute start-0 inset-y-2 flex px-2">
          <Search class="size-6 text-muted-foreground" />
        </span>
      </div>
      <div class="flex intems-center gap-2">
        <div v-if="logVisible" class="flex gap-2">
          <p @click="goToAdminPanel" class="text-nowrap cursor-pointer">{{ role }}</p>
          <Shield @click="goToAdminPanel" v-if="Visible" />
          <p class="text-nowrap">{{ user }}</p>
          <User v-if="userVisible" />
          <button @click="goToLogOut" variant="link">Выйти</button>
          <LogOut class="cursor-pointer" @click="goToLogOut" />
        </div>
        <div v-else class="flex gap-2 flex-end">
          <button @click="goToLogIn" variant="link">Войти</button>
          <LogIn class="cursor-pointer" @click="goToLogIn" />
        </div>
      </div>
    </div>

    <div class="flex flex-row gap-5 justify-start ml-5 mt-24">
      <ScrollArea class="min-h-[500px] min-w-[260px] max-w-[400px] rounded-md border p-4">
        <div v-for="cat in category" :key="cat.id" class="flex mt-2 gap-1">
          <Cpu />
          <button @click="selectedCategory(cat)" variant="link">{{ cat.name_category }}</button>
        </div>
      </ScrollArea>
      <div class="flex justify-center items-center">
        <ScrollArea v-if="isSearch !== 0" class="min-h-[500px] min-w-[200px] w-[1100px] rounded-md">
          <div class="flex flex-wrap gap-12 ml-10">
            <div
              v-for="item in queryItems"
              :key="item.id"
              class="border border-gray-200 w-full md:w-1/2 lg:w-1/3 xl:w-1/4 bg-white rounded-lg p-4 relative"
            >
              <div class="w-[150px]">
                <AspectRatio class="flex ml-3" :ratio="16 / 9">
                  <img
                    :src="`http://localhost/images/${item.img_components}`"
                    alt="Пусто"
                    class="rounded-md object-cover max-w-full"
                  />
                </AspectRatio>
              </div>
              <p class="text-gray-800 text-sm mt-2 mb-2">
                {{ item.name_components }}
              </p>
              <div class="flex items-center justify-between mt-10">
                <div class="flex justify-center mt-5">
                  <div class="absolute bottom-2 right-2">
                    <RouterLink :to="{ path: `/cardPage/${item.id_components}` }">
                      <Button class="bg-orange-400 w-[245px] text-white" variant="outline">
                        Открыть
                      </Button></RouterLink
                    >
                  </div>
                </div>
              </div>
            </div>
          </div>
        </ScrollArea>
      </div>
      <div
        class="flex items-center gap-5 flex-col ml-24 z-50 absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2"
        v-if="isSearch > 0"
      >
        <Snail size="120px" class="" />
        <p class="text-2xl cursor-default font-semibold">Ничего не найдено</p>
        <p class="text-x text-orange-500 rounded-md cursor-default">
          Очистите поиск и попробуйте снова
        </p>
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
import spinner from '@/components/custom/profile/spinner.vue'
import { Snail } from 'lucide-vue-next'
import { User } from 'lucide-vue-next'
import { Shield } from 'lucide-vue-next'
import { LogIn } from 'lucide-vue-next'

const router = useRouter()

const goToAdminPanel = () => {
  router.push('/mainAdmin')
}

const user = ref(localStorage.full_name)

let Visible = ref(false)

const role = ref('')

if (localStorage.role == 'Admin') {
  Visible.value = true
  role.value = 'Админ Панель'
}

const goToCart = () => {
  router.push('/cartPage')
}

const query = ref('')

let userVisible = ref(false)
let logVisible = ref()

if (localStorage.length == 0) {
  logVisible.value = false
} else {
  logVisible.value = true
  userVisible.value = true
}

let outText = ref()

const goToLogIn = () => {
  console.log('Клик Войти')
  logVisible.value = true
  router.push('/authPage')
}

const goToLogOut = () => {
  localStorage.clear()
  console.log('Клик, Выйти')
  logVisible.value = false
}

console.log(localStorage.length)

const queryItems = computed(() => {
  let search = query.value.toLowerCase().trim()
  let filteredItems = items.value.filter((elem) => {
    return (
      elem.name_components.toLowerCase().includes(search) ||
      elem.price_components.toString().includes(search)
    )
  })

  return filteredItems
})

let isSearch = computed(() => {
  return queryItems.value.length === 0
})

const items = ref([])

onMounted(async () => {
  try {
    const response = await axios.get('http://localhost/getComponents.php')
    items.value = response.data
  } catch (err) {
    console.error(err)
  }
})

const category = ref([])

onMounted(async () => {
  try {
    const response = await axios.get('http://localhost/getComponentsCategory.php')
    category.value = response.data
  } catch (err) {
    console.error(err)
  }
})

const selectedCategory = (selectedCat) => {
  query.value = selectedCat.name_category
}
</script>

<style>
.border {
  box-sizing: border-box;
}
</style>
