<template>
<div class="container wrap">
    <form class="container col-sm-4 get-id-form  ">
        <input class="id-input" id="id-input" type="" placeholder="id of auction server" value="127.0.0.1"> 
        <button class="id-accept"  @click="IdAccept()"> Connect </button>
    </form>
</div>
</template>

<script>
    export default {
        name : "GetId",

        methods:{
            IdAccept: function () {
                var id = document.getElementById("id-input").value; 
                this.$router.push({path:"dashboard/" + id, params: {serverId: id}});
                
            }
        }

    }    
</script>


<style scoped>
.wrap{
    margin-top:15%;
    margin-left: 25%;
    
}
.id-info-label{
    color: white;
    margin-left: 13%;
    font-size: 20pt;
}
.id-accept{
    margin-left: 10%;
    width: 80%;
    height: 30%;
    
}
.id-input{
    margin-left:10%;
    height: 20%;
    width: 80%
}
.get-id-form{
     background-color: gray;
    position: absolute;
    overflow: hidden;
    padding: 2%;
}
</style>
