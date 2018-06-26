<template>
    <v-layout row
              wrap>
        <v-flex xs12>
            <crud resource="lpos"
                  :creatable="false"
                  :manager="manager"
                  :extraOverflowActions="extraOverflowActions"/>
        </v-flex>
    </v-layout>
</template>

<script>
  import Crud from './Crud'
  import CrudBase from './CrudBase.vue'

  export default {
    name: 'LPOs',
    extends: CrudBase,
    components: {Crud},
    data () {
      return {
        extraOverflowActions: [
          {
            name: 'Upload Delivery Note',
            color: 'primary'
          }
        ],
      }
    },
    methods: {
      initialize () {
        let that = this
        this.manager.deletable = (item) => {
          return false
        }
        this.manager.editable = (item) => {
          return false
        }
        this.manager.toValue = (header, item) => {
          if (header.value === 'supplier') {
            return item.supplier ? item.supplier.name : that.defaultValue
          } else {
            return item[header.value] ? item[header.value] : that.defaultValue
          }
        }
      }
    }

  }
</script>

<style scoped>

</style>