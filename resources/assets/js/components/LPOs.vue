<template>
    <v-layout row
              wrap>
        <v-flex xs12>
            <crud resource="lpos"
                  ref="crud"
                  :creatable="false"
                  :manager="manager"
                  :filters="isSupplier() ? supplierFilters : adminAndOperationsFilters"
                  :hiddenHeaders="isSupplier() ? supplierHiddenHeaders : []"
                  :extraInlineActions="isAdmin() || isOperations() ? extraInlineActions : []"/>
        </v-flex>

        <v-dialog v-model="uploadingDeliveryNote" max-width="800px" persistent>
            <v-card>
                <v-card-text>
                    <connection-manager ref="connectionManager" v-model="connecting"/>
                    <guide text="Select all the items that you have confirmed have been delivered"/>
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
                                <td>{{ props.item.orderItem.product.name }}</td>
                                <td>{{ props.item.orderItem.priceAtPurchase }}</td>
                                <td>{{ props.item.orderItem.quantity }}</td>
                                <td>{{ $utils.formatMoney((props.item.orderItem.quantity *
                                    props.item.orderItem.priceAtPurchase)) }}
                                </td>
                            </tr>
                        </template>
                    </v-data-table>
                    <file-picker name="deliveryNote" :disabled="connecting || !selectedItems.length"
                                 label="Select Delivery Note File..."
                                 @onFilePicked="onDeliveryNotePicked"/>
                    <file-picker name="invoice" :disabled="connecting || !selectedItems.length"
                                 label="Select Invoice File..."
                                 @onFilePicked="onInvoicePicked"/>

                </v-card-text>
                <v-card-actions>
                    <v-spacer/>
                    <v-btn color="red" @click.native="uploadingDeliveryNote = false" flat
                           :disabled="connecting">Close
                    </v-btn>
                    <v-spacer/>
                    <v-btn color="primary" @click.native="uploadDeliveryNote"
                           :disabled="connecting || !selectedItems.length || !deliveryNoteFile || !invoiceFile">
                        Submit
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </v-layout>
</template>

<script>
  import Crud from './Crud'
  import CrudBase from './CrudBase.vue'
  import UploadButton from './UploadButton'
  import Guide from './Guide'
  import ConnectionManager from './ConnectionManager'
  import FilePicker from './FilePicker'

  export default {
    name: 'LPOs',
    extends: CrudBase,
    components: {
      FilePicker,
      ConnectionManager,
      Guide,
      UploadButton,
      Crud
    },
    data () {
      return {
        uploadingDeliveryNote: false,
        connecting: false,
        selectedItems: [],
        items: [],
        item: null,
        adminAndOperationsFilters: [
          {value: 'pending', name: 'Pending'},
          {value: 'received', name: 'Received'},
        ],
        supplierFilters: [
          {value: 'pending', name: 'New'},
          {value: 'received', name: 'Delivered'},
        ],
        headers: [
          {text: 'Name', value: 'name'},
          {text: 'Price', value: 'price'},
          {text: 'Quantity', value: 'quantity'},
          {text: 'Total', value: 'total'},
        ],
        extraInlineActions: [
          {
            name: 'Upload Delivery Note & Invoice',
            color: 'accent',
            key: 'uploadDocuments'
          },
          {
            name: 'View',
            color: 'primary',
            key: 'view'
          }
        ],
        supplierHiddenHeaders: [
          {text: 'Supplier'}
        ],
        deliveryNoteFile: null,
        invoiceFile: null,
      }
    },
    methods: {
      closeUploadingDeliveryNoteDialog () {
        this.$refs.connectionManager.reset()
        this.uploadingDeliveryNote = false
        this.selectedItems = []
        this.item = null
      },
      uploadDeliveryNote () {
        let itemIds = []
        for (let item of this.selectedItems) {
          itemIds.push(item.id)
        }
        let formData = new FormData()
        formData.append('deliveryNoteFile', this.deliveryNoteFile.$file)
        formData.append('invoiceFile', this.invoiceFile.$file)
        formData.append('items', itemIds.join(','))
        this.$utils.log(formData)
        let that = this
        this.$refs.connectionManager.upload('lpos/' + this.item.id + '/deliveryDocuments', {
          onSuccess (response) {
            that.$refs.crud.setItems(response.data.data)
            that.closeUploadingDeliveryNoteDialog()
            //alert(JSON.stringify(response))
          }
        }, formData)
      },
      onDeliveryNotePicked (file) {
        this.deliveryNoteFile = file
      },
      onInvoicePicked (file) {
        this.invoiceFile = file
        this.$utils.log(file.$file)
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
          if (header.value === 'supplier') {
            return item.supplier ? item.supplier.name : that.defaultValue
          } else if (header.value === 'deliveryNoteReceivedBy') {
            return item.deliveryNoteReceivedBy ? item.deliveryNoteReceivedBy.name : that.defaultValue
          }
          else {
            return item[header.value] ? item[header.value] : that.defaultValue
          }
        }
        this.manager.hideHeader = (header, filter) => {
          return (header.value === 'deliveryNoteReceivedBy' || header.value === 'deliveryNoteReceivedAt')
            && filter.value === 'pending'
        }
        this.manager.onInlineActionClicked = (action, item, filter) => {
          //that.$utils.log(item)
          if (action.key === 'view') {
            that.$refs.crud.viewItem(item)
          } else {
            that.items = item.items
            that.item = item
            that.uploadingDeliveryNote = true
          }
        }
        this.manager.showInlineAction = (action, item, filter) => {
          if (action.key === 'uploadDocuments') {
            return !item.deliveryNotePath && (that.isOperations() || that.isAdmin())
          }
          return true
        }
      }
    }

  }
</script>

<style scoped>

</style>