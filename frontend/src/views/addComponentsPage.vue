<template>
  <div class="flex flex-col gap-8 h-full p-16">
    <main class="flex h-full gap-8">
      <div class="h-full w-full flex flex-col gap-10">
        <div class="flex flex-row w-full">
          <div class="px-10 py-5 w-full">
            <p class="text-xl text-inter-title mb-1">Добавление комплектующего</p>

            <Input
              v-model="components"
              class="mt-5 mb-5"
              placeholder="Введите название комплектующего"
            />

            <Select
              v-model="componentsCategory"
              class="block appearance-none w-full bg-white border border-gray-300 hover:border-gray-500 px-4 py-2 pr-8 rounded shadow leading-tight focus:outline-none focus:shadow-outline"
            >
              <SelectTrigger class="min-w-[100px]">
                <SelectValue placeholder="Выберите категорию" />
              </SelectTrigger>
              <SelectContent>
                <SelectGroup>
                  <SelectItem value="1"> Материнская плата </SelectItem>
                  <SelectItem value="2"> Видеокарта </SelectItem>
                  <SelectItem value="3"> Оперативная память </SelectItem>
                  <SelectItem value="4"> Процессор </SelectItem>
                </SelectGroup>
              </SelectContent>
            </Select>

            <div
              v-for="(field, index) in fields"
              :key="index"
              class="flex w-full max-w-full items-center gap-1.5 mt-5"
            >
              <Input v-model="field.value" type="value" placeholder="Свойство" />
              <Input v-model="field.key" type="key" placeholder="Значение" />
              <Button @click="removeField(index)" variant="destructive" type="removed">
                Удалить
              </Button>
            </div>
            <Button @click="addField" type="added" class="mt-5"> Добавить </Button>

            <p class="mt-5 mb-2">Картинка комплектующего</p>
            <div class="flex items-center justify-center w-full">
              <label
                for="dropzone-file"
                class="flex flex-col items-center justify-center w-full h-64 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 dark:hover:bg-bray-800 dark:bg-gray-700 hover:bg-gray-100 dark:border-gray-600 dark:hover:border-gray-500 dark:hover:bg-gray-600"
              >
                <div class="flex flex-col items-center justify-center pt-5 pb-6">
                  <svg
                    class="w-8 h-8 mb-4 text-gray-500 dark:text-gray-400"
                    aria-hidden="true"
                    xmlns="http://www.w3.org/2000/svg"
                    fill="none"
                    viewBox="0 0 20 16"
                  >
                    <path
                      stroke="currentColor"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M13 13h3a3 3 0 0 0 0-6h-.025A5.56 5.56 0 0 0 16 6.5 5.5 5.5 0 0 0 5.207 5.021C5.137 5.017 5.071 5 5 5a4 4 0 0 0 0 8h2.167M10 15V6m0 0L8 8m2-2 2 2"
                    />
                  </svg>
                  <p
                    class="mb-2 text-sm text-gray-500 dark:text-gray-400"
                    style="text-align: center"
                  >
                    <span class="font-semibold">Перетащите изображение товара в это окно.</span
                    ><br />
                  </p>

                  <p class="text-xs text-gray-500 dark:text-gray-400 mb-2">
                    (только форматы .png, .jpg)
                  </p>
                  <p
                    class="mt-3 text-sm text-gray-500 dark:text-gray-400"
                    style="text-align: center"
                  >
                    <span class="font-semibold"><em>Для выбора нажмите на это окно.</em></span>
                  </p>
                </div>
                <input @change="handleFileUpload" id="dropzone-file" type="file" class="hidden" />
              </label>
            </div>
            <div class="flex justify-between mt-5">
              <Button @click="backPage"> Вернуться </Button>
              <Button @click="saveData"> Добавить </Button>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

import { useRouter } from 'vue-router'
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'
import axios from 'axios'
import { Terminal } from 'lucide-vue-next'
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

const components = ref('')
const componentsCategory = ref('')

const testText = ref('ABOBA')

// ниже логика добавления и удаления свойств

const fields = ref([{ value: '', key: '' }])

const addField = () => {
  fields.value.push({ value: '', key: '' })
}

const removeField = (index) => {
  fields.value.splice(index, 1)
}

const coverImage = ref(null)

let successAlert = ref(false)

const handleFileUpload = (event) => {
  const file = event.target.files[0]
  if (file) {
    coverImage.value = file
    console.log('Выбранное изображение:', file.name)
  }
}

const backPage = () => {
  router.push('/componentsView')
}

async function saveData() {
  // Создаем экземпляр FormData для отправки данных формы
  const formData = new FormData()
  formData.append('name_components', components.value)
  formData.append('id_category', componentsCategory.value)
  formData.append('property_components', JSON.stringify(fields.value))
  formData.append('img_components', coverImage.value)

  for (let [name, value] of formData) {
    console.log(`${name} = ${value}`)
  }

  try {
    const response = await axios.post('http://localhost/addComponents.php', formData, {
      headers: {
        'Content-Type': 'multipart/form-data' // Указываем правильный заголовок для отправки файлов
      }
    })
    const status = response.data.status

    console.log(response.data)
    console.log('Ответ от сервера:', status)

    if (status == 'success') {
      router.push('/componentsView')
    } else {
      alert('Заполните все поля и попробуйте снова')
    }
  } catch (error) {
    console.error('Ошибка при отправке данных:', error)
  }
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@800&display=swap');
.text-inter-title {
  font-family: 'Inter', sans-serif;
  font-size: 20px;
  font-weight: 500;
  color: #0f172a;
}
</style>
