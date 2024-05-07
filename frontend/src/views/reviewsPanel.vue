<template>
  <div class="flex items-center justify-center h-screen">
    <div class="flex flex-col">
      <div class="flex flex-col justify-centre items-start">
        <Button @click="backToAdminPanel" class="ml-[-15px]" variant="link">Назад</Button>
        <h1 class="font-bold">Комментарии пользователей</h1>
      </div>

      <ScrollArea class="h-[600px] w-[950px] rounded-md border p-4">
        <div
          v-for="review in reviews"
          :key="review.id_score"
          class="flex flex-col gap-8 items-center"
        >
          <div
            class="m-4 block rounded-lg bg-white p-6 shadow-lg dark:bg-neutral-800 dark:shadow-black/20"
          >
            <!--Testimonial-->
            <div>
              <div class="md:flex md:flex-row">
                <div
                  class="mx-auto mb-6 flex w-36 items-center justify-center md:mx-0 md:w-96 lg:mb-0"
                >
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
                  <div class="flex items-center justify-between">
                    <p class="mb-2 text-xl font-semibold text-neutral-800 dark:text-neutral-200">
                      {{ review.fio }}
                    </p>
                    <div class="flex gap-4">
                      <CircleCheck
                        @click="updateReview(review.id_score)"
                        color="#18dc87"
                        size="32px"
                        class="mb-2 hover:bg-green-100 hover:rounded-full cursor-pointer"
                      />
                      <CircleX
                        @click="deleteReview(review.id_score)"
                        color="#dc182c"
                        size="32px"
                        class="mb-2 hover:bg-red-100 hover:rounded-full cursor-pointer"
                      />
                    </div>
                  </div>
                </div>
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

const router = useRouter()

const backToAdminPanel = () => {
  router.push('/mainAdmin')
}

let reviews = ref([])

const loadReviews = async () => {
  try {
    const response = await axios.get('http://localhost/getALLReviews.php')
    reviews.value = response.data
    console.log(response.data)
  } catch (err) {
    console.error(err)
  }
}

onMounted(loadReviews)

const deleteReview = async (idScore) => {
  const reviewFormData = new FormData()

  reviewFormData.append('id_score', idScore)

  try {
    const response = await axios.post('http://localhost/deleteReviews.php', reviewFormData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })

    console.log(response.data)
    // После успешного удаления вызываем функцию для загрузки отзывов снова
    loadReviews()
  } catch (error) {
    console.error('Ошибка при отправке данных:', error)
  }
}

const updateReview = async (idScore) => {
  const reviewFormData = new FormData()

  reviewFormData.append('id_score', idScore)

  try {
    const response = await axios.post('http://localhost/updateReview.php', reviewFormData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })

    console.log(response.data)
    loadReviews()
  } catch (error) {
    console.error('Ошибка при отправке данных:', error)
  }
}
</script>

<style lang="scss" scoped></style>
