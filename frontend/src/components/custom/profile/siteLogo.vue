<script setup>
import { defineProps } from 'vue'
import { useRoute, useRouter } from 'vue-router'

const router = useRouter()

const goToMainPage = () => {
  console.log('Клик')
  router.push('/mainPage')
}

defineProps({
  isVertical: Boolean // Определяет вид логотипа: вертикальное или горизонтальное отображение
})
</script>

<template>
  <!-- Контейнер для всего лого -->
  <div
    @click="goToMainPage"
    class="flex items-center h-[64px] gap-4 w-fit cursor-default"
    :class="{ 'flex-col': isVertical }"
  >
    <!-- Контейнер только для лого -->
    <div class="flex items-center max-w-[284px]">
      <!-- Круг -->
      <div class="min-h-24 min-w-24 max-h-24 max-w-24 rounded-full bg-orange-400"></div>
      <!-- Текст логотипа -->
      <h1 class="relative -left-12 font-bold text-[24px] whitespace-nowrap">
        <span class="text-white">Компле</span>ктующие мечты
      </h1>
    </div>
    <!-- <p class="text-lg font-base">Храните знания и учитесь!</p> -->
  </div>
</template>

<style>
.-left-12 {
  left: -5.7rem;
}
</style>
