<template>
  <div class="flex items-center justify-center h-screen">
    <div class="flex flex-col">
      <div class="flex flex-col justify-centre items-start">
        <Button @click="backToAdminPanel" class="ml-[-15px] mt-5" variant="link">Назад</Button>
      </div>
      <div class="flex justify-between items-center">
        <h1 class="font-bold">Список комплектующих</h1>
        <Button @click="goToAddComponents" class="" variant="link">Добавить</Button>
      </div>

      <div class="relative w-full max-w-sm items-center mb-4">
        <Input
          v-model="query"
          id="search"
          type="search"
          placeholder="Поиск по товару..."
          class="pl-10 w-[600px]"
        />

        <span class="absolute start-0 inset-y-2 flex px-2">
          <Search class="size-6 text-muted-foreground" />
        </span>
      </div>

      <ScrollArea class="h-[600px] w-[600px] rounded-md border p-4">
        <div class="flex flex-col gap-12 items-center">
          <div
            v-for="item in queryItems"
            :key="item.id_components"
            class="w-[500px] h-[10 0px] border-2 border-gray-300 rounded-lg"
          >
            <div class="flex flex-col justify-center mt-4 ml-6 cursor-default">
              <p class="flex flex-wrap text-xs font-semibold text-slate-700 text-wrap">
                {{ item.name_components }}
              </p>
              <div class="flex justify-end gap-6 mr-4">
                <router-link :to="{ path: `/componentsPage/${item.id_components}` }">
                  <SquarePen
                    color="#18dc87"
                    size="24px"
                    class="mb-2 hover:bg-green-100 hover:rounded-sm cursor-pointer"
                  />
                </router-link>

                <CircleX
                  @click="deleteComponents(item.id_components)"
                  color="#dc182c"
                  size="24px"
                  class="mb-2 hover:bg-red-100 hover:rounded-full cursor-pointer"
                />
              </div>
            </div>
          </div>
        </div>
      </ScrollArea>
    </div>
  </div>
</template>

<script setup>
import { ScrollArea } from '@/components/ui/scroll-area'
import { CircleX } from 'lucide-vue-next'
import { CircleCheck } from 'lucide-vue-next'
import { ref, onMounted, computed } from 'vue'
import axios from 'axios'
import Button from '@/components/ui/button/Button.vue'
import { useRoute, useRouter } from 'vue-router'
import { SquarePen } from 'lucide-vue-next'
import { Input } from '@/components/ui/input'
import { Search } from 'lucide-vue-next'

const router = useRouter()

const backToAdminPanel = () => {
  router.push('/mainAdmin')
}

const goToAddComponents = () => {
  router.push('/addComponentsPage')
}

const query = ref('')

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

const items = ref([])

const loadComponents = async () => {
  try {
    const response = await axios.get('http://localhost/getComponents.php')
    items.value = response.data
  } catch (err) {
    console.error(err)
  }
}

onMounted(loadComponents)

const deleteComponents = async (idScore) => {
  const reviewFormData = new FormData()

  console.log(idScore)

  reviewFormData.append('id_score', idScore)

  try {
    const response = await axios.post('http://localhost/deleteComponents.php', reviewFormData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })

    console.log(response.data)
    // После успешного удаления вызываем функцию для загрузки отзывов снова
    loadComponents()
  } catch (error) {
    console.error('Ошибка при отправке данных:', error)
  }
}
</script>

<style lang="scss" scoped></style>
