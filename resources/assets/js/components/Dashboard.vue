<template>
    <v-layout row
              wrap>
        <v-flex xs12>
            <supplier-dashboard v-if="isSupplier()"/>
            <client-dashboard v-else/>
        </v-flex>
    </v-layout>
</template>

<script>
  import Base from './Base.vue'
  import ClientDashboard from './ClientDashboard'
  import AdminDashboard from './AdminDashboard'
  import SupplierDashboard from './SupplierDashboard'

  export default {
    name: 'dashboard',
    components: {
      SupplierDashboard,
      ClientDashboard
    },
    extends: Base

  }
</script>

<style scoped>

</style>