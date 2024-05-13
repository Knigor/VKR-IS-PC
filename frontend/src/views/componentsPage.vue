<template>
  <div>
    <h1>АБОБА</h1>
    <p>{{ route.params }}</p>

    <p>{{ items[0] }}</p>
  </div>
</template>

<script setup>
import { useRoute, useRouter } from 'vue-router'
import { ref, onMounted } from 'vue'
import axios from 'axios'

const router = useRouter()

const route = useRoute()

const items = ref([])

onMounted(async () => {
  try {
    const response = await axios.get('http://localhost/getComponents.php')
    items.value = response.data
  } catch (err) {
    console.error(err)
  }
})
</script>

<style lang="scss" scoped></style>
