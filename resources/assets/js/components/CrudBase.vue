<script>
  import Base from './Base.vue'

  export default {
    name: 'CrudBase',
    extends: Base,
    data () {
      return {
        headers: [], //Headers for the table
        manager: {},
        defaultValue: '_____', //Displayed when a value is null
        extraInlineActions: [
          /*
          Actions should be name,color objects e.g
          {
            name: 'Approve',
            color: 'accent'
          }, {
            name: 'Reject',
            color: 'primary'
          }*/
        ],
        extraOverflowActions: [
          /*
          Actions should be name,color objects e.g
          {
            name: 'Approve',
            color: 'accent'
          }, {
            name: 'Reject',
            color: 'primary'
          }*/

        ],
        extraTopActions: [
          /*
          Actions should be name,color, key objects e.g
          {
            name: 'Approve',
            color: 'accent',
            key: 'ddd'
          }, {
            name: 'Reject',
            color: 'primary'
          }*/
        ]
      }
    },
    created () {
      this.setDefaultManager() // Sets a default manager
      this.initialize() //
    },
    methods: {
      initialize () {
      },
      setDefaultManager () {
        let that = this
        this.manager = {

          //Whether the item is deletable
          deletable: (item) => {
            return true
          },

          //Whether the item is editable
          editable: (item) => {
            return true
          },

          //If should show a custom dialog or any view when view item is clicked
          hasCustomView (item, viewableHeaders, viewItemHeaders) {
            return false
          },

          //Get value for a header
          //header: the header
          //item: current item
          toValue: (header, item) => {
            return item[header.value] ? item[header.value] : that.defaultValue
          },

          //Name shown in the delete prompt dialog
          nameOnDelete (item) {
            return item.name
          },

          //Called when any specified top action is clicked
          // action: clicked action
          //items: all items
          // filter: current filter
          onTopAction (action, items, filter) {
          },

          //Whether a top action should be shown
          showTopAction (action, items, filter) {
            return true
          },

          //Called when any specified inline action is clicked
          // action: clicked action
          //item: item in that row
          // filter: current filter
          onInlineActionClicked(action, item, filter){

          },

          //Whether an inline action should be shown
          showInlineAction (action, item, filter) {
            return true
          },

        }
      }
    }
  }
</script>

<style scoped>

</style>