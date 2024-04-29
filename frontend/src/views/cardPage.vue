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
        <p class="text-nowrap cursor-pointer">{{ role }}</p>
        <Shield v-if="Visible" />
        <p class="text-nowrap">{{ user }}</p>
        <User />
        <button @click="goToLogOut" variant="link">Выйти</button>
        <LogOut class="cursor-pointer" @click="goToLogOut" />
      </div>
    </div>

    <div class="flex mt-28 ml-12 mr-5 h-[400px] gap-10 justify-between">
      <!-- Левый блок с описанием-->

      <div class="ml-5 mt-5 bg-white flex flex-col items-center">
        <div class="flex gap-24 justify-between items-center">
          <div class="flex flex-col gap-4">
            <h1 class="font-semibold text-x w-[330px]">{{ element.name_components }}</h1>
            <img
              class="border-gray-400"
              :src="`/images/${element.img_components}`"
              alt="Пусто"
              style="width: 300px; height: 200px; object-fit: cover"
            />
            <div class="flex flex-col gap-2">
              <p class="text-gray-400" v-for="property in propertyData" :key="property.id_property">
                {{ property.value_property + ':' }}
                <span class="text-black"> {{ property.key_property }} </span>
              </p>
            </div>
          </div>
        </div>
      </div>
      <div class="flex flex-col gap-6 mr-12 mt-5">
        <h1 class="font-semibold text-xl">Оставьте отзыв</h1>
        <div class="pl-1 flex flex-col gap-4">
          <div class="grid w-full gap-1.5">
            <Textarea
              v-model="textReview"
              id="message-2"
              placeholder="Начните писать о своих впечатлениях..."
            />
            <p class="text-sm text-muted-foreground">
              Ваша рецензия будет проверена модератором сервиса
            </p>
          </div>
          <Toaster />
          <div class="flex gap-8">
            <router-link to="../ReviewsPage">
              <Button @click="onsubmit">Отправить</Button>
            </router-link>
          </div>
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
import { useCartStore } from '@/stores/cartStore'
import { User } from 'lucide-vue-next'
import { Shield } from 'lucide-vue-next'
import { Textarea } from '@/components/ui/textarea'

const user = ref(localStorage.full_name)

let Visible = ref(false)

const role = ref('')

if (localStorage.role == 'Admin') {
  Visible.value = true
  role.value = 'Админ Панель'
}

const router = useRouter()

const getIdComponent = useRoute()

const cardData = ref([])

const propertyData = ref([])

const idComponents = getIdComponent.params.id

let element = ref({})

// Здесь будет логика на счетчик

let count = ref(1)

let stock = ref({})

const countPlus = () => {
  if (count.value < stock.value.quantity_stock) {
    count.value++
    console.log((element.value.price_components *= 2))
  }
}

const countMinus = () => {
  if (count.value > 1) {
    count.value--
    element.value.price_components /= 2
  }
}

// Добавляем объект в корзину

const cartStore = useCartStore()

const addToCart = async () => {
  try {
    const response = await ky.get('http://localhost/getComponents.php').json()
    cardData.value = response
    // console.log(cardData.value)

    // Ищем товар по нужному id и сохраняем в реактивную переменную element

    const item = cardData.value.find((item) => item.id_components == idComponents) || null

    element.value.id_components = item.id_components
    element.value.id_score = item.id_score
    element.value.img_components = item.img_components
    element.value.name_category = item.name_category
    element.value.name_components = item.name_components
    element.value.price_components = item.price_components
    element.value.stock = stock.value.quantity_stock

    cartStore.addToCart(element.value, router)
    // Массив для localStorage
  } catch (error) {
    console.error('Ошибка при загрузке данных:', error)
  }
}

onMounted(async () => {
  try {
    const response = await ky.get('http://localhost/getComponents.php').json()
    cardData.value = response
    // console.log(cardData.value)

    // Ищем товар по нужному id и сохраняем в реактивную переменную element

    const item = cardData.value.find((item) => item.id_components == idComponents) || null

    element.value.id_components = item.id_components
    element.value.id_score = item.id_score
    element.value.img_components = item.img_components
    element.value.name_category = item.name_category
    element.value.name_components = item.name_components
    element.value.price_components = item.price_components

    // Массив для localStorage
  } catch (error) {
    console.error('Ошибка при загрузке данных:', error)
  }

  const apiFormData = new FormData()

  apiFormData.append('id_components', getIdComponent.params.id)

  try {
    const response = await axios.post('http://localhost/postPropertyAPI.php', apiFormData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })

    propertyData.value = response.data
  } catch (error) {
    console.error('Ошибка при отправке данных:', error)
  }

  // Получаем кол-во товара на складе

  try {
    const response = await axios.post('http://localhost/postStockAPI.php', apiFormData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })

    stock.value = response.data
    console.log(stock.value.quantity_stock)
  } catch (error) {
    console.error('Ошибка при отправке данных:', error)
  }
})

// console.log(propertyData)

const goToCart = () => {
  router.push('/cartPage')
}

const goToLogOut = () => {
  localStorage.clear()
  router.push('/')
}
</script>

<style></style>
