<template>
  <div class="flex flex-col gap-36">
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
      <div class="flex intems-center gap-2">
        <div v-if="logVisible" class="flex gap-2">
          <p @click="goToAdminPanel" class="text-nowrap cursor-pointer">{{ role }}</p>
          <Shield @click="goToAdminPanel" v-if="Visible" />
          <p class="text-nowrap">{{ user }}</p>
          <User v-if="userVisible" />
          <button @click="goToLogOut" variant="link">Выйти</button>
          <LogOut class="cursor-pointer" @click="goToLogOut" />
        </div>
        <div v-else class="flex gap-2 ml-[130px]">
          <button @click="goToLogIn" variant="link">Войти</button>
          <LogIn class="cursor-pointer" @click="goToLogIn" />
        </div>
      </div>
    </div>

    <div class="flex ml-12 mr-5 h-[400px] gap-10 justify-between">
      <!-- Левый блок с описанием-->

      <div class="ml-5 mt-5 bg-white flex flex-col items-center">
        <div class="flex gap-24 justify-between items-center">
          <div class="flex flex-col gap-4">
            <div>
              <Button @click="backToMain" variant="link" class="ml-[-15px]">Назад</Button>
              <h1 class="font-semibold text-x max-w-[730px]">{{ element.name_components }}</h1>
            </div>
            <img
              class="border-gray-400"
              :src="`http://localhost/images/${element.img_components}`"
              alt="Пусто"
              style="max-width: 400px; max-height: 250px; object-fit: cover"
            />
            <div class="flex flex-col gap-2 max-w-[430px]">
              <p class="text-gray-400" v-for="property in propertyData" :key="property.id_property">
                {{ property.value_property + ':' }}
                <span class="text-black"> {{ property.key_property }} </span>
              </p>
            </div>
          </div>
        </div>
      </div>

      <!-- Правый блок с отзывами-->
      <div v-if="reviewVisible" class="flex flex-col gap-6 mr-12 mt-16">
        <h1 class="font-semibold text-xl">Оставьте отзыв</h1>
        <div class="pl-1 flex flex-col gap-4">
          <div class="grid w-full gap-1.5">
            <Textarea v-model="textReview" placeholder="Начните писать о своих впечатлениях..." />
            <p class="text-sm text-muted-foreground">
              Ваша рецензия будет проверена модератором сервиса
            </p>
          </div>
          <Toaster />
          <div class="flex gap-8">
            <Button @click="pushReview">Отправить</Button>
          </div>
        </div>
      </div>
    </div>

    <!-- Комментарии-->

    <div class="max-w-3xl ml-8">
      <h1 class="text-bold text-2xl m-4">Комментарии</h1>
      <div
        v-for="review in reviews"
        :key="review.id_score"
        class="m-4 block rounded-lg bg-white p-6 shadow-lg dark:bg-neutral-800 dark:shadow-black/20"
      >
        <!--Testimonial-->
        <div>
          <div class="md:flex md:flex-row">
            <div class="mx-auto mb-6 flex w-36 items-center justify-center md:mx-0 md:w-96 lg:mb-0">
              <img
                src="https://api.dicebear.com/8.x/pixel-art/svg?backgroundColor=b6e3f4"
                class="rounded-full shadow-md dark:shadow-black/30"
                alt="woman avatar"
              />
            </div>
            <div class="md:ms-6">
              <p class="mb-6 font-light text-neutral-500 dark:text-neutral-300">
                {{ review.text_review }}
              </p>
              <p class="mb-2 text-xl font-semibold text-neutral-800 dark:text-neutral-200">
                {{ review.fio }}
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { createAvatar } from '@dicebear/core'
import { pixelArt } from '@dicebear/collection'
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
import { LogIn } from 'lucide-vue-next'
import { formatDate } from '@vueuse/core'
import { Toaster } from '@/components/ui/toast'
import { useToast } from '@/components/ui/toast/use-toast'

const user = ref(localStorage.full_name)

const { toast } = useToast()

let Visible = ref(false)

const role = ref('')

if (localStorage.role == 'Admin') {
  Visible.value = true
  role.value = 'Админ Панель'
}

let userVisible = ref(false)
let logVisible = ref()

// Логика с аватарками

const avatar = createAvatar(pixelArt, {
  seed: 'Felix'
})

const svg = avatar.toString()

if (localStorage.length == 0) {
  logVisible.value = false
} else {
  logVisible.value = true
  userVisible.value = true
}

let outText = ref()

const backToMain = () => {
  router.push('/')
}

const goToAdminPanel = () => {
  router.push('/mainAdmin')
}

const goToLogIn = () => {
  console.log('Клик Войти')
  logVisible.value = true
  router.push('/authPage')
}

const goToLogOut = () => {
  localStorage.clear()
  console.log('Клик, Выйти')
  logVisible.value = false
  reviewVisible.value = false
  router.push('/')
}

const router = useRouter()

const getIdComponent = useRoute()

const cardData = ref([])

const propertyData = ref([])
const reviews = ref([])

console.log(reviews)

const idComponents = getIdComponent.params.id

let element = ref({})

// Здесь будет логика на счетчик

let stock = ref({})

let reviewVisible = ref(false)

if (localStorage.length == 0) {
  reviewVisible.value = false
} else {
  reviewVisible.value = true
}

console.log(localStorage)

// делаем запрос

let textReview = ref('')

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

const pushReview = async () => {
  // Оставить отзыв
  const reviewFormData = new FormData()

  reviewFormData.append('id_user', localStorage.id_user)
  reviewFormData.append('id_components', getIdComponent.params.id)
  reviewFormData.append('text_review', textReview.value)

  try {
    const response = await axios.post('http://localhost/postAddReviews.php', reviewFormData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })

    if (response.data.status == 'Success') {
      alert('Сообщение успешно отправлено на модерацию')
      textReview.value = ''
    } else {
      alert('Заполните поля и попробуйте снова')
    }
    console.log(response.data)
  } catch (error) {
    console.error('Ошибка при отправке данных:', error)
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

  // Получаем отзывы

  try {
    const response = await axios.post('http://localhost/getReview.php', apiFormData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })

    console.log(response.data)
    reviews.value = response.data
  } catch (error) {
    console.error('Ошибка при отправке данных:', error)
  }
})

const goToCart = () => {
  router.push('/cartPage')
}
</script>

<style></style>
