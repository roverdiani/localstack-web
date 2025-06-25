<template>
  <div class="about-view">
    <AboutComponent />
  </div>
</template>

<script>
import AboutComponent from '@/components/AboutComponent.vue'

export default {
  name: 'AboutView',
  components: {
    AboutComponent
  }
}
</script>

<style scoped>
.about-view {
  padding: 20px;
}
</style>
