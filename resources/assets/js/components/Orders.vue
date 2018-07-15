<template>
    <v-layout row
              wrap>
        <v-flex xs12>
            <crud resource="orders"
                  ref="crud"
                  :manager="manager"
                  :filters="(isAdmin() || isOperations()) ? adminAndOperationsFilters : clientFilters"
                  :creatable="false"
                  :extra-inline-actions="extraInlineActions"
                  :custom-view-dialog="true"/>
        </v-flex>

        <!--View Dialog-->
        <v-dialog v-model="viewDialogHere" max-width="800px">
            <v-card v-if="item">
                <v-card-text>

                    <connection-manager ref="connectionManager"
                                        v-model="connecting"/>

                    <v-data-table
                            hide-headers
                            hide-actions
                            :headers="viewItemHeaders"
                            :items="viewableHeaders">
                        <template slot="items"
                                  slot-scope="props">
                            <td>{{props.item.text}}</td>
                            <td>{{manager.toValue(props.item, item)}}</td>
                        </template>
                    </v-data-table>
                    <v-data-table
                            :items="item.items"
                            hide-actions
                            item-key="id"
                            :style="'max-height: '+($vuetify.breakpoint.height * 0.30)+'px;'"
                            class="scroll-y"
                            :headers="productHeaders">
                        <template slot="items" slot-scope="props">
                            <td>{{props.item.product.name}}</td>
                            <td>{{$utils.formatMoney(props.item.priceAtPurchase)}}</td>
                            <td>{{props.item.quantity}}</td>
                            <td>{{$utils.formatMoney(props.item.priceAtPurchase*props.item.quantity)}}</td>
                        </template>
                    </v-data-table>
                </v-card-text>
                <v-card-actions>
                    <v-spacer/>
                    <v-btn color="red darken-1"
                           flat
                           :disabled="connecting"
                           @click.native="close">Close
                    </v-btn>
                    <v-spacer/>
                    <v-btn flat
                           color="red"
                           small
                           outline
                           :disabled="connecting"
                           v-if="showRejectButton(item)"
                           @click.native="approveOrReject('reject')">
                        <v-icon left
                                small>close
                        </v-icon>
                        Reject
                    </v-btn>
                    <v-btn flat
                           color="success"
                           small
                           outline
                           :disabled="connecting"
                           v-if="showApproveButton(item)"
                           @click.native="approveOrReject('approve')">
                        <v-icon left
                                small>check_circle
                        </v-icon>
                        Approve
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <!--Dispatch dialog-->
        <v-dialog v-model="dispatching" max-width="800px">
            <v-card v-if="dispatchingItem">
                <v-card-text>
                    <guide text="The order will be assigned to the available rider!"/>
                    <connection-manager ref="dispatchConnectionManager"
                                        v-model="connecting"/>
                    <v-data-table
                            hide-headers
                            hide-actions
                            :headers="viewItemHeaders"
                            :items="viewableHeaders">
                        <template slot="items"
                                  slot-scope="props">
                            <td>{{props.item.text}}</td>
                            <td>{{manager.toValue(props.item, dispatchingItem)}}</td>
                        </template>
                    </v-data-table>
                    <v-data-table
                            :items="dispatchingItem.items"
                            hide-actions
                            item-key="id"
                            :style="'max-height: '+($vuetify.breakpoint.height * 0.30)+'px;'"
                            class="scroll-y"
                            :headers="productHeaders">
                        <template slot="items" slot-scope="props">
                            <td>{{props.item.product.name}}</td>
                            <td>{{$utils.formatMoney(props.item.priceAtPurchase)}}</td>
                            <td>{{props.item.quantity}}</td>
                            <td>{{$utils.formatMoney(props.item.priceAtPurchase*props.item.quantity)}}</td>
                        </template>
                    </v-data-table>
                </v-card-text>
                <v-card-actions>
                    <v-spacer/>
                    <v-btn color="red" @click.native="dispatching = false" flat
                           :disabled="connecting">Close
                    </v-btn>
                    <v-spacer/>
                    <v-btn color="primary" @click.native="dispatch"
                           :disabled="connecting">Dispatch
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>
        <!--Confirm received-->
        <v-dialog v-model="confirmingReceived" max-width="800px">
            <v-card v-if="confirmingReceivedItem">
                <v-card-text>
                    <guide text="Confirm the order was received successfully!"/>
                    <connection-manager ref="confirmingReceivedConnectionManager"
                                        v-model="connecting"/>
                    <v-data-table
                            hide-headers
                            hide-actions
                            :headers="viewItemHeaders"
                            :items="viewableHeaders">
                        <template slot="items"
                                  slot-scope="props">
                            <td>{{props.item.text}}</td>
                            <td>{{manager.toValue(props.item, confirmingReceivedItem)}}</td>
                        </template>
                    </v-data-table>
                    <v-data-table
                            :items="confirmingReceivedItem.items"
                            hide-actions
                            item-key="id"
                            :style="'max-height: '+($vuetify.breakpoint.height * 0.30)+'px;'"
                            class="scroll-y"
                            :headers="productHeaders">
                        <template slot="items" slot-scope="props">
                            <td>{{props.item.product.name}}</td>
                            <td>{{$utils.formatMoney(props.item.priceAtPurchase)}}</td>
                            <td>{{props.item.quantity}}</td>
                            <td>{{$utils.formatMoney(props.item.priceAtPurchase*props.item.quantity)}}</td>
                        </template>
                    </v-data-table>
                </v-card-text>
                <v-card-actions>
                    <v-spacer/>
                    <v-btn color="red" @click.native="confirmingReceived = false" flat
                           :disabled="connecting">Close
                    </v-btn>
                    <v-spacer/>
                    <v-btn color="primary" @click.native="confirmReceived"
                           :disabled="connecting">Confirm
                    </v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>


    </v-layout>
