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
        <v-dialog v-model="viewDialogHere"
                  max-width="800px">
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
                            <td>{{props.item.product.price}}</td>
                            <td>{{props.item.quantity}}</td>
                            <td>{{$utils.formatMoney(props.item.product.price*props.item.quantity)}}</td>
                        </template>
                    </v-data-table>
                </v-card-text>
                <v-card-actions>
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
        <v-dialog v-model="dispatching" max-width="600px">
            <v-card>
                <v-card-text>

                </v-card-text>
                <v-card-actions>
                    <v-spacer/>
                    <v-btn color="red" @click.native="dispatching = false" flat
                           :disabled="connecting">Close
                    </v-btn>
                    <v-spacer/>
                    <v-btn color="primary" @click.native="generateLPO"
                           :disabled="connecting">Submit
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
          } else {
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
          } else {
            return true
          }
        }
        this.manager.onInlineActionClicked = (action, item, filter) => {
          if (action.key === 'view') {
            that.$refs.crud.viewItem(item)
          } else {
            that.dispatchingItem = item
            that.dispatching = action.key === 'dispatch'
          }
        }
        this.manager.hideHeader = (header, filter) => {
          return header.value === 'rejectedBy' && filter.value !== 'REJECTED'
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