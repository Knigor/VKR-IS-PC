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

    <div class="flex mt-28 ml-5 mr-5 h-[400px] gap-20 border-2">
      <!-- Левый блок с описанием-->
      <div class="h-[200px] w-[800px] ml-5 mt-5 bg-white flex flex-col">
        <h1 class="font-bold">{{ element.name_components }}</h1>
        <div class="flex mt-5 gap-12">
          <AspectRatio :ratio="16 / 9">
            <img
              class="border-gray-400 border-4"
              :src="`/images/${element.img_components}`"
              alt="Пусто"
            />
          </AspectRatio>

          <div class="flex flex-col gap-2">
            <p class="text-gray-400">Объем: <span class="text-black">2x 16Гб;</span></p>
          </div>
          <Select>
            <SelectTrigger class="text-orange max-w-[200px]">
              <!-- добавлен класс max-w-[100px] -->
              <SelectValue placeholder="Поставьте оценку" />
            </SelectTrigger>
            <SelectContent class="max-w-[200px]">
              <!-- добавлен класс max-w-[100px] -->
              <SelectGroup>
                <SelectLabel>Поставьте оценку</SelectLabel>
                <SelectItem value="one"> 1 </SelectItem>
                <SelectItem value="two"> 2 </SelectItem>
                <SelectItem value="three"> 3 </SelectItem>
                <SelectItem value="four"> 4 </SelectItem>
                <SelectItem value="five"> 5 </SelectItem>
              </SelectGroup>
            </SelectContent>
          </Select>
        </div>
      </div>

      <!-- Правый блок с корзиной-->
      <div class="h-[200px] w-[200px] flex flex-col bg-white justify-center items-center">
        <div class="flex flex-col gap-2">
          <p>{{ element.price_components }} <span class="text-gray-400">руб</span></p>
          <Button> <ShoppingCart color="" class="w-4 h-4 mr-2" /> В корзину </Button>
        </div>

        <div class="flex gap-5 justify-center items-center mt-2">
          <Button variant="outline" class="bg-white border-0 text-black">-</Button>
          <p>1</p>
          <Button variant="outline" class="bg-white border-0 text-black">+</Button>
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
import ky from 'ky'

const router = useRouter()

const getIdComponent = useRoute()

const cardData = ref([])

const idComponents = getIdComponent.params.id

let element = ref({})

onMounted(async () => {
  try {
    const response = await ky.get('http://localhost/getComponents.php').json()
    cardData.value = response
    console.log(cardData.value)

    // Ищем товар по нужному id и сохраняем в реактивную переменную element

    const item = cardData.value.find((item) => item.id_components == idComponents) || null

    element.value.id_components = item.id_components
    element.value.id_score = item.id_score
    element.value.img_components = item.img_components
    element.value.name_category = item.name_category
    element.value.name_components = item.name_components
    element.value.price_components = item.price_components

    console.log(element.value.name_components)
  } catch (error) {
    console.error('Ошибка при загрузке данных:', error)
  }
})

const goToLogOut = () => {
  localStorage.clear()
  router.push('/')
}
</script>

<style lang="scss" scoped></style>
