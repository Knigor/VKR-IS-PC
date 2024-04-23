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
      <div class="flex xl:mr-10 xl:ml-96 3xl:ml-90 intems-center gap-4">
        <button variant="link">Корзина</button>
        <ShoppingCart />
        <button @click="goToLogOut" variant="link">Выйти</button>
        <LogOut @click="goToLogOut" />
      </div>
    </div>

    <div class="flex flex-row gap-5 justify-start ml-5 mt-24">
      <ScrollArea class="min-h-[500px] min-w-[300px] max-w-[800px] rounded-md border p-4">
        <div v-for="cat in category" :key="cat.id" class="flex mt-2 gap-1">
          <Cpu />
          <button variant="link">{{ cat.name_category }}</button>
        </div>
      </ScrollArea>
      <div class="flex justify-center items-center">
        <ScrollArea class="min-h-[500px] min-w-[200px] w-[1100px] rounded-md">
          <div class="flex flex-wrap gap-12 ml-10">
            <div
              v-for="item in queryItems"
              :key="item.id"
              class="border border-gray-200 w-full md:w-1/2 lg:w-1/3 xl:w-1/4 bg-white rounded-lg p-4 relative"
            >
              <div class="w-[150px]">
                <AspectRatio class="flex ml-3" :ratio="16 / 9">
                  <img
                    :src="`/images/${item.img_components}`"
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
                  <p class="text-gray-700 font-semibold absolute left-4 bottom-4">
                    {{ item.price_components }} <span class="text-slate-600">руб</span>
                  </p>
                  <div class="absolute bottom-2 right-2">
                    <RouterLink :to="{ path: `/cardPage/${item.id_components}` }">
                      <Button class="bg-orange-400 w-32 text-white" variant="outline">
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

const router = useRouter()

const query = ref('')

console.log(localStorage)

const queryItems = computed(() => {
  let item = items.value
  let search = query.value
  let cat = category.value
  let selectedCategory

  // console.log(selectedCategory)

  // selectedCategory.forEach((element) => {
  //   console.log(element)
  // })

  if (search) {
    item = item.filter((elem) => {
      return (
        elem.name_components.indexOf(search) !== -1 || elem.price_components.indexOf(search) !== -1
      )
    })
  }

  return item
})

const goToLogOut = () => {
  localStorage.clear()
  router.push('/')
}

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
</script>

<style>
.border {
  box-sizing: border-box;
}
</style>