</template>

<script>
  import Crud from './Crud'
  import CrudBase from './CrudBase'
  import Guide from './Guide'
  import ConnectionManager from './ConnectionManager'


  export default {
    extends: CrudBase,
    components: {ConnectionManager, Guide, Crud},
    name: 'Orders',
    data () {
      return {
        confirmingReceived: false,
        confirmingReceivedItem: null,
        item: null,
        viewDialogHere: false,
        connecting: false,
        dispatchingItem: null,
        dispatching: false,
        viewableHeaders: [],
        viewItemHeaders: [],
        adminAndOperationsFilters: [
          {value: 'PENDING_DISPATCH', name: 'Pending Dispatch'},
          {value: 'DISPATCHED', name: 'Dispatched'},
          {value: 'DELIVERED', name: 'Delivered'},
          {value: 'AT_DEPARTMENT_HEAD', name: 'At Department Head'},
          {value: 'AT_PURCHASING_HEAD', name: 'At Purchasing Head'},
          {value: 'APPROVED', name: 'Approved'},
          {value: 'REJECTED', name: 'Rejected'},
        ],
        clientFilters: [
          {value: 'AT_DEPARTMENT_HEAD', name: 'At Department Head'},
          {value: 'AT_PURCHASING_HEAD', name: 'At Purchasing Head'},
          {value: 'APPROVED', name: 'Approved'},
          {value: 'DELIVERED', name: 'Delivered'},
          {value: 'REJECTED', name: 'Rejected'},
          {value: 'DISPATCHED', name: 'Dispatched'},
          {value: 'PENDING_DISPATCH', name: 'Pending Dispatch'}
        ],
        productHeaders: [
          {text: 'Name', value: 'product.name'},
          {text: 'Price', value: 'product.price'},
          {text: 'Quantity', value: 'quantity'},
          {text: 'Total', value: 'total'},
        ],
        extraInlineActions: [
          {
            name: 'Confirm Received',
            key: 'confirmReceived',
            color: 'accent'
          },
          {
            name: 'Dispatch',
            key: 'dispatch',
            color: 'accent'
          },
          {
            name: 'View',
            key: 'view',
            color: 'primary'
          }
        ],
      }
    },
    methods: {
      closeDispatchingDialog () {
        this.dispatchingItem = null
        this.dispatching = false
        this.connecting = false
      },
      closeConfirmingDispatch () {
        this.confirmingReceivedItem = null
        this.confirmingReceived = false
        this.connecting = false
      },
      dispatch () {
        let that = this
        this.$refs.dispatchConnectionManager.post('orders/dispatch/' + this.dispatchingItem.id, {
          onSuccess (response) {
            that.$refs.crud.setItems(response.data.data)
            that.closeDispatchingDialog()
          }
        })
      },
      confirmReceived () {
        let that = this
        this.$refs.confirmingReceivedConnectionManager.post('orders/confirmReceived/' + this.confirmingReceivedItem.id, {
          onSuccess (response) {
            that.$refs.crud.removeItem(response.data.data)
            that.closeConfirmingDispatch()
          }
        })
      },
      close () {
        this.item = null
        this.viewDialogHere = false
      },
      initialize () {
        let that = this
        this.manager.editable = (item) => {
          return false
        }
        this.manager.deletable = (item) => {
          return false
        }
        this.manager.creatable = () => {
          return false
        }
        this.manager.toValue = (header, item) => {
          if (header.value === 'rejectedBy') {
            return item.rejectedBy ? item.rejectedBy.name + ' - (' + item.rejectedBy.role.name + ')' : that.defaultValue
          }
          else if (header.value === 'dispatchedBy') {
            return item.dispatchedBy ? item.dispatchedBy.name : that.defaultValue
          }
          else if (header.value === 'receivedConfirmedBy') {
            return item.receivedConfirmedBy ? item.receivedConfirmedBy.name : that.defaultValue
          }
          else if (header.value === 'dispatchRider') {
            return item.dispatchRider ? item.dispatchRider.name : that.defaultValue
          }
          else {
            return item[header.value] ? item[header.value] : that.defaultValue
          }
        }
        this.manager.nameOnDelete = (item) => {
          return 'this order.'
        }
        this.manager.hasCustomView = (item, viewableHeaders, viewItemHeaders) => {
          that.item = item
          that.viewDialogHere = true
          that.viewableHeaders = viewableHeaders
          that.viewItemHeaders = viewItemHeaders
          return true
        }
        this.manager.showInlineAction = (action, item, filter) => {
          if (action.key === 'dispatch' && filter) {
            return filter.value === 'PENDING_DISPATCH' && (this.isAdmin() || this.isOperations())
          }
          if (action.key === 'confirmReceived' && filter) {
            return filter.value === 'DISPATCHED' && this.isDepartmentUser()
          }
          else {
            return true
          }
        }
        this.manager.onInlineActionClicked = (action, item, filter) => {
          if (action.key === 'view') {
            that.$refs.crud.viewItem(item)
          } else if (action.key === 'dispatch') {
            that.viewableHeaders = that.$refs.crud.viewableHeaders
            that.viewItemHeaders = that.$refs.crud.viewItemHeaders
            that.dispatchingItem = item
            that.dispatching = true
          } else if (action.key === 'confirmReceived') {
            that.viewableHeaders = that.$refs.crud.viewableHeaders
            that.viewItemHeaders = that.$refs.crud.viewItemHeaders
            that.confirmingReceivedItem = item
            that.confirmingReceived = true
          }
        }
        this.manager.hideHeader = (header, filter) => {
          if (header.value === 'rejectedBy') {
            return filter.value === 'REJECTED'
          } else if (header.value === 'dispatchedAt') {
            return filter.value !== 'DISPATCHED' || that.isSupplier()
          }
          else if (header.value === 'dispatchedBy') {
            return filter.value !== 'DISPATCHED' || !that.isSupplier()
          }

          else if (header.value === 'receivedConfirmedAt') {
            return filter.value !== 'DELIVERED'
          }
          else if (header.value === 'receivedConfirmedBy') {
            return filter.value !== 'DELIVERED'
          }

          else if (header.value === 'dispatchRider') {
            return filter.value !== 'DISPATCHED'
          }
          else if (header.value === 'itemsReceivedFromSupplierCount') {
            return !that.isAdmin() && !that.isOperations()
          }
          else if (header.value === 'itemsNotReceivedFromSupplierCount') {
            return !that.isAdmin() && !that.isOperations()
          }
          else {
            return false
          }
        }
      },
      approveOrReject (action) {
        let that = this
        this.$refs.connectionManager.patch('orders/' + this.item.id, {
          onSuccess (response) {
            that.item = null
            that.connecting = false
            that.selected = []
            that.viewDialogHere = false
            const item = response.data.data
            that.$refs.crud.removeItem(item)
          }
        }, {action: action})
      },
      showRejectButton (item) {
        return (this.isPurchasingHead() && item.status === 'AT_PURCHASING_HEAD')
          || (this.isDepartmentHead() && item.status === 'AT_DEPARTMENT_HEAD')
      },
      showApproveButton (item) {
        //Item is rejected
        //The user who rejected is the authenticated user
        return (item.status === 'REJECTED' && item.rejectedBy && item.rejectedBy.id === this.$auth.user().id)
          || (this.isPurchasingHead() && item.status === 'AT_PURCHASING_HEAD')
          || (this.isDepartmentHead() && item.status === 'AT_DEPARTMENT_HEAD')
      },

    }
  }
</script>

<style scoped>

</style>