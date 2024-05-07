<template>
  <div class="flex items-center justify-center h-screen">
    <div class="flex flex-col items-center gap-10">
      <siteLogo class="mb-1"></siteLogo>
      <div class="border-t h-5 w-96 border-orange-300"></div>

      <div class="grid w-full max-w-sm items-center gap-1.5">
        <form class="w-96 space-y-6" @submit="onSubmit">
          <FormField v-slot="{ componentField: LoginField }" name="login">
            <FormItem>
              <FormLabel>Логин</FormLabel>
              <FormControl>
                <Input type="text" placeholder="Введите ваш логин" v-bind="LoginField" />
              </FormControl>
              <FormMessage />
            </FormItem>
          </FormField>
          <FormField v-slot="{ componentField: PasswordField }" name="password">
            <FormItem>
              <FormLabel>Пароль</FormLabel>
              <FormControl>
                <Input type="password" placeholder="Введите ваш пароль" v-bind="PasswordField" />
              </FormControl>
              <FormMessage />
            </FormItem>
          </FormField>

          <div class="flex">
            <Toaster />
            <Button type="submit" class="bg-orange-400 w-32 text-white mr-5" variant="outline">
              Войти
            </Button>
            <Button @click="goToRegister" class="w-64" variant="secondary">
              Зарегистрироваться
            </Button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import siteLogo from '@/components/custom/profile/siteLogo.vue'
import { useRoute, useRouter } from 'vue-router'
import { Toaster } from '@/components/ui/toast'
import { useToast } from '@/components/ui/toast/use-toast'
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'
import { Label } from '@/components/ui/label'
import { toTypedSchema } from '@vee-validate/zod'
import { useForm } from 'vee-validate'
import * as z from 'zod'
import { h } from 'vue'
import {
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage
} from '@/components/ui/form'
import { ref } from 'vue'
import axios from 'axios'

// Переход на страницу регистрации

const router = useRouter()

const goToRegister = () => {
  router.push('/RegisterPage')
}

// Валидация полей ввода

const formSchema = toTypedSchema(
  z.object({
    login: z
      .string({ required_error: 'Поле не должно быть пустым' })

      .min(1, { message: 'Строка не должна быть пустой' })
      .max(20, { message: 'Логин должен содержать не больше 20 символов' })
      .regex(/^[a-z0-9_-]{3,20}$/, { message: 'Некоректный логин' }),
    password: z
      .string({ required_error: 'Поле не должно быть пустым' })
      .min(3, { message: 'Пароль должен содержать минимум 3 символа' })
      .max(20, { message: 'Пароль должен содержать не больше 20 символов' })
  })
)

const { handleSubmit, errors } = useForm({
  validationSchema: formSchema
})

const onSubmit = handleSubmit(async (formData) => {
  const apiFormData = new FormData()
  const userData = formData

  apiFormData.append('login', userData.login)
  apiFormData.append('password', userData.password)

  try {
    const response = await axios.post('http://localhost/postAuthAPI.php', apiFormData, {
      headers: {
        'Content-Type': 'multipart/form-data'
      }
    })
    console.log(response.data)

    if (response.data.status == 'success') {
      localStorage.clear()

      localStorage.setItem('email', response.data.email)
      localStorage.setItem('id_user', response.data.id_user)
      localStorage.setItem('role', response.data.role)
      localStorage.setItem('full_name', response.data.full_name)
      router.push('/')
    }

    // Высплывашка тостер

    const { toast } = useToast()

    if (response.data.status == 'error') {
      toast({
        description: 'Ошибка авторизации, введен не правильный логин или пароль',
        variant: 'destructive'
      })
    }
  } catch (error) {
    console.error('Ошибка при отправке данных:', error)
  }
})

// Сделать логику для авторизации
</script>

<style lang="scss" scoped></style>
