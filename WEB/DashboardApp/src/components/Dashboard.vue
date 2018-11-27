<template>
  <div class="wrap">
    <div v-if="IsDataReceived">
    <h1> Dashboard {{$route.params.serverIp}}</h1>
    <img :src="Lot.img" class="lot-image"/>
    <div class="lot-subscription">
      <p>
        {{Lot.subscription}}
      </p>
    </div>
    <ControlPanel :channel="Channel"/>
    </div>
    <div v-else>
      <p> Data is loading...</p>
    </div>
  </div>
</template>

<script>
import ControlPanel from './ControlPanel.vue'

export default {
  name: "Dashboard",
  data: function() {
    return {
      Channel: null,
      Lot: null,
      IsDataReceived: false
    }
  },
  computed:
  {
   

  },
  created: function (){
    var pusher = new Pusher('5186ef3ebb69e0e7d02a');
    var channel = pusher.subscribe('client-server-'+ this.$route.serverId);
    var callback = function(data) {
      if (!this.IsDataReceived)
      {
        this.Lot = JSON.parse(data.json);
        this.IsDataReceived = true; 
        channel.unbind('client-host-keep-alive', callback);
      }
    };
    channel.bind('client-host-keep-alive', callback);
  },
  components:{
    ControlPanel,
  }
}
</script>

<style scoped>
.wrap{

}
</style>

