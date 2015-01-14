//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require handlebars
//= require_tree ./templates

$(document).on('page:change', function() {
  // Handlebar templates.
  var debugTemplate = HandlebarsTemplates['debug'];
  var comicTemplate = HandlebarsTemplates['comic'];

  // Our application.
  var App = {
    // jQuery references.
    smileButton: $('.button.smile a'),
    frownButton: $('.button.frown a'),
    comic: $('#comic'),
    loading: $('#loading'),
    debug: $('#debug'),
    // Store like and dislike counts.
    likes: [],
    dislikes: [],
    // Current episode ID.
    episodeId: null,
    // Set a comic passing in a JSON object returned from the server.
    setComic: function(episode) {
      // Set a new current episode ID.
      this.episodeId = episode.episode_id
      // Reload the comic handlebar template with the new episode.
      this.comic.html(comicTemplate(episode));
      this.hideLoading();
      this.refreshDebug();
    },
    // Clear comic.
    clearComic: function() {
      this.comic.empty();
    },
    // Query the server for a comic based on previous likes. See episodes#query.
    queryPIO: function() {
      var _this = this; // For closure.
      $.ajax({
        url: '/episodes/query',
        type: 'POST',
        data: {
          likes: JSON.stringify(_this.likes),
          dislikes: JSON.stringify(_this.dislikes),
        }
      }).done(function(data) {
        _this.setComic(data);
      });
    },
    // Get a random comic from server. See episodes#random.
    randomComic: function() {
      var _this = this; // For closure.
      $.ajax({
        url: '/episodes/random',
      }).done(function(data) {
        _this.setComic(data);
      });
    },
    // Show the loading spinner.
    showLoading: function() {
      $('body').addClass('loading');
      this.clearComic();
      this.loading.show();
    },
    // Hide loading spinner.
    hideLoading: function() {
      this.loading.hide();
      $('body').removeClass('loading');
    },
    // Refresh debug handlbar template.
    refreshDebug: function() {
      this.debug.html(debugTemplate(this));
    },
    // Add episode to list of likes if it's unique.
    addLike: function() {
      if (this.likes.indexOf(this.episodeId) == -1 && this.episodeId) {
        this.likes.push(this.episodeId);
      }
    },
    // Add episode to list of dislikes if it's unique.
    addDislike: function() {
      if (this.dislikes.indexOf(this.episodeId) == -1 && this.episodeId) {
        this.dislikes.push(this.episodeId);
      }
    },
    // Called when user pushes the smile button.
    smile: function() {
      this.showLoading();
      this.addLike();
      this.queryPIO();
    },
    // Called when user pushes the frown button.
    frown: function() {
      this.showLoading();
      this.addDislike();
      this.queryPIO();
    }
  };

  // Event binding for smile button.
  App.smileButton.on('click', function(e){
    e.preventDefault();
    App.smile();
  });

  // Event binding for frown button.
  App.frownButton.on('click', function(e){
    e.preventDefault();
    App.frown();
  });

  // Get a random commic to show the user when the page is loaded.
  App.randomComic();
});
