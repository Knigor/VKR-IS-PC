<template>
  <div class="flex items-center justify-center h-screen">
    <div class="flex flex-col gap-6">
      <h1 class="font-semibold">Добро пожаловать в панель администратора</h1>
      <div class="flex justify-between">
        <Button @click="backToMain" class="ml-[-15px]" variant="link">Назад</Button>
        <Button @click="goToReviews" class="max-w-[150px]">Комментарии</Button>
        <Button @click="goToComponents" class="max-w-[150px]">Комплектующие</Button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { Button } from '@/components/ui/button'
import { useRoute, useRouter } from 'vue-router'

const router = useRouter()

const backToMain = () => {
  router.push('/')
}

const goToComponents = () => {
  router.push('/componentsView')
}

const goToReviews = () => {
  router.push('/reviewsPanel')
}
</script>

<style lang="scss" scoped></style>
