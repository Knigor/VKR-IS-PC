<template>
  <div>
    <h1>АБОБА</h1>
    <p>{{ route.params }}</p>
  </div>
</template>

<script setup>
import { useRoute, useRouter } from 'vue-router'

const router = useRouter()

const route = useRoute()
</script>

<style lang="scss" scoped></style>
