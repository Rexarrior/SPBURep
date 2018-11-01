<template>
   
    <form class = "form-edit user-control">
        <label for="User" class="bg-success">You are known as {{User}}</label>
        <input name="IncreaseBy" type="number" placeholder="Increase by " value="100" id="increase-input" class = "form-control" required autofocus>
        <button class="btn btn-lg btn-primary btn-block" type="button" id="increase-button" v-on:click="Increase()">Поднять!</button>
    </form>
</template>

<script>
export default {
    name: 'UserControl',
    props:{
        User: String
    },
    methods:
    {
        Increase: function () {
            var num = document.getElementById('increase-input').value
            if (num <= 0)
            {
                alert('Can\'t increase by negative number or zero.');
            }
        }
    }
}
</script>


<style scoped>

    .form-edit {
    width: 100%;
    max-width: 330px;
    padding: 15px;
    margin: 0 auto;
    }
    .form-edit .checkbox {
    font-weight: 400;
    }
    .form-edit .form-control {
    position: relative;
    box-sizing: border-box;
    height: auto;
    padding: 10px;
    font-size: 16px;
    }
    .form-edit .form-control:focus {
    z-index: 2;
    }
    .form-edit input[type="email"] {
    margin-bottom: -1px;
    border-bottom-right-radius: 0;
    border-bottom-left-radius: 0;
    }
    .form-edit input[type="password"] {
    margin-bottom: 10px;
    border-top-left-radius: 0;
    border-top-right-radius: 0;
    }

    .user-control{
        padding-top: 0%;
    }
</style>
