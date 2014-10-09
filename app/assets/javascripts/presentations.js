//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

var weather_widget = {
    update_weather: function(){
        $.simpleWeather({
            woeid: '22723419',
            unit: 'c',
            success: function(weather) {
                var units = '&deg;'+weather.units.temp;
                $('#weather_now .weather_img').attr('src', weather.image);
                $('#weather_now .temp').html(weather.temp+units);
                $('#weather_now .condition').html(weather.currently);
                $('#weather_now .hi').html(weather.high+units);
                $('#weather_now .lo').html(weather.low+units);
                $('#weather_now .heatindex').html(weather.heatindex+units);


                $.each([1,2,3,4], function(index, i){
                    $('#weather_forecast .day'+i+' .day_name').html(weather.forecast[i].day);
                    $('#weather_forecast .day'+i+' .weather_img').attr('src',weather.forecast[i].image);
                    //$('#weather_forecast .day'+i+' .icon').html('<i class="icon-'+weather.forecast[i].code+'"></i>');
                    $('#weather_forecast .day'+i+' .temps').html(weather.forecast[i].high+units+' &bull; '+weather.forecast[i].low+units);
                });

                //html += '<li>'+weather.wind.direction+' '+weather.wind.speed+' '+weather.units.speed+'</li></ul>';




            },
            error: function(error) {
                $("#weather_now").html('<p>'+error+'</p>');
            }
        });
    }

};


var time = {
    auto_update:function(){
        var time_div = $('.time_here');
        setInterval('time.set_time();', 100);
    },

    set_time: function(){
        var time_div = $('.time_here');
        var time_now = new Date();
        var hours = time_now.getHours();
        var mins = time_now.getMinutes();
        var secs = time_now.getSeconds();
        if (mins < 10){
            mins = '0' + mins
        }
        if (secs < 10){
            secs = '0' + secs
        }
        time_div.html(hours+":"+mins+":"+secs);
    }
};

var calendar = {
    getTimeText: function(){
        var timeNow = new Date();
        var hours = timeNow.getHours() - 1;
        return hours + ":00:00";
    },

    init: function(){
        var earlierTimeText = calendar.getTimeText();
        $('#calendar').fullCalendar({
            events: 'https://www.google.com/calendar/feeds/antholio%40gmail.com/public/basic',
            header: {
                left:   '',
                center: '',
                right:  ''
            },
            defaultView: 'agendaDay',
            columnFormat: {
                month: 'ddd',    // Mon
                week: 'ddd M/D', // Mon 9/7
                day: 'dddd'      // Monday
            },
            minTime: earlierTimeText,
            allDaySlot: false
        })
    }
};