# application_bottom.js.coffee

# jQuery from CDN required in before that
//= require jquery_ujs

//= require categories
//= require repos
//= require users


# Javascript for rounded corners on images
#   as seen here: www.bram.us/sandbox/roundedcorners/
$ ->
  $('img').wrap ->
    return '<span style="background-image:url(' + $(this).attr('src') + ');
      height: '+ $(this).height() + 'px; width: '+ $(this).width() + 'px; background-size: ' + $(this).height() + 'px ' + $(this).width() + 'px; background-repeat: no-repeat;
      " class="rounded_image" />'

