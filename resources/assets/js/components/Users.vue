<template >
  <v-layout row
            wrap >
    <v-flex xs12 >
      <admin-users v-if="isAdmin() || isOperations()"/>
      <client-users v-else/>
    </v-flex >
  </v-layout >
</template >

<script >

import Base from './Base.vue'
import AdminUsers from './AdminUsers'
import ClientUsers from './ClientUsers'

export default {
  name: 'Users',
  extends: Base,
  components: {ClientUsers, AdminUsers},
  methods: {}
}
</script >

<style scoped >

</style >