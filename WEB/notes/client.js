

Pusher.logToConsole = true;

var pusher = new Pusher('c48b41985e31debb63b1', {
    cluster: 'eu',
    forceTLS: true
});

var channel = pusher.subscribe('my-channel');
channel.bind('my-event', putPushTolabel);



function requestPush()
{
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/push");
    xhr.send();
}




function putPushTolabel(data)
{
    var label = document.getElementById('push_field');
    label.innerText = data;

}