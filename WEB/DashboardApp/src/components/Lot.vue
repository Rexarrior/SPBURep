<template>
  <div class="lot-main jumbotron">
      <h1 class="text-center  caption">{{CurrLot.Caption}}</h1>
      <img class="lot-img img-circle img-responsive" v-bind:src="CurrLot.ImageSrc"/>
      <div class="description">
        <p class=" text-center">{{CurrLot.Description}}
        </p>
        <h3 class="text-center">{{CurrLot.Price}} $</h3>
      </div>
  </div>
</template>

<script>
export default {
  name: 'Lot',
  props: {
    CurrLot: Object
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.caption{
  font-size: 25pt;
  
}
.description{
  background-color: rgb(219, 214, 214);
  font-size: 15pt;
}
.lot-main{
  padding-top: 5%;
}
.lot-img{
  margin: 0 auto;
  height: 100%;
}

</style>
