//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

var weather_widget = {

  init: function(){
    weather_widget.update_weather();
    weather_widget.auto_update();
  },

  auto_update: function(){
    setInterval('weather_widget.update_weather();', 600000);
  },

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
        $('#weather_now .wind').html(weather.wind.speed + weather.units.speed + ' ' + weather.wind.direction);

        $.each([1,2,3,4], function(index, i){
          $('#weather_forecast .day'+i+' .day_name').html(weather.forecast[i].day);
          $('#weather_forecast .day'+i+' .weather_img').attr('src',weather.forecast[i].image);
          //$('#weather_forecast .day'+i+' .icon').html('<i class="icon-'+weather.forecast[i].code+'"></i>');
          $('#weather_forecast .day'+i+' .temps').html(weather.forecast[i].high+units+' &bull; '+weather.forecast[i].low+units);
        });

        //html += '<li>'+weather.wind.direction+' '+weather.wind.speed+' '+weather.units.speed+'</li></ul

      },
      error: function(error) {
        $("#weather_now").html('<p>'+error+'</p>');
      }
    });
  }

};


var time = {
  auto_update:function(){
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
  getMinTimeText: function(){
    var timeNow = new Date();
    var hours = timeNow.getHours();
    return hours + ":00:00";
  },

  getMaxTimeText: function(){
    var timeNow = new Date();
    var hours = timeNow.getHours() + 4;
    return hours + ":00:00";
  },

  init: function(){
    var min_time = calendar.getMinTimeText();
    var max_time = calendar.getMaxTimeText();
    var duration = '00:15:00'
    $('#calendar').fullCalendar({
      slotDuration: duration,
      events: 'https://www.google.com/calendar/feeds/britanialanguageschool%40gmail.com/private-5ecd31037914e801b1b71ec4a428e501/basic',
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
      minTime: min_time,
      maxTime: max_time,
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
    var wotd_div = $('#wotd');
    wotd_div.find('.title_here').html(wotd.title);
    wotd_div.find('.description_here').html(wotd.description);
  },

  quote: function(){
    var qotd = feed_content.get_content('qotd');
    console.log(qotd);
    var qotd_div = $('#qotd');
    qotd_div.find('.title_here').html(qotd.title);
    qotd_div.find('img.image_here').attr('src', qotd.img_url);
    qotd_div.find('p.description_here').html(qotd.description);
  },

  namedays: function(){
    var ndays = feed_content.get_content('ndays');
    console.log(ndays);
    var ndays_div = $('#ndays');
    ndays_div.find('.description_here').html(ndays.description);
  }
};

var carousel_imgs = {
  init: function(){
    $.ajax({
      async: false,
      url: '/placeholders/get_carousel_photos.js',
      type: "get",
      success: function (data) {
        $('.carousel').carousel({
          wrap: true,
          keyboard: false
        });
      },
      error: function (data) {

      }
    });
  }
};
