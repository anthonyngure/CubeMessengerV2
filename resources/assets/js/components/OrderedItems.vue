<template>
    <v-layout row
              wrap>
        <v-flex xs12>
            <crud resource="orderItems"
                  ref="crud"
                  :manager="manager"
                  :extra-top-actions="extraTopActions"
                  :creatable="false"
                  :filters="isSupplier() ? supplierFilters : adminAndOperationsFilters"/>
            <v-dialog v-model="selectingItems" max-width="600px">
                <v-card>
                    <v-card-text>
                        <connection-manager ref="connectionManager" v-model="connecting"/>
                        <v-data-table
                                v-model="selectedItems"
                                :headers="headers"
                                :items="items"
                                select-all
                                item-key="id"
                                hide-actions>
                            <template slot="items" slot-scope="props">
                                <tr :active="props.selected" @click="props.selected = !props.selected">
                                    <td>
                                        <v-checkbox
                                                :input-value="props.selected"
                                                primary
                                                hide-details/>
                                    </td>
                                    <td>{{ props.item.product.name }}</td>
                                    <td>{{ props.item.product.price }}</td>
                                </tr>
                            </template>
                        </v-data-table>

                        <guide text="It will be considered that you cannot deliver the items that are not selected"/>
                    </v-card-text>
                    <v-card-actions>
                        <v-spacer/>
                        <v-btn color="red" @click.native="selectingItems = false" flat
                               :disabled="connecting">Close
                        </v-btn>
                        <v-spacer/>
                        <v-btn color="primary" @click.native="generateLPO"
                               :disabled="connecting || !selectedItems.length">Submit
                        </v-btn>
                    </v-card-actions>
                </v-card>
            </v-dialog>
        </v-flex>
    </v-layout>
</template>

<script>
  import Crud from './Crud'
  import CrudBase from './CrudBase.vue'
  import ConnectionManager from './ConnectionManager'
  import Guide from './Guide'

  export default {
    name: 'OrderedItems',
    extends: CrudBase,
    components: {
      Guide,
      ConnectionManager,
      Crud
    },
    data () {
      return {
        connecting: false,
        selectingItems: false,
        selectedItems: [],
        adminAndOperationsFilters: [
          {value: 'PENDING_LPO', name: 'Pending LPO'},
          {value: 'ACCEPTED_BY_SUPPLIER', name: 'Accepted By Supplier'},
          {value: 'REJECTED_BY_SUPPLIER', name: 'Rejected By Supplier'},
          {value: 'RECEIVED_FROM_SUPPLIER', name: 'Received From Supplier'},
        ],
        supplierFilters: [
          {value: 'PENDING_LPO', name: 'Pending LPO'},
          {value: 'ACCEPTED_BY_SUPPLIER', name: 'Accepted'},
          {value: 'REJECTED_BY_SUPPLIER', name: 'Rejected'},
          {value: 'RECEIVED_FROM_SUPPLIER', name: 'Delivered'},
        ],
        extraTopActions: [
          {
            name: 'Select Items To Supply',
            key: 'generateLPO'
          }
        ],
        items: [],
        headers: [
          {text: 'Name', value: 'name'},
          {text: 'Price', value: 'price'},
        ]
      }
    },
    methods: {
      closeGeneratingLPODialog () {
        this.$refs.connectionManager.reset()
        this.selectingItems = false
        this.selectedItems = []
        this.item = null
      },
      generateLPO () {
        let that = this
        let orderItemIds = []
        for (let orderItem of this.selectedItems) {
          orderItemIds.push(orderItem.id)
        }
        this.$refs.connectionManager.post('orderItems/generateLPO', {
          onSuccess (response) {
            that.$refs.crud.setItems(response.data.data)
            that.closeGeneratingLPODialog()
          }
        }, {
          items: orderItemIds.join(',')
        })
      },
      initialize () {
        let that = this
        this.manager.deletable = (item) => {
          return false
        }
        this.manager.editable = (item) => {
          return false
        }
        this.manager.toValue = (header, item) => {
          if (header.value === 'priceAtPurchase') {
            return item.priceAtPurchase ? that.$utils.formatMoney(item.priceAtPurchase) : that.defaultValue
          } else if (header.value === 'product') {
            return item.product ? item.product.name : that.defaultValue
          }
          else if (header.value === 'amount') {
            return that.$utils.formatMoney(item.priceAtPurchase * item.quantity)
          }
          else if (header.value === 'supplier') {
            return (item.product && item.product.supplier) ? item.product.supplier.name : that.defaultValue
          } else {
            return item[header.value] ? item[header.value] : that.defaultValue
          }
        }
        this.manager.showTopAction = (action, items, filter) => {
          if (action.key === 'generateLPO' && filter && this.isSupplier()) {
            return filter.value === 'PENDING_LPO' && items.length
          } else {
            return false
          }
        }
        this.manager.onTopAction = (action, items, filter) => {
          that.items = items
          that.selectingItems = action.key === 'generateLPO'
        }
      }
    },
    mounted () {

    }

  }
</script>

<style scoped>

</style>