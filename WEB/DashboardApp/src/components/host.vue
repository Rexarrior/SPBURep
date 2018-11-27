<template>
<div class="container wrap">
    <form  class="container col-sm-4 get-id-form  ">
        <input class="field-input" id="id-input" type="" placeholder="identifier" value="myserve"> 
        <input class="field-input" id="img-input" type="" placeholder="image url" value="https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Paris_-_Eiffelturm_-_frontal_vom_Marsfeld.jpg/300px-Paris_-_Eiffelturm_-_frontal_vom_Marsfeld.jpg"> 
        <input class="field-input" id="subscr-input" type="" placeholder="subsrciption" value="Very expensive lot"> 
        <button class="host"  @click="Host()"> Host </button>
    </form>
    <div v-if="IsHosted">
        <p>HOST</p>
    </div>
</div>
</template>

<script>
import Dashboard from './Dashboard.vue'
    export default {
        name : "Host",
        data: function(){
            return {
                IsHosted: false,
            }
        },
        methods:{
            Host: function () {
                var id = document.getElementById("id-input").value; 
                var img = document.getElementById("img-input").value; 
                var subscription = document.getElementById("subscr-input").value; 
                var pusher = new Pusher('5186ef3ebb69e0e7d02a', {
                    cluster: 'eu'
                });
                
                
                var channel = pusher.subscribe('chanel-' + id);
                this.IsHosted = true;
                setInterval(function(){

                        var message = {id: id, img: img, subscription: subscription};
                        var json = JSON.stringify(message);


                        channel.trigger("client-host-keep-alive", {json});
                }, 1000); // send every second hosted dashboard

                
                
            }
        },

    }    
</script>


<style scoped>
.wrap{
    margin-top:15%;
    margin-left: 25%;
    
}
.field-info-label{
    color: white;
    margin-left: 13%;
    font-size: 20pt;
}
.host{
    margin-left: 10%;
    width: 80%;
    height: 30%;
    margin-bottom: 5%;    
}
.field-input{
    margin-left:10%;
    height: 8%;
    width: 80%
}
.get-id-form{
    background-color: gray;
    position: absolute;
    overflow: hidden;
    padding: 2%;
}
</style>
