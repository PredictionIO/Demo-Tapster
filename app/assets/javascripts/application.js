//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on('page:change', function() {
  var Comic = {
    wrap: $('#comics'),
    comics: [
      {url: 'http://d2me59s95dy7e.cloudfront.net/cartoons/5f/be/6c/1f/030df1b68a4c41f993369af32c09a4ce.jpg'},
      {url: 'http://d2me59s95dy7e.cloudfront.net/cartoons/1e/52/08/3f/f72dc2cd03a14e85bfa6dfb9f85e88c9.jpg'},
      {url: 'http://d2me59s95dy7e.cloudfront.net/cartoons/78/c8/3a/72/e59793d5ab3243e6ad09984b3455251c.jpg'},
      {url: 'http://d2me59s95dy7e.cloudfront.net/cartoons/79/b3/65/10/e0fede2f49974898abe6846fd35c2e06.jpg'},
      {url: 'http://d2me59s95dy7e.cloudfront.net/cartoons/54/d1/fe/12/dd766326fc5a4cb9a0e28a07a765a7c1.jpg'},
      {url: 'http://d2me59s95dy7e.cloudfront.net/cartoons/e0/5c/33/a0/ae3f370959d94166834ab96dc8863405.jpg'},
      {url: 'http://d2me59s95dy7e.cloudfront.net/cartoons/93/2c/a2/eb/b55471d194134f43a1a6a2616a122ffa.jpg'},
      {url: 'http://d2me59s95dy7e.cloudfront.net/cartoons/c0/ff/12/0f/b2ac1846535243a6a17bad8d307e31ad.jpg'},
      {url: 'http://d2me59s95dy7e.cloudfront.net/cartoons/03/63/41/62/f5b5607b659b40a99edff2becc51c8f8.jpg'}
    ],
    add: function(){
      var random = this.comics[Math.floor(Math.random() * this.comics.length)];
      this.wrap.append('<div class="comic"><img alt="" src="' + random.url + '" /></div>');
    }
  };

  var App = {
    smileButton: $('.button.smile a'),
    frownButton: $('.button.frown a'),
    smile: function() {
      $('.comic').eq(0).remove();
      Comic.add();
    },
    frown: function() {
      $('.comic').eq(0).remove();
      Comic.add();
    }
  };

  App.smileButton.on('click', function(e){
    e.preventDefault();
    App.smile();
    console.debug('smile');
  });

  App.frownButton.on('click', function(e){
    e.preventDefault();
    App.frown();
    console.debug('frown');
  });

  Comic.add();
});
