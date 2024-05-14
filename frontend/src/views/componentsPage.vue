<template>
  <div class="flex flex-col gap-8 h-full p-16">
    <main class="flex h-full gap-8">
      <div class="h-full w-full flex flex-col gap-10">
        <div class="flex flex-row w-full">
          <div class="px-10 py-5 w-full">
            <Button @click="backPage" variant="link" class="ml-[-16px]"> Вернуться </Button>
            <p class="text-xl text-inter-title mb-1">Редактирование комплектующего</p>

            <br />

            <label class="text-gray-500">{{ items.name_components }}</label>
            <div class="w-[150px] mt-5">
              <img
                :src="`http://localhost/images/${items.img_components}`"
                alt="Пусто"
                class="rounded-md object-cover max-w-full"
              />
            </div>
            <div class="flex gap-4">
              <Input v-model="components" class="mt-5 mb-5" placeholder="Введите новое название" />
              <Button class="mt-5"> Изменить </Button>
            </div>

            <div class="flex gap-4">
              <Select
                v-model="componentsCategory"
                class="block appearance-none w-full bg-white border border-gray-300 hover:border-gray-500 px-4 py-2 pr-8 rounded shadow leading-tight focus:outline-none focus:shadow-outline"
              >
                <SelectTrigger class="min-w-[100px]">
                  <SelectValue :placeholder="items.name_category" />
                </SelectTrigger>
                <SelectContent>
                  <SelectGroup>
                    <SelectItem :value="'1'"> Материнская плата </SelectItem>
                    <SelectItem :value="'2'"> Видеокарта </SelectItem>
                    <SelectItem :value="'3'"> Оперативная память </SelectItem>
                    <SelectItem :value="'4'"> Процессор </SelectItem>
                  </SelectGroup>
                </SelectContent>
              </Select>
              <Button @click="changeCategory"> Изменить </Button>
            </div>

            <div
              v-for="(field, index) in fields"
              :key="index"
              class="flex w-full max-w-full items-center gap-1.5 mt-5"
            >
              <Input
                v-model="field.value_property"
                type="value"
                :placeholder="field.value_property"
              />
              <Input v-model="field.key_property" type="key" :placeholder="field.key_property" />
              <Button @click="removeField(index)" variant="destructive" type="removed">
                Удалить
              </Button>
            </div>
            <div class="flex flex-wrap gap-4">
              <Button @click="addField" type="added" class="mt-5"> Добавить </Button>
              <Button
                @click="saveProperty"
                type="added"
                class="mt-5 bg-green-500 hover:bg-green-700"
              >
                Сохранить
              </Button>
            </div>

            <p class="mt-5 mb-2">Изменить картинку комплектующего</p>
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
            <div class="flex justify-end mt-5">
              <Button @click="changeIMG"> Изменить </Button>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup>
import { useRoute, useRouter } from 'vue-router'
import { ref, onMounted } from 'vue'
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
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'
import { uuid } from 'vue-uuid'

const router = useRouter()

// переходы

const backPage = () => {
  router.push('/componentsView')
}

// сюда сохраняем значение из поля
const components = ref('')

const route = useRoute()

const items = ref({})
const componentsCategory = ref('')

const fields = ref([])

const addField = () => {
  const uniqueId = Math.floor(Math.random() * 1000000)
  fields.value.push({
    id_property: uniqueId,
    value_property: '',
    key_property: '',
    id_components: route.params.id
  })
  console.log(uniqueId)
  console.log(fields.value)
}

const removeField = (index) => {
  fields.value.splice(index, 1)
  console.log(fields.value)
}

// изменяем категорию

const changeCategory = async () => {
  const categoryFormData = new FormData()

  categoryFormData.append('id_category', componentsCategory.value)
  categoryFormData.append('id_components', route.params.id)

  try {
    const response = await axios.post('http://localhost/updateCategory.php', categoryFormData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })
    console.log(response.data)
  } catch (error) {
    console.error('Ошибка при отправке данных:', error)
  }
}

// сохраняем свойства товара

const saveProperty = async () => {
  try {
    const response = await axios.post(
      'http://localhost/updateComponentsID.php',
      JSON.stringify(fields.value),
      {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      }
    )
    console.log(response.data)
  } catch (error) {
    console.error('Ошибка при отправке данных:', error)
  }
}

// получаем данные по карточке

const apiFormData = new FormData()
apiFormData.append('id_components', route.params.id)

const fetchData = async () => {
  try {
    const response = await axios.post('http://localhost/postComponentsID.php', apiFormData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })

    console.log(response.data)

    items.value = response.data.components

    fields.value = response.data.properties

    switch (items.value.name_category) {
      case 'Материнская плата':
        componentsCategory.value = '1'
        break
      case 'Видеокарта':
        componentsCategory.value = '2'
        break
      case 'Оперативная память':
        componentsCategory.value = '3'
        break
      case 'Процессор':
        componentsCategory.value = '4'
        break
      default:
        componentsCategory.value = null
    }
  } catch (error) {
    console.error('Ошибка при отправке данных:', error)
  }
}

const changeIMG = () => {
  console.log('Изменили картинку')
}

onMounted(() => {
  fetchData()
})
</script>

<style lang="scss" scoped></style>
