<template>
  <div id="app">
    <Navbar v-bind:LotList="LotList" v-on:LotSelected="CurrentLot=$event"/>
    <div class="container workspace">
      <UserControl v-bind:User="CurrentUser"/>
      <Lot v-bind:CurrLot="CurrentLot"/>
    </div>
  </div>
</template>

<script>
import Lot from './components/Lot.vue'
import Navbar from './components/Navbar.vue'
import UserControl from './components/UserControl.vue'

export default {
  name: 'app',
  data: function(){
    return {
    LotList: [{Caption:"MIG-5",
               Description: 'Consectetur velit dolor laboris cupidatat fugiat cupidatat cupidatat tempor.',
               ImageSrc:'http://i90.fastpic.ru/big/2017/0216/0e/683296ac661a742f4855a9d505f53f0e.jpg',
               Id: 0,
               Price: 1000000},
               {Caption:"SU-37",
               Description: 'Nulla excepteur sint quis laboris occaecat.',
               ImageSrc:'http://airwar.ru/image/idop/fighter/su37/su37-1.jpg',
               Id: 1,
               Price: 10000}
               ],
    CurrentLot:{Caption:"MIG-5",
               Description: 'Consectetur velit dolor laboris cupidatat fugiat cupidatat cupidatat tempor.',
               ImageSrc:'http://i90.fastpic.ru/big/2017/0216/0e/683296ac661a742f4855a9d505f53f0e.jpg',
               Id: 0,
               Price: 1000000},


    }  },

  computed:{
    
    CurrentUser: function(){
      return "127.0.0.1"
    }
  },
  components: {
    Lot,
    Navbar,
    UserControl
  }
}
</script>

<style>
body{
  background-image: url('https://oboi.ws/originals/original_1989_oboi_starinnaja_bumaga_2560x1600.jpg');

}
.workspace{
  padding-top: 5%;
}
</style>
