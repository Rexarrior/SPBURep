Vue.component('lot-container',{
    template: '\
    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Consequatur dolore incidunt totam adipisci suscipit repudiandae qui exercitationem a molestiae! Consequuntur temporibus voluptatibus molestias porro fugit assumenda rerum beatae, harum perspiciatis.</p>\
    \
    '
});



Vue.component('timer-container', {
    ready() {
        window.setInterval(() => {
            this.now = Math.trunc((new Date()).getTime() / 1000);
        },1000);
    },
    props : {
        date : {
            type: Number,
            coerce: str => Math.trunc(Date.parse(str) / 1000)
        }
    },

    data() {
        return {
            now: Math.trunc((new Date()).getTime() / 1000)
        }
    },
    computed: {
        seconds() {
            return (this.date - this.now) % 60;
        },
    
        minutes() {
            return Math.trunc((this.date - this.now) / 60) % 60;
        },
    
        hours() {
            return Math.trunc((this.date - this.now) / 60 / 60) % 24;
        },
    
        days() {
            return Math.trunc((this.date - this.now) / 60 / 60 / 24);
        }
    },
    template:
    '\
    <div>\
        <div class="block">\
            <p class="digit">{{ days  | two_digits }}</p>\
            <p class="text">Days</p>\
        </div>\
        <div class="block">\
            <p class="digit">{{ hours  | two_digits }}</p>\
            <p class="text">Hours</p>\
        </div>\
        <div class="block">\
            <p class="digit">{{ minutes  | two_digits }}</p>\
            <p class="text">Minutes</p>\
        </div>\
        <div class="block">\
            <p class="digit">{{ seconds  | two_digits }}</p>\
            <p class="text">Seconds</p>\
        </div>\
    </div>\
    '

});




Vue.filter('two_digits', function (value) {
    if(value.toString().length <= 1)
    {
        return "0"+value.toString();
    }
    return value.toString();
});





var vm = new Vue({
    el: '#app',
    data: {
        bet:0,
        betUp:0,
        time:100,
        defaultDate : 100
    },
    methods:
    {
        onBetUp: function()
        {
            bet += betUp ; 
            time = defaultDate;
        }
    }

});