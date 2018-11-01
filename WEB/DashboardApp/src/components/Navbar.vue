
<template>
<nav class="navbar navbar-default navbar-fixed-top navbar-main">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" >Auction</a>
            <a v-for="lot in LotList" v-bind:key=lot.Id class="navbar-text" href="#" v-on:click="$emit('LotSelected', lot)">{{lot.Caption}}</a>
          </div>
        
        </div><!--/.container-fluid -->
      </nav>
</template>


<script>
export default {
    name: 'Navbar',
    props: {
        LotList: Array
    },

}
</script>


<style scoped>
</style>
