/*
  Readme.js
  by Thomas Klemm, Twitter: @thomasjklemm, Github: thomasklemm
  Last modified: 2012/07/07
  License: MIT

  Styling of Readme using Github Markup and CSS Code

  HOW TO USE:

  1) <div class='readme-js' data-owner='thomasklemm' data-repo='Readme.js'></div>

  or

  2)  $('#Readme').readme({
        'owner': 'thomasklemm',
        'repo':  'Readme.js'
      });
*/

;(function( $ ) {

  // Methods
  var methods = {
    init: function( options ) {

      return this.each(function() {

          // Defaults
        var settings = $.extend({
            'owner':  'thomasklemm',
            'repo':   'Readme.js',
            'styles': false
          }, options);

        // Init
        var $this = $(this),
            owner =   $this.data('owner')  || settings.owner,
            repo =    $this.data('repo')   || settings.repo,
            styles =  $this.data('styles') || settings.styles;

        // Loading Message
        var load_message = "Loading Readme for <b>" + owner + "/" + repo + "</b>..."
        $this.html(load_message)

        // Request & Render Readme
        // Ajax Call
        $.ajax({
          url: 'https://api.github.com/repos/' + owner + '/' + repo + '/readme',
          headers: {
            'Accept': 'application/vnd.github.html'
          },
          success: function(data) {
            // Request successful
            // Insert Styling
            if ( ! (styles == false) ) {
              $('body').prepend(stylesheet)
            }

            // Insert HTML into element
            $this.html(data)
          },
          error: function(data) {
            if ( data.status === 404 ) {
              // Repo not found
              $this.html('The repo <b>' + owner + '/' + repo + '</b> is either unknown to Github OR it has no Readme (Error 404).')
            } else if ( data.status === 0 ) {
              // Repo not found
              console.log(data)
              $this.html("Cross-Site Request Ajax Error. Please take a look at the Readme.js Readme on how to set up these kind of requests to the Github API.")
            } else {
              console.log(data)
              $this.html("An error <b>" + data.status + "</b> occurred while trying to load the Readme of Github Repo <b>" + owner + "/" + repo + "</b>. A debug object has been written to your Browser's Javascript Console.")
            }
          }
        });

      });
    }
  };

  // Readme
  $.fn.readme = function( method ) {
    if ( methods[method] ) {
      return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ));
    } else if ( typeof method === 'object' || ! method ) {
      return methods.init.apply( this, arguments );
    } else {
      $.error( 'Method ' +  method + ' does not exist on jQuery.readme' );
    }
  };

  // Github Markdown Body Stylesheet
  // Bluntly stolen from the Github CSS files
  // to ensure consistency in the rendering and displaying
  //
  // Used only to render the Readme retrieved from Github in a Github-Style way
  //
  // All credits go to Github, it's their code!
  // Retrieved: 12/20/2012
  //
  // Compressed in the hope that Javascript will support multi-line strings anytime soon!
  var stylesheet = '<style>.markdown-body{font-size:14px;line-height:1.6;overflow:hidden}.markdown-body>*:first-child{margin-top:0 !important}.markdown-body>*:last-child{margin-bottom:0 !important}.markdown-body a.absent{color:#c00}.markdown-body a.anchor{display:block;padding-left:30px;margin-left:-30px;cursor:pointer;position:absolute;top:0;left:0;bottom:0}.markdown-body h1,.markdown-body h2,.markdown-body h3,.markdown-body h4,.markdown-body h5,.markdown-body h6{margin:20px 0 10px;padding:0;font-weight:bold;-webkit-font-smoothing:antialiased;cursor:text;position:relative}.markdown-body h1 .mini-icon-link,.markdown-body h2 .mini-icon-link,.markdown-body h3 .mini-icon-link,.markdown-body h4 .mini-icon-link,.markdown-body h5 .mini-icon-link,.markdown-body h6 .mini-icon-link{display:none;color:#000}.markdown-body h1:hover a.anchor,.markdown-body h2:hover a.anchor,.markdown-body h3:hover a.anchor,.markdown-body h4:hover a.anchor,.markdown-body h5:hover a.anchor,.markdown-body h6:hover a.anchor{text-decoration:none;line-height:1;padding-left:0;margin-left:-22px;top:15%}.markdown-body h1:hover a.anchor .mini-icon-link,.markdown-body h2:hover a.anchor .mini-icon-link,.markdown-body h3:hover a.anchor .mini-icon-link,.markdown-body h4:hover a.anchor .mini-icon-link,.markdown-body h5:hover a.anchor .mini-icon-link,.markdown-body h6:hover a.anchor .mini-icon-link{display:inline-block}.markdown-body h1 tt,.markdown-body h1 code{font-size:inherit}.markdown-body h2 tt,.markdown-body h2 code{font-size:inherit}.markdown-body h3 tt,.markdown-body h3 code{font-size:inherit}.markdown-body h4 tt,.markdown-body h4 code{font-size:inherit}.markdown-body h5 tt,.markdown-body h5 code{font-size:inherit}.markdown-body h6 tt,.markdown-body h6 code{font-size:inherit}.markdown-body h1{font-size:28px;color:#000}.markdown-body h2{font-size:24px;border-bottom:1px solid #ccc;color:#000}.markdown-body h3{font-size:18px}.markdown-body h4{font-size:16px}.markdown-body h5{font-size:14px}.markdown-body h6{color:#777;font-size:14px}.markdown-body p,.markdown-body blockquote,.markdown-body ul,.markdown-body ol,.markdown-body dl,.markdown-body table,.markdown-body pre{margin:15px 0}.markdown-body hr{background:transparent url("https://a248.e.akamai.net/assets.github.com/assets/primer/markdown/dirty-shade-0e7d81b119cc9beae17b0c98093d121fa0050a74.png") repeat-x 0 0;border:0 none;color:#ccc;height:4px;padding:0}.markdown-body>h2:first-child{margin-top:0;padding-top:0}.markdown-body>h1:first-child{margin-top:0;padding-top:0}.markdown-body>h1:first-child+h2{margin-top:0;padding-top:0}.markdown-body>h3:first-child,.markdown-body>h4:first-child,.markdown-body>h5:first-child,.markdown-body>h6:first-child{margin-top:0;padding-top:0}.markdown-body a:first-child h1,.markdown-body a:first-child h2,.markdown-body a:first-child h3,.markdown-body a:first-child h4,.markdown-body a:first-child h5,.markdown-body a:first-child h6{margin-top:0;padding-top:0}.markdown-body h1+p,.markdown-body h2+p,.markdown-body h3+p,.markdown-body h4+p,.markdown-body h5+p,.markdown-body h6+p{margin-top:0}.markdown-body li p.first{display:inline-block}.markdown-body ul,.markdown-body ol{padding-left:30px}.markdown-body ul.no-list,.markdown-body ol.no-list{list-style-type:none;padding:0}.markdown-body ul li>:first-child,.markdown-body ul li ul:first-of-type{margin-top:0px}.markdown-body ol li>:first-child,.markdown-body ol li ul:first-of-type{margin-top:0px}.markdown-body ul ul,.markdown-body ul ol{margin-bottom:0}.markdown-body ol ol,.markdown-body ol ul{margin-bottom:0}.markdown-body dl{padding:0}.markdown-body dl dt{font-size:14px;font-weight:bold;font-style:italic;padding:0;margin:15px 0 5px}.markdown-body dl dt:first-child{padding:0}.markdown-body dl dt>:first-child{margin-top:0px}.markdown-body dl dt>:last-child{margin-bottom:0px}.markdown-body dl dd{margin:0 0 15px;padding:0 15px}.markdown-body dl dd>:first-child{margin-top:0px}.markdown-body dl dd>:last-child{margin-bottom:0px}.markdown-body blockquote{border-left:4px solid #ddd;padding:0 15px;color:#777}.markdown-body blockquote>:first-child{margin-top:0px}.markdown-body blockquote>:last-child{margin-bottom:0px}.markdown-body table th{font-weight:bold;border:1px solid #ccc;padding:6px 13px}.markdown-body table td{border:1px solid #ccc;padding:6px 13px}.markdown-body table tr{border-top:1px solid #ccc;background-color:#fff}.markdown-body table tr:nth-child(2n){background-color:#f8f8f8}.markdown-body img{max-width:100%;-moz-box-sizing:border-box;box-sizing:border-box}.markdown-body span.frame{display:block;overflow:hidden}.markdown-body span.frame>span{border:1px solid #ddd;display:block;float:left;overflow:hidden;margin:13px 0 0;padding:7px;width:auto}.markdown-body span.frame span img{display:block;float:left}.markdown-body span.frame span span{clear:both;color:#333;display:block;padding:5px 0 0}.markdown-body span.align-center{display:block;overflow:hidden;clear:both}.markdown-body span.align-center>span{display:block;overflow:hidden;margin:13px auto 0;text-align:center}.markdown-body span.align-center span img{margin:0 auto;text-align:center}.markdown-body span.align-right{display:block;overflow:hidden;clear:both}.markdown-body span.align-right>span{display:block;overflow:hidden;margin:13px 0 0;text-align:right}.markdown-body span.align-right span img{margin:0;text-align:right}.markdown-body span.float-left{display:block;margin-right:13px;overflow:hidden;float:left}.markdown-body span.float-left span{margin:13px 0 0}.markdown-body span.float-right{display:block;margin-left:13px;overflow:hidden;float:right}.markdown-body span.float-right>span{display:block;overflow:hidden;margin:13px auto 0;text-align:right}.markdown-body code,.markdown-body tt{margin:0 2px;padding:0px 5px;border:1px solid #eaeaea;background-color:#f8f8f8;border-radius:3px}.markdown-body code{white-space:nowrap}.markdown-body pre>code{margin:0;padding:0;white-space:pre;border:none;background:transparent}.markdown-body .highlight pre{background-color:#f8f8f8;border:1px solid #ccc;font-size:13px;line-height:19px;overflow:auto;padding:6px 10px;border-radius:3px}.markdown-body pre{background-color:#f8f8f8;border:1px solid #ccc;font-size:13px;line-height:19px;overflow:auto;padding:6px 10px;border-radius:3px}.markdown-body pre code,.markdown-body pre tt{margin:0;padding:0;background-color:transparent;border:none}.highlight{background:#fff}.highlight .c{color:#998;font-style:italic}.highlight .err{color:#a61717;background-color:#e3d2d2}.highlight .k,.highlight .o{font-weight:bold}.highlight .cm{color:#998;font-style:italic}.highlight .cp{color:#999;font-weight:bold}.highlight .c1{color:#998;font-style:italic}.highlight .cs{color:#999;font-weight:bold;font-style:italic}.highlight .gd{color:#000;background-color:#fdd}.highlight .gd .x{color:#000;background-color:#faa}.highlight .ge{font-style:italic}.highlight .gr{color:#a00}.highlight .gh{color:#999}.highlight .gi{color:#000;background-color:#dfd}.highlight .gi .x{color:#000;background-color:#afa}.highlight .go{color:#888}.highlight .gp{color:#555}.highlight .gs{font-weight:bold}.highlight .gu{color:purple;font-weight:bold}.highlight .gt{color:#a00}.highlight .kc,.highlight .kd,.highlight .kn,.highlight .kp,.highlight .kr{font-weight:bold}.highlight .kt{color:#458;font-weight:bold}.highlight .m{color:#099}.highlight .s{color:#d14}.highlight .na{color:teal}.highlight .nb{color:#0086b3}.highlight .nc{color:#458;font-weight:bold}.highlight .no{color:teal}.highlight .ni{color:purple}.highlight .ne,.highlight .nf{color:#900;font-weight:bold}.highlight .nn{color:#555}.highlight .nt{color:navy}.highlight .nv{color:teal}.highlight .ow{font-weight:bold}.highlight .w{color:#bbb}.highlight .mf,.highlight .mh,.highlight .mi,.highlight .mo{color:#099}.highlight .sb,.highlight .sc,.highlight .sd,.highlight .s2,.highlight .se,.highlight .sh,.highlight .si,.highlight .sx{color:#d14}.highlight .sr{color:#009926}.highlight .s1{color:#d14}.highlight .ss{color:#990073}.highlight .bp{color:#999}.highlight .vc,.highlight .vg,.highlight .vi{color:teal}.highlight .il{color:#099}.highlight .gc{color:#999;background-color:#eaf2f5}.type-csharp .highlight .k,.type-csharp .highlight .kt{color:blue}.type-csharp .highlight .nf{color:#000;font-weight:normal}.type-csharp .highlight .nc{color:#2b91af}.type-csharp .highlight .nn{color:#000}.type-csharp .highlight .s,.type-csharp .highlight .sc{color:#a31515}</style>'

})(jQuery);

// Self-Initializing Behaviour
$(document).ready(function() {
  $('.readme-js').readme({
    'owner': $(this).data('owner'),
    'repo': $(this).data('repo')
  });
});
