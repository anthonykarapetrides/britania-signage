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
            events: 'https://www.google.com/calendar/feeds/antholio%40gmail.com/private-d01402b714d835385052f15ab9bf8c20/basic',
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

var news_feed = {
    init: function(){
        var news_feed = $('#news_feed_here');
        $.ajax({
            async: true,
            url: "/placeholders/news_feed.json",
            type: "get",
            success: function (items) {
                console.log('success');
                var out = "<p>";
                $.each(items, function(index, item){
                    out += '<img class="img-responsive" src="/assets/britania_icon_sm.png" style="height: 15px; margin-top: -3px; display: inline-block;"> <strong>' + item.title + ':</strong> ' + item.description;
                });
                out += '</p>';
                news_feed.html(out);
                news_feed.marquee({
                    duration: 15000,
                    allowCss3Support: true,
                    css3easing: 'linear',
                    pauseOnHover: false
                });

            },
            error: function (data) {
                console.log('error');
                console.log(data);
            }
        });
    }
};

var feed_content = {
    init: function(){
        feed_content.word();
        feed_content.quote();
        feed_content.namedays();
    },

    get_content: function(option){
        var item;

        $.ajax({
            async: false,
            url: '/placeholders/get_feed_content.json',
            data: {option: option},
            type: "get",
            success: function (data) {
                item = data;
            },
            error: function (data) {
                console.log('error');
                console.log(data);
            }
        });
        return item;
    },

    word: function(){
        var wotd = feed_content.get_content('wotd');
        console.log(wotd);
        var html = '<div class="media"><div class="media-body"><h4 class="media-heading">' +
            wotd.title + '</h4>'+ wotd.description + '</div></div>';
        $('#wotd').html(html);
    },

    quote: function(){
        var qotd = feed_content.get_content('qotd');
        console.log(qotd);
        var html = '<div class="media"><a class="pull-left" href="#">' +
            '<img class="media-object img-thumbnail" src="'+qotd.img_url+'" ></a><div class="media-body">' +
            '<blockquote class="blockquote-reverse blockquote-slim"><p>' + qotd.description +
            '</p><footer>' + qotd.title +
            '</footer></blockquote>' +
             '</div></div>';
        $('#qotd').html(html);
    },

    namedays: function(){
        var ndays = feed_content.get_content('ndays');
        console.log(ndays);
        var html = '<div class="media"><div class="media-body">' +
            ndays.description + '</div></div>';
        $('#ndays').html(html);
    }
};
