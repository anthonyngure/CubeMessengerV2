<template>
    <div>
        <v-text-field
                prepend-icon="attach_file"
                single-line
                v-on:click="$upload.select('file')"
                v-model="filename"
                :label="label"
                :accept="accept"
                :disabled="$upload.meta('file').status === 'sending' || disabled"
                ref="fileTextField">
        </v-text-field>

        <v-progress-linear v-bind:indeterminate="true"
                           v-show="$upload.meta('file').percentComplete === 100">
        </v-progress-linear>

        <v-progress-linear
                v-show="$upload.meta('file').status === 'sending' && $upload.meta('file').percentComplete < 100"
                v-model="$upload.meta('file').percentComplete"
                color="teal">
        </v-progress-linear>

<!--
        <v-btn
                v-show="$upload.meta('file').status === 'ready' && file && $upload.errors('file').length === 0 "
                color="info"
                block
                v-on:click="$upload.start('file')"
                :disabled="$upload.meta('file').status === 'sending'">
            Process
        </v-btn>
-->


        <v-dialog v-model="dialog" persistent max-width="800px">
            <v-card>
                <v-card-text>
                    <div v-for="error in $upload.errors('file')">
                        {{ error.rule }}: {{ error.message }}
                    </div>
                    <div>
                        <pre>
                        <code>{{message}}</code>
                    </pre>
                    </div>
                </v-card-text>
                <v-card-actions>
                    <v-spacer/>
                    <v-btn color="green darken-1" flat @click.native="reset()">Okay</v-btn>
                </v-card-actions>
            </v-card>
        </v-dialog>

    </div>
</template>
<script type="text/javascript">
  export default {
    name: 'FilePicker',
    props: {
      label: {
        type: String,
        'default': 'Select input file...'
      },
      disabled: {
        type: Boolean,
        default: false
      },
      accept: {
        type: String,
        default: '.pdf'
      },
      moreData: {
        default: ''
      }
    },
    data () {
      return {
        filename: this.label,
        file: null,
        dialog: false,
        message: '',
      }
    },
    methods: {
      reset () {
        /*this.$upload.reset(this.report, {
          url: '/api/v1/' + this.report
        })*/

        this.file = null
        this.dialog = false
        this.filename = this.label
      }
    },

    created () {
      this.$upload.new('file', {
        startOnSelect: false,
        maxSizePerFile: 1024 * 1024 * 2,
        extensions: ['pdf'],
        body: {
          //report: this.report,
          data: this.moreData
        },
        onSuccess (res) {
        },
        onError (error) {
          console.error(error)
        },
        onSelect (files) {
          this.file = files[0]
          this.filename = files[0].name
          this.$emit('onFilePicked', files[0]);
          /* files[0].preview((file) => {
            // this.brandImage = file.raw
            console.info('File Content ' + file.raw)
          }) */
        }
      })
    },

    mounted () {
      this.reset()
    }
  }
</script>

