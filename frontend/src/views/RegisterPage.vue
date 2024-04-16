<template>
  <div class="flex items-center justify-center h-screen">
    <div class="flex flex-col items-center gap-10">
      <siteLogo class="mb-1"></siteLogo>
      <div class="border-t h-5 w-96 border-orange-300"></div>

      <div class="grid w-full max-w-sm items-center gap-1.5">
        <Label for="email">Почта</Label>
        <Input id="email" type="email" placeholder="Введите вашу почту" />
        <Label class="mt-5" for="login">Логин</Label>
        <Input id="login" type="login" placeholder="Введите ваш логин" />
        <Label class="mt-5" for="FIO">ФИО</Label>
        <Input id="FIO" type="FIO" placeholder="Введите ваше ФИО" />
        <Label class="mt-5" for="password">Пароль</Label>
        <Input id="password" type="password" placeholder="Введите ваш пароль" />
        <div class="flex mt-5 gap-2">
          <Button @click="goToMainPage" class="bg-orange-400 w-64 text-white" variant="outline">
            Зарегистрироваться
          </Button>
          <Button @click="gotToLogin" class="w-32" variant="secondary"> Войти </Button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import siteLogo from '@/components/custom/profile/siteLogo.vue'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import { Button } from '@/components/ui/button'
import { useRoute, useRouter } from 'vue-router'

const router = useRouter()

const gotToLogin = () => {
  router.push('/')
}

// Сделать логику для регистрации

const goToMainPage = () => {
  router.push('MainPage')
}
</script>

<style lang="scss" scoped></style>
